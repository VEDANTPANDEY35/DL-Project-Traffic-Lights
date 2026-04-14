pipeline {
    agent any

    environment {
        IMAGE_NAME = "traffic-dl-project"
        CONTAINER_NAME = "traffic-container"
        PORT = "8888"
    }

    stages {

        stage('Build Docker Image (No Cache)') {
            steps {
                bat 'docker build --no-cache -t %IMAGE_NAME% .'
            }
        }

        stage('Stop Old Container') {
            steps {
                bat '''
                docker stop %CONTAINER_NAME% || exit 0
                docker rm %CONTAINER_NAME% || exit 0
                '''
            }
        }

        stage('Remove Old Image (Optional Clean)') {
            steps {
                bat '''
                docker rmi %IMAGE_NAME% || exit 0
                '''
            }
        }

        stage('Rebuild Docker Image') {
            steps {
                bat 'docker build --no-cache -t %IMAGE_NAME% .'
            }
        }

        stage('Run Docker Container') {
            steps {
                bat '''
                docker run -d ^
                --name %CONTAINER_NAME% ^
                -p %PORT%:8888 ^
                -v "%WORKSPACE%:/app" ^
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