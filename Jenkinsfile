pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = credentials('b6d863d8-ad57-4775-b6f9-4b2b6c46be9e')
        DOCKER_HUB_USERNAME = 'thonguyen2749'
        FRONTEND_IMAGE = "${DOCKER_HUB_USERNAME}/devops-frontend"
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the Git repository and get the commit ID
                checkout scm
                script {
                    COMMIT_ID = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                }
            }
        }

        stage('Build and Push Frontend Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS_ID) {
                        // Build the Docker image with the commit ID as a tag
                        def frontendImage = docker.build("${FRONTEND_IMAGE}:${COMMIT_ID}", '.')

                        // Push the image with the commit ID as the tag
                        frontendImage.push("${COMMIT_ID}")

                        // Optionally push with "latest" tag as well
                        frontendImage.push('latest')
                    }
                }
            }
        }

        // stage('Deploy Frontend') {
        //     steps {
        //         script {
        //             // Deploy with Docker Compose or other method if required
        //             sh 'docker-compose up -d frontend'
        //         }
        //     }
        // }
    }

    post {
        success {
            echo 'Frontend pipeline completed successfully!'
        }
        failure {
            echo 'Frontend pipeline failed.'
        }
    }
}
