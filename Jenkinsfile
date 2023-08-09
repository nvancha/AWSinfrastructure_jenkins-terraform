pipeline {
    agent any
    stages {
        stage('Verify Terraform') {
            steps {
                // Check Terraform version to ensure it's installed
                sh 'terraform --version'
                // Print the current directory and list its contents for debugging
                sh 'pwd'
                sh 'ls -al'
            }
        }
        stage('Git Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Terraform init') {
            steps {
                // Initialize Terraform with input set to false to prevent interactive prompts
                sh 'terraform init -no-color -input=false'
            }
        }
        stage('Terraform apply') {
            steps {
                // Generate a plan file
                sh 'terraform plan -out=planfile'
                // Apply Terraform configurations using the plan file, with detailed logging to a file
                sh 'TF_LOG=DEBUG terraform apply -auto-approve -no-color planfile | tee terraform.log
            }
        }
    }
}
