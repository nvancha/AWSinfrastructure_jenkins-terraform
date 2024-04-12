# AWS Infrastructure Automation

This project uses Terraform for infrastructure as code (IaC) to define and provision a cloud infrastructure on AWS, and a Jenkins pipeline for continuous integration and continuous deployment (CI/CD) to automate the deployment process.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Jenkins Pipeline Steps](#jenkins-pipeline-steps)
- [Terraform Architecture](#terraform-architecture)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Repository Structure](#repository-structure)
- [Contributing](#contributing)
- [License](#license)
- [Authors](#authors)
- [Acknowledgments](#acknowledgments)

## Prerequisites

- **Jenkins**: A running Jenkins instance with the necessary plugins installed (Pipeline, Git, AWS).
- **Terraform**: Terraform must be installed on the machine where Jenkins runs.
- **AWS Account**: Properly configured AWS CLI with administrative access to create and manage AWS resources.
- **IAM Credentials**: AWS IAM credentials with the necessary permissions configured in Jenkins.

## Jenkins Pipeline Steps

The Jenkinsfile defines the CI/CD pipeline with the following stages:

1. `git checkout`: Clones the repository to ensure the latest code is used for the deployment.
2. `Debugging`: Confirms the workspace is correctly set up by listing all files in the current directory.
3. `Check Terraform Version`: Ensures the correct Terraform version is being used for compatibility.
4. `Terraform init`: Initializes Terraform, installs required providers, and prepares the workspace.
5. `Terraform plan`: Creates an execution plan to show what actions Terraform will perform.
6. `Terraform apply`: Applies the changes to AWS to create or update the infrastructure.

## Terraform Architecture

The Terraform configuration sets up the following AWS resources:

- **VPC (Virtual Private Cloud)**: Establishes an isolated network environment.
- **Internet Gateway**: Provides a gateway for communication between resources within the VPC and the internet.
- **Subnets**: Public and private subnets for network partitioning and controlled access.
- **Route Tables**: Directs network traffic within the VPC.
- **Network ACLs**: Firewall rules to control traffic at the subnet level.

## Getting Started

1. Set up your Jenkins server and ensure the required plugins are installed.
2. Configure your AWS CLI and IAM credentials on your Jenkins server.
3. Create a new Jenkins job and link it to the `Jenkinsfile` in this repository.
4. Execute the job to start the CI/CD pipeline.

## Usage

Interact with the Jenkins pipeline to control the provisioning of your infrastructure. Push changes to your repository to trigger the pipeline, or run it manually through the Jenkins interface.

## Repository Structure

- `.terraform.lock.hcl` - Terraform's dependency lock file.
- `Jenkinsfile` - The Jenkins pipeline script.
- `*.tf` - Terraform configuration files for defining AWS resources.
- `terraform.exe` - Executable for Terraform (note: typically not included in source control).
- `terraform.tfstate` - Terraform's state file (note: should be managed via remote state in production).
- `vpc_setup.tf` - Specific Terraform configuration for VPC setup.

## Contributing

Contributions to this project are welcome. Please adhere to conventional commit messages and ensure that a Terraform plan is included in your pull requests for visibility into changes.

## Created by Nipuna Vancha.
