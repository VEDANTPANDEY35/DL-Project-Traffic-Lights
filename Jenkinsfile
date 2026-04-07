pipeline {
    agent any

    environment {
        IMAGE_NAME = "traffic-dl-project"
        CONTAINER_NAME = "traffic-container"
        PORT = "8888"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git 'https://github.com/Devhuti451/DL-Project-Traffic-Lights.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Stop Old Container (if running)') {
            steps {
                sh '''
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                docker run -d \
                --name $CONTAINER_NAME \
                -p $PORT:8888 \
                $IMAGE_NAME
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'docker ps'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful! Jupyter Notebook is running on port 8888.'
        }
        failure {
            echo '❌ Build failed. Check logs.'
        }
    }
}
