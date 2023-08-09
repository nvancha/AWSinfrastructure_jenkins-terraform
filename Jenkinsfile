pipeline {
    agent any
    stages {
        stage('git checkout') {
            steps {
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
