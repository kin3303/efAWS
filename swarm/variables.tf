variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "EF_INSTALLER_NAME" {
  default = "ElectricFlow-x64-9.0.1.136311"
}
variable "EF_TAG_NAME" {
  default = "latest"
}
variable "AWS_REGION" {
  default = "ap-northeast-2"
}
variable "AMIS" {
  type = "map"
  default = {
    ap-northeast-2 = "ami-f293459c"
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-0d729a60"
  }
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
variable "BOOTSTRAP_NAME" { 
  default = "setup.sh"
}

