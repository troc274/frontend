pipeline {
    agent any
    environment {
        IMAGE_NAME = "thonguyen2749/devops-hello-world:frontend"  // Replace with your Docker image name
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

        stage('Deploy and Run') {
            steps {
                script {
                    // Stop and remove the container if it is running
                    sh '''
                    if [ $(docker ps -q -f name=${IMAGE_NAME}) ]; then
                        echo "Stopping existing container..."
                        docker stop ${IMAGE_NAME}
                        docker rm ${IMAGE_NAME}
                    else
                        echo "No running container found with the name ${IMAGE_NAME}."
                    fi
                    '''
                    // Run the container to serve the application
                    sh "docker run -d --name react-app -p 3000:80 ${IMAGE_NAME}"
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
