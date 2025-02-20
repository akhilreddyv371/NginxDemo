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
                script{
                    withCredentials([usernamePassword(credentialsId:'DockerCredential', usernameVaribale: 'USERNAME_VAR', passwordVariable: 'PASSWORD_VAR')]) {
                        sh 'docker login -u ${USERNAME_VAR} -p ${PASSWORD_VAR}'
                        sh 'docker push ${DOCKER_IMAGE}' 
                    }
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
