pipeline {
    agent none  // Disable the default agent at the pipeline level
    stages {
        stage('React Build') {
            agent {
                label 'react-agent'  // Use the label defined for the `jenkins-slave-react` agent in docker-compose
            }
            steps {
                // Checkout the repository
                checkout scm

                // Install dependencies and build the project
                script {
                    echo 'Installing dependencies...'
                    sh 'npm install'  // Ensure npm is installed on the react-slave image

                    echo 'Building the project...'
                    sh 'npm run build'
                }
            }
        }

        stage('Deploy to Nginx') {
            agent {
                label 'react-agent'  // Use the same agent for deploying
            }
            steps {
                // Copy the built files to the frontend dist directory for Nginx
                script {
                    echo 'Deploying to Nginx...'
                    sh 'npm install -g serve && serve -s dist -l 3000 '
                }
            }
        }
    }

    post {
        success {
            echo 'Build and deployment completed successfully.'
        }
        failure {
            echo 'There was a failure in the build or deployment process.'
        }
    }
}
