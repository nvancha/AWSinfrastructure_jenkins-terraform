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
                sh 'terraform init -no-color -input=false'
            }
        }
        stage('Terraform plan') {
            steps {
                sh 'terraform plan -out=planfile -no-color -input=false'
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply -auto-approve -no-color -input=false'
            }
        }
    }
}
    

