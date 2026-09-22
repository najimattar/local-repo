terraform fmt
terraform init

terraform workspace new dev
terraform workspace list
terraform plan 
terraform apply --auto-approve

terraform fmt
terraform workspace new stage
terraform workspace list
terraform plan 
terraform apply --auto-approve

terraform fmt
terraform workspace new prod
terraform workspace list
terraform plan 
terraform apply --auto-approve