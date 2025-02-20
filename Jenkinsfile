pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'akhilreddyv371/nginx-app:latest'
        KUBE_CONFIG = '/home/jenkins/.kube/config'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/akhilreddyv371/NginxDemo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $DOCKER_IMAGE ."
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId:'DockerCredential', usernameVaribale: 'USERNAMEVAR', passwordVariable: 'PASSWORDVAR')]) {
                    sh 'docker login -u ${USERNAMEVAR} -p ${PASSWORDVAR}'
                    sh 'docker push ${DOCKER_IMAGE}' 
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh "kubectl apply -f k8s/"
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh "kubectl get pods"
            }
        }
    }
}
