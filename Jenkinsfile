pipeline {
    agent any  // Use any available agent

    environment {
        IMAGE_NAME = "thonguyen2749/devops-hello-world:frontend"  // Replace with your desired image name
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')  // DockerHub credentials
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
                    // Build the Docker image for the React app
                    docker.build("${IMAGE_NAME}", ".")
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    // Run the built Docker image in detached mode
                    docker.image("${IMAGE_NAME}").run("-d -p 5000:5000")
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    // Optionally remove dangling images to save space
                    sh 'docker image prune -f'
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
