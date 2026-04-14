pipeline {
    agent any

    environment {
        IMAGE_NAME = "traffic-dl-project"
        CONTAINER_NAME = "traffic-container"
        PORT = "8888"
    }

    stages {

        // ❌ REMOVED WRONG CLONE STAGE
        // Jenkins already checks out correct repo automatically

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Stop Old Container (if running)') {
            steps {
                bat '''
                docker stop %CONTAINER_NAME% || exit 0
                docker rm %CONTAINER_NAME% || exit 0
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                bat '''
                docker run -d ^
                --name %CONTAINER_NAME% ^
                -p %PORT%:8888 ^
                %IMAGE_NAME%
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                bat 'docker ps'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful! Open http://localhost:8888'
        }
        failure {
            echo '❌ Build failed. Check logs.'
        }
    }
}