virginia_cidr = "10.10.0.0/16"
#ublic_subnet = "10.10.0.0/24"
#private_subnet = "10.10.1.0/24"
subnet = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "env"         = "Dev"
  "owner"       = "Marce"
  "cloud"       = "AWS"
  "IAC"         = "Terraform"
  "IAC_version" = "v1.12.2"
  "proyecto"    = "CursoTerraform"
  "region"      = "Nort_Virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-0cbbe2c6a1bb2ad63"
  "instance_type" = "t2.micro"
}

enable_monitoring = 0