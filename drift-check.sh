#!/bin/bash
# drift-check.sh — check all workspaces for drift

WORKSPACES=("default" "dev" "prod")

for WS in "${WORKSPACES[@]}"; do
  echo "================================"
  echo "Checking workspace: $WS"
  echo "================================"
  
  terraform workspace select $WS
  
  if [ "$WS" == "default" ]; then
    VAR_FILE="terraform.tfvars"
  else
    VAR_FILE="${WS}.tfvars"
  fi
  
  terraform plan -var-file=$VAR_FILE -detailed-exitcode
  
  EXIT_CODE=$?
  
  if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ $WS — No drift detected"
  elif [ $EXIT_CODE -eq 2 ]; then
    echo "⚠️  $WS — DRIFT DETECTED! Review changes above"
  else
    echo "❌ $WS — Error running plan"
  fi
  
  echo ""
done

# Return to default
terraform workspace select default
echo "Drift check complete."