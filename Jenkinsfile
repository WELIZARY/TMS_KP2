pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Сборка') {
            steps {
                sh 'docker build -t quote-generator:latest .'
            }
        }

        stage('Проверка работы') {
            steps {
                sh '''
                    docker run -d --name quote-test -p 5002:5000 quote-generator:latest
                    sleep 3
                    curl -f http://localhost:5002/health
                    docker stop quote-test
                    docker rm quote-test
                '''
            }
        }

        stage('Деплоим!') {
            steps {
                sh '''
                    docker compose down || true
                    docker compose up -d
                    sleep 3
                    curl -f http://localhost:5000/health
                    curl -f http://localhost:5001/health
                '''
            }
        }
    }

    post {
        success {
            echo 'пайплайн успешно завершен'
        }
        failure {
            sh 'docker stop quote-test || true && docker rm quote-test || true'
            echo 'пайплайн сломался'
        }
    }
}
