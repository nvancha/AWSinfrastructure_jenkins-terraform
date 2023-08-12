pipeline {
    agent any

    stages {
        stage('git checkout') {
            steps {
                checkout scm
            }
        }
        stage('Debugging') {
            steps {
                // print the current directory to ensure we are where we expect
                sh 'pwd'
                // list the files to ensure all terraform files are present
                sh 'ls -al'
            }
        }
        stage('Check Terraform Version') {
            steps {
                sh 'terraform --version'
            }
        }
        stage('Terraform init') {
            steps {
                // We assume your terraform scripts are in the root of your repository. 
                // If they are inside a sub-directory, you should change '.' to the relative path of that directory.
                dir('.') {
                    sh 'terraform init -no-color -input=false'
                }
            }
        }
        stage('Terraform plan') {
            steps {
                dir('.') {
                    sh 'terraform plan -out=planfile -no-color -input=false'
                }
            }
        }
        stage('Terraform apply') {
            steps {
                dir('.') {
                    sh 'terraform apply -auto-approve -no-color -input=false'
                }
            }
        }
    }
}
