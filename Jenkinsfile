pipeline {
    agent any // Run on any available agent
    stages {
        stage('git checkout') {
            steps {
                // Example shell commands
                bat "echo 'Hello, World!'" // For Windows agents
                sh "echo 'Hello, World!'"  // For Unix/Linux agents
                checkout scm
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init -no-color'
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply -auto-approve -no-color'
            }
        }
    }
}
