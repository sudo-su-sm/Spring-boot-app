pipeline {
    agent any
    stages {
        stage('Gitleaks scan'){
            steps {
                sh 'gitleaks detect --source=. --report-path=gitleaks-report.json || true'
                // archiveArtifacts artifacts: 'gitleaks-report.json', allowEmptyArchive: true
            }
        }

        stage('build code using maven'){
            steps {
                // withDockerContainer('maven:3.9.9-eclipse-temurin-17-alpine') {   ## This can be used if you have docker and docker pipeline plugin installed on jenkins server
                    sh 'mvn clean package'
                // }
            }
        }

        stage('OWASP Dependency-Check Vulnerabilities') {
            steps {
                dependencyCheck additionalArguments: ''' 
                            -o './'
                            -s './'
                            -f 'ALL' 
                            --prettyPrint''', odcInstallation: 'OWASP Dependency-Check Vulnerabilities'
                
                dependencyCheckPublisher pattern: 'dependency-check-report.xml'
            }
            }


//         stage('docker build image'){
//             steps{
//                 sh ' docker build -t awslinux88/docker-automation:v1 . '
//             }
//         }

//         stage('docker push image to docker hub'){
//             steps{
//                 withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
//                  sh ' docker push awslinux88/docker-automation:v1 '
//                 }
                
//             }
//         }
    }
} 
