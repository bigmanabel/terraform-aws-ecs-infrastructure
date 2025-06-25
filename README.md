# Terraform AWS ECS Fargate Infrastructure

A comprehensive Terraform configuration for deploying containerized applications
on AWS ECS Fargate with complete CI/CD pipeline, networking infrastructure, and
database setup.

## 🏗️ Architecture

This infrastructure creates a complete, production-ready environment that
includes:

### 🌐 **VPC Module** (`modules/vpc/`)

- **Custom VPC** with configurable CIDR block
- **Public Subnets** across multiple AZs for load balancers
- **Private Subnets** across multiple AZs for ECS tasks and RDS
- **Internet Gateway** for public subnet connectivity
- **NAT Gateways** (one per AZ) for private subnet outbound connectivity
- **Route Tables** with appropriate routing for public/private subnets
- **Security Groups** for public (ALB) and private (RDS) resources

### 🚀 **ECS Fargate Module** (`modules/ecs-fargate/`)

- **ECS Cluster** for running containerized applications
- **ECS Service** with Fargate launch type
- **Application Load Balancer (ALB)** for traffic distribution
- **Target Groups** with health checks
- **Security Groups** for ALB, ECS, and RDS access
- **CloudWatch Log Groups** for application logging

### 🗄️ **Database Infrastructure**

- **RDS PostgreSQL** instance in private subnets
- **DB Subnet Groups** spanning multiple AZs
- **Secrets Manager** integration for secure credential storage

### 🔄 **CI/CD Pipeline**

- **CodePipeline** with CodeStar Connections (GitHub v2 integration)
- **CodeBuild** for containerizing applications
- **ECR Repository** for storing Docker images
- **IAM Roles and Policies** with least-privilege access

## 📁 **Project Structure**

### Main Configuration

```
├── main.tf                 # Module orchestration and resource calls
├── variables.tf            # Input variables for the entire configuration
├── outputs.tf             # Output values from both modules
├── terraform.tfvars       # Variable values and configuration
├── provider.tf            # AWS provider configuration
└── README.md              # This documentation
```

### VPC Module (`modules/vpc/`)

```
├── main.tf                # VPC, subnets, gateways, routing, security groups
├── variables.tf           # VPC-specific input variables
└── outputs.tf             # VPC resource outputs (IDs, CIDR blocks)
```

### ECS Fargate Module (`modules/ecs-fargate/`)

```
├── main.tf                # Empty - resources split into dedicated files
├── variables.tf           # ECS module input variables
├── outputs.tf             # ECS module outputs
├── alb.tf                 # Application Load Balancer resources
├── cloudwatch.tf          # CloudWatch log groups
├── codebuild.tf           # CodeBuild project configuration
├── codepipeline.tf        # CodePipeline and CodeStar Connections
├── ecr.tf                 # ECR repository for Docker images
├── ecs.tf                 # ECS cluster, task definition, service
├── iam.tf                 # IAM roles, policies, attachments
├── rds.tf                 # RDS instance and subnet groups
├── secrets.tf             # AWS Secrets Manager resources
└── security-groups.tf     # Security groups for ALB, ECS, RDS
```

## ⚙️ **Configuration**

### 1. **Prerequisites**

```bash
# Install Terraform
brew install terraform  # macOS
# or
sudo apt-get install terraform  # Ubuntu

# Configure AWS credentials
aws configure
# or export environment variables:
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
```

### 2. **Configure Variables**

Update `terraform.tfvars` with your specific values:

```hcl
# Basic Configuration
aws_region   = "us-east-1"
project_name = "my-nestjs-app"
domain_name  = "api.mycompany.com"

# Network Configuration
vpc_cidr = "10.0.0.0/16"
azs      = ["us-east-1a", "us-east-1b"]

# Application Configuration
image_url = "123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app:latest"

# Database Configuration
db_username = "postgres"
db_password = "super-secure-password-123!"

# CI/CD Configuration
github_repo_url = "https://github.com/myusername/my-nestjs-app.git"
artifact_bucket = "my-company-artifacts-bucket"
github_owner    = "myusername"
github_repo     = "my-nestjs-app"
github_branch   = "main"
```

### 3. **Deploy Infrastructure**

```bash
# Initialize Terraform and download providers/modules
terraform init

# Review the deployment plan
terraform plan

# Deploy the infrastructure
terraform apply
```

## 🔗 **CodeStar Connections Setup**

This configuration uses **AWS CodeStar Connections** (GitHub v2) for secure
repository access:

### **1. Create GitHub Connection**

After `terraform apply`, complete the GitHub connection:

```bash
# Get the connection ARN from outputs
terraform output

# Go to AWS Console > CodePipeline > Settings > Connections
# Find your connection and click "Update pending connection"
# Authorize with GitHub and select repositories
```

### **2. Connection Features**

- ✅ **Secure OAuth-based authentication** (no personal access tokens)
- ✅ **Fine-grained repository permissions**
- ✅ **Webhook-based triggers** for automatic deployments
- ✅ **Support for GitHub organizations and private repositories**

## 🚀 **Application Setup Guide**

### **Step 1: Prepare Your NestJS Project Repository**

1. **Create or use your existing NestJS project repository on GitHub**
2. **Add the following files to your NestJS project root:**

### **Dockerfile** (Add to your NestJS project root)

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

### **buildspec.yml** (Add to your NestJS project root)

> ⚠️ **Important**: This file should be placed in the root directory of your
> NestJS application repository, NOT in this Terraform repository.

The CodeBuild project is pre-configured with all necessary environment
variables:

- `$REPOSITORY_URI` - Your ECR repository URL (automatically set)
- `$IMAGE_TAG` - Docker image tag (set to "latest")
- `$AWS_DEFAULT_REGION` - AWS region for your deployment

```yaml
version: 0.2

phases:
  pre_build:
    commands:
      - echo Logging in to Amazon ECR...
      - aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login
        --username AWS --password-stdin $REPOSITORY_URI
  build:
    commands:
      - echo Build started on `date`
      - echo Building the Docker image...
      - docker build -t $IMAGE_TAG .
      - docker tag $IMAGE_TAG:$IMAGE_TAG $REPOSITORY_URI:$IMAGE_TAG
  post_build:
    commands:
      - echo Build completed on `date`
      - echo Pushing the Docker image...
      - docker push $REPOSITORY_URI:$IMAGE_TAG
      - echo Writing image definitions file...
      - printf '[{"name":"app","imageUri":"%s"}]' $REPOSITORY_URI:$IMAGE_TAG >
        imagedefinitions.json
      - cat imagedefinitions.json
artifacts:
  files:
    - imagedefinitions.json
```

**Environment Variables**: All variables (`$REPOSITORY_URI`, `$IMAGE_TAG`,
`$AWS_DEFAULT_REGION`) are automatically provided by the CodeBuild project
configuration.

### **Step 2: Deploy Infrastructure and Connect GitHub**

1. **Deploy the infrastructure:**

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

2. **Complete GitHub connection:**

   - Go to AWS Console → CodeStar Connections
   - Find your connection and click "Update pending connection"
   - Authorize with GitHub and select your NestJS repository

3. **Test the pipeline:**
   - Push code to your NestJS repository
   - Watch the pipeline execute: Source → Build → Deploy
   - Check ECS service for successful deployment

### **Step 3: Access Your Application**

Your application will be available at the ALB DNS name provided in the Terraform
outputs.

## 📊 **Outputs**

After deployment, you'll receive:

```bash
# Network Information
vpc_id              = "vpc-0123456789abcdef0"
public_subnet_ids   = ["subnet-12345", "subnet-67890"]
private_subnet_ids  = ["subnet-abc123", "subnet-def456"]

# Application Access
alb_dns_name = "my-app-alb-1234567890.us-east-1.elb.amazonaws.com"

# ECS Information
cluster_name        = "my-nestjs-app-cluster"
ecs_service_name    = "my-nestjs-app-service"
task_definition_arn = "arn:aws:ecs:us-east-1:123456789012:task-definition/my-app:1"

# Database Connection
rds_endpoint = "my-app-db.xyz123.us-east-1.rds.amazonaws.com"
rds_port     = 5432
```

## 🔒 **Security Features**

- **Private Subnets**: ECS tasks and RDS run in isolated private subnets
- **Security Groups**: Restrictive ingress/egress rules with least privilege
- **NAT Gateways**: Secure outbound internet access for private resources
- **Secrets Manager**: Database credentials stored securely
- **IAM Roles**: Service-specific roles with minimal required permissions
- **VPC Flow Logs**: Optional network traffic monitoring

## 🧹 **Cleanup**

The infrastructure is now configured with automatic cleanup features:

### **Automatic Cleanup Features**

- ✅ **ECR Repository**: `force_delete = true` - Automatically deletes images
  when destroying
- ✅ **S3 Bucket**: `force_destroy = true` - Automatically empties bucket when
  destroying
- ✅ **Lifecycle Policies**: Automatically cleans up old artifacts after 30 days

### **Manual Destroy**

To destroy the infrastructure:

```bash
terraform destroy
```

The destroy process will now handle:

- Deleting Docker images from ECR
- Emptying and deleting the S3 artifacts bucket
- Removing all other AWS resources

⚠️ **Warning**: This will permanently delete all resources including databases
and stored data.

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch
3. Make your changes following the established patterns
4. Test with `terraform plan`
5. Submit a pull request

## 📝 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file
for details.

---

_Built with ❤️ using Terraform, AWS ECS Fargate, and modern DevOps practices._
