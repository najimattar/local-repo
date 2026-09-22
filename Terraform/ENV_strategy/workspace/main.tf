module "ec2" {
  source = "./module/ec2/"

  ami_id        = var.ami_id[local.env]
  instance_type = var.instance_type[local.env]
  name          = "${local.env}-server"
  env           = local.env

}