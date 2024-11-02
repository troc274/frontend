pipeline {
    agent {
        label 'react-agent'  // Assign to the specific Jenkins slave for building React
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm  // Pulls the code from the connected SCM repository
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
    }
}