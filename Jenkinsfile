pipeline {
    agent any
    stages {
        stage('Gitleaks scan'){
            steps {
                sh 'gitleaks detect --source=. --report-path=gitleaks-report.json || true'
                // archiveArtifacts artifacts: 'gitleaks-report.json', allowEmptyArchive: true
            }
        }

        stage('OWASP Dependency Check Scan'){
            steps {
                sh 'mvn org.owasp:dependency-check-maven:check -Dformat=ALL'
                // archiveArtifacts artifacts: 'dependency-check-report.*', allowEmptyArchive: true
            }
        }

        stage('build code using maven'){
            steps {
                 withDockerContainer('maven:3.9.9-eclipse-temurin-17-alpine') {
                    sh 'mvn clean package'
                 }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQubeServer') {
                    sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=sudo-su-sm_Spring-boot-app -Dsonar.organization=sudo-su-sm'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('docker build image'){
            steps{
                sh ' docker build -t awslinux88/docker-automation:${BUILD_NUMBER} . '
            }
        }

        stage('Trivy Image Scan') {
            steps {
                sh "trivy image --format json -o trivy-report.json awslinux88/docker-automation:v1:${BUILD_NUMBER} || true"
                // archiveArtifacts 'trivy-report.json'
            }
        }

        stage('docker push image to docker hub'){
            steps{
                withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                 sh ' docker push awslinux88/docker-automation:${BUILD_NUMBER} '
                }
            }
        }
    }
} 
