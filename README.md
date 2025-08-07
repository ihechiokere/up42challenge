# UP42 Senior Cloud Engineer Challenge Solution

This solution implements a production-ready deployment of the s3www application with MinIO storage using Helm charts and Terraform infrastructure as code.

## Architecture Overview

- **s3www**: Go-based web server for serving files from S3-compatible storage
- **MinIO**: S3-compatible object storage for local development
- **Helm**: Package management and templating for Kubernetes resources
- **Terraform**: Infrastructure as code for deployment orchestration
- **Metrics Server**: Resource monitoring and metrics collection

## Prerequisites

- Kubernetes cluster (Minikube, Docker Desktop, or similar)
- Helm 3.x
- Terraform 1.0+
- kubectl configured for your cluster

## Deployment Options

### Option 1: Full Automated Deployment

Deploy everything in one command:

```bash
# Make script executable and deploy
chmod +x scripts/terraform-deploy.sh
./scripts/terraform-deploy.sh
```

### Option 2: Step-by-Step Deployment (Recommended)

For better control and understanding of the deployment process:

```bash
# 1. Plan the infrastructure deployment
chmod +x scripts/terraform-plan.sh
./scripts/terraform-plan.sh

# 2. Apply the planned changes
chmod +x scripts/terraform-apply.sh
./scripts/terraform-apply.sh

# 3. Initialize content in MinIO
chmod +x scripts/init-content.sh
./scripts/init-content.sh
```

## Accessing the Application

After successful deployment, access the s3www application:

```bash
# Port-forward for local access
kubectl port-forward -n s3www-dev svc/s3www-service 8080:80

# Or use minikube service (for Minikube)
minikube service s3www-service -n s3www-dev

# Then open in browser or test with curl
curl http://localhost:8080
```