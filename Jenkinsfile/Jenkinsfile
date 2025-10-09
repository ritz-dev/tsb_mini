pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'akayti/finance'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        GITHUB_CREDENTIALS = credentials('github-credentials')
        KUBE_CONFIG = 'kubeconfig'
    }

    stages {
        stage ('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/ritz-dev/finance.git',
                    credentialsId: 'github-credentials'
            }
        }

        stage ('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
                }
            }
        }

        stage ('Push To Docker Hub') {
            steps {
                script {
                    sh """
                        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                        docker push $DOCKER_IMAGE:$BUILD_NUMBER
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_FILE')]) {
                   script {
                        sh """
                            export KUBECONFIG=$KUBECONFIG_FILE
                            kubectl set image deployment/finance-deployment finance-container=$DOCKER_IMAGE:$BUILD_NUMBER -n sms-app
                            kubectl rollout status deployment/finance-deployment -n sms-app
                        """
                   }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}