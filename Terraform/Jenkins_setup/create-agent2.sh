terraform fmt
terraform init

terraform workspace select agent2 || terraform workspace new agent2
terraform plan 
terraform apply --auto-approve