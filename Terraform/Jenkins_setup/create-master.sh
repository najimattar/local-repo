terraform fmt
terraform init

terraform workspace select master
terraform plan 
terraform apply --auto-approve