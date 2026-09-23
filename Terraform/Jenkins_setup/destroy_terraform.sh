
terraform workspace select master
terraform destroy --auto-approve

terraform workspace select agent1
terraform destroy --auto-approve


terraform workspace select agent2
terraform destroy --auto-approve