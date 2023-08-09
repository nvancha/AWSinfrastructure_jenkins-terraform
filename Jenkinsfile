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
                script {
                    def result = sh(script: 'terraform init -no-color', returnStatus: true)
                    if (result != 0) {
                        error "Terraform init failed with status code ${result}. Check the logs for more details."
                    }
                }
            }
        }
        stage('Terraform plan') {
            steps {
                script {
                    def result = sh(script: 'terraform plan -out=planfile -no-color', returnStatus: true)
                    if (result != 0) {
                        error "Terraform plan failed with status code ${result}. Check the logs for more details."
                    }
                }
            }
        }
        stage('Terraform apply') {
            steps {
                script {
                    def result = sh(script: 'terraform apply -auto-approve -no-color planfile', returnStatus: true)
                    if (result != 0) {
                        error "Terraform apply failed with status code ${result}. Check the logs for more details."
                    }
                }
            }
        }
    }
}
