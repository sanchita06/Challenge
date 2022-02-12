variable "amis" {
    
    default = "ami-033b95fb8079dc481"
  
}

variable "instance_type" {

    default = "t2.micro"
  
}

variable "public_subnet_1" {}
variable "output_allow_all" {}
variable "private_subnet_1" {}
variable "private_subnet_2" {}
variable "output_private_sg" {}
variable "output_public_sg" {}

