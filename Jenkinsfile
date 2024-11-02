pipeline {
    agent any
    environment {
        IMAGE_NAME = "myusername/my-frontend-app"  // Replace with your Docker image name
        DOCKERHUB_CREDENTIALS = credentials('8eb68f23-6497-4663-a47e-7f7045461567')  // Use your DockerHub credentials ID in Jenkins
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Check out the code from the repository
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the repository
                    docker.build("${IMAGE_NAME}", ".")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub and push the image
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKERHUB_CREDENTIALS}") {
                        docker.image("${IMAGE_NAME}").push("latest")
                    }
                }
            }
        }

        stage('Deploy and Run') {
            steps {
                script {
                    // Run the container to serve the application
                    docker.image("${IMAGE_NAME}").run("-d -p 8081:8081")
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution complete.'
        }
        failure {
            echo 'The build or deployment failed.'
        }
    }
}
