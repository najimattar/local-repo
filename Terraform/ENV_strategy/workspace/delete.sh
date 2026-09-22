terraform workspace select dev
terraform workspace list
terraform destroy --auto-approve

terraform workspace select stage
terraform workspace list
terraform destroy --auto-approve

terraform workspace select prod
terraform workspace list
terraform destroy --auto-approve