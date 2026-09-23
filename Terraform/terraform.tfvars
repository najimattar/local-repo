ami_id = "ami-0b6d9d3d33ba97d99"

instance_type = {
  master = "t3.small"
  agent1 = "t3.small"
  agent2 = "t3.small"
}

security_group = {
  agent1 = ["sg-01e95cc0fb52d4a7d"]
  agent2 = ["sg-01e95cc0fb52d4a7d"]
  master = ["sg-0576338cf362995e2"]
}