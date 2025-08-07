#!/bin/bash
# Deploy s3www infrastructure using Terraform

set -e

# Configuration
ENVIRONMENT="${ENVIRONMENT:-dev}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TERRAFORM_DIR="$PROJECT_ROOT/terraform/$ENVIRONMENT"
CONFIG_FILE="$PROJECT_ROOT/config/$ENVIRONMENT.tfvars.json"

echo "=== UP42 Challenge - Terraform Deploy ==="
echo "Environment: $ENVIRONMENT"
echo "Terraform dir: $TERRAFORM_DIR"
echo "Config file: $CONFIG_FILE"
echo

# Check if terraform directory exists
if [ ! -d "$TERRAFORM_DIR" ]; then
    echo "Error: Terraform directory $TERRAFORM_DIR not found"
    exit 1
fi

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file $CONFIG_FILE not found"
    exit 1
fi

# Change to terraform directory
cd "$TERRAFORM_DIR"

echo "Initializing Terraform..."
terraform init

echo
echo "Planning deployment..."
terraform plan -var-file="$CONFIG_FILE"

echo
echo "Applying deployment..."
terraform apply -var-file="$CONFIG_FILE" -auto-approve

echo
echo "Deployment complete"
echo
echo "Next steps:"
echo "1. Run content initialization: $SCRIPT_DIR/init-content.sh"
echo "2. Port-forward to access: kubectl port-forward -n s3www-$ENVIRONMENT svc/s3www-service 8080:80"
echo "3. Open browser: http://localhost:8080"