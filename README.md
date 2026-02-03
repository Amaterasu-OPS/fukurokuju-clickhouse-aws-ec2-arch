<samp><h6 align="center">#infrastructure, #project, #clickhouse, #AWS</h6></samp>
# <samp align="center"><h2 align="center">Fukurokuju Clickhouse AWS EC2</h2></samp>

<p align="center">
  <img src="https://img.shields.io/badge/terragrunt-22272E?&style=for-the-badge&logo=hcl&logoColor=ffffff">
  <img src="https://img.shields.io/badge/terraform-22272E?&style=for-the-badge&logo=terraform&logoColor=844FBA">
</p>
<br/>

## Overview

This repository contains a Terragrunt-based infrastructure as code (IaC) solution for deploying a ClickHouse cluster on AWS using EC2 instances. The project leverages Terragrunt's DRY principles to manage Terraform configurations efficiently, providing a scalable and maintainable approach to provisioning ClickHouse database infrastructure.

### Features

- **Automated ClickHouse Cluster Deployment**: Provision a fully functional ClickHouse cluster on AWS EC2
- **Terragrunt-Powered**: Utilizes Terragrunt for managing Terraform configurations with DRY principles
- **Remote State Management**: S3 backend with DynamoDB state locking for safe collaborative infrastructure management
- **Modular Architecture**: Clean separation of concerns with reusable Terraform modules
- **Environment Configuration**: Flexible configuration through environment variables
- **SSH Key Management**: Automated SSH key pair generation and management for secure cluster access

### Architecture

The infrastructure is organized using Terragrunt's hierarchical structure:

- **Root Configuration** (`root.hcl`): Defines common settings, AWS provider configuration, and remote state backend
- **Node Module** (`node/`): Manages EC2 instance provisioning and SSH key configuration for ClickHouse nodes

### Prerequisites

- [Terragrunt](https://terragrunt.gruntwork.io/) (latest version)
- [Terraform](https://www.terraform.io/) (compatible version)
- AWS Account with appropriate permissions
- AWS credentials configured (via environment variables or AWS CLI)

### Getting Started

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd fukurokuju-clickhouse-aws-ec2-arch
   ```

2. **Configure environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your AWS credentials and configuration
   ```

3. **Initialize and plan**
   ```bash
   terragrunt run-all init
   terragrunt run-all plan
   ```

4. **Deploy the infrastructure**
   ```bash
   terragrunt run-all apply
   ```

### Configuration

The project uses environment variables for AWS configuration:
- `AWS_REGION`: Target AWS region (default: us-east-1)
- `AWS_ACCESS_KEY_ID`: AWS access key
- `AWS_SECRET_ACCESS_KEY`: AWS secret key

### Remote State

State files are stored in S3 with DynamoDB locking:
- **Bucket**: `S3_BUCKET`
- **DynamoDB Table**: `DYNAMODB_TABLE_LOCK`
- **Encryption**: Enabled



## Contribute

Want to be part of this project?

Whether it’s improving documentation, fixing bugs, or adding new features — your help is always welcome.

Just fork the repo, make your changes, and open a pull request. Let’s build something great together!

## License
MIT License. See `LICENSE` file for details.
