terraform fmt
terraform init

terraform workspace select agent1 || terraform workspace new agent1
terraform plan 
terraform apply --auto-approve