pipeline {
    agent any
    stages {
        stage('Gitleaks scan'){
            steps {
                sh 'docker run --rm -v $(pwd):/repo zricethezav/gitleaks:latest detect /repo --no-git'
                // archiveArtifacts artifacts: 'gitleaks-report.json', allowEmptyArchive: true
            }
        }

//         stage('OWASP Dependency Check Scan'){
//             steps {
//                 sh 'dependency-check.sh --project "spring-boot-app" --scan . --format "ALL" --out . || true'
//                 archiveArtifacts artifacts: 'dependency-check-report.*', allowEmptyArchive: true
//             }
//         }

//         stage('build code using maven'){
//             steps {
//                 withDockerContainer('maven:3.9.9-eclipse-temurin-17-alpine') {
//                     sh 'mvn clean package'
//                 }
//             }
//         }

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
