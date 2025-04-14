terraform {
  backend "s3" {
    bucket = "remote-file-kishor"
    key = "tools/state"
    region = "us-east-1"
  }
}

variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
}
# variable "instance_type" {
#     default = "t3.small"
# }
variable "zone_id" {
  default = "Z10310253KPZLFJOC7YEK"
}

variable "tools" {
  default = {
    vault ={
        instance_type = "t3.small"
        port = 8200
    }

    github-runner = {
      instance_type= "t3.small"
      port= 443
    }
  }
}


module "tool_infra" {
  source = "./module-infra"
  for_each = var.tools

  ami_id = var.ami_id
  instance_type = each.value["instance_type"]
  name = each.key
  zone_id = var.zone_id
  port = each.value["port"]

}