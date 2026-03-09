#!/bin/bash

# Get current workspace
WORKSPACE=$(terraform workspace show)

# Handle default workspace
if [ "$WORKSPACE" == "default" ]; then
  VAR_FILE="terraform.tfvars"
else
  VAR_FILE="${WORKSPACE}.tfvars"
fi

echo "Current workspace: $WORKSPACE"
echo "Using var-file: $VAR_FILE"
echo "-----------------------------------"

# Validate var-file exists
if [ ! -f "$VAR_FILE" ]; then
  echo "ERROR: $VAR_FILE not found!"
  echo "Available tfvars files:"
  ls *.tfvars
  return 1
fi

# Run fmt and validate first
terraform fmt && terraform validate

if [ $? -ne 0 ]; then
  echo "ERROR: fmt/validate failed. Fix errors before applying."
  return 1
fi

# Plan first
terraform plan -var-file=$VAR_FILE

# Confirm before apply
read -p "Do you want to apply? (yes/no): " CONFIRM

if [ "$CONFIRM" == "yes" ]; then
  terraform apply -var-file=$VAR_FILE -auto-approve
else
  echo "Apply cancelled."
fi