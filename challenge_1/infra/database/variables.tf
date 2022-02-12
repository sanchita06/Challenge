variable "private_subnet_1" {}
variable "private_subnet_2" {}
variable "output_db_subnet_group" {}
variable "output_database_sg" {}

variable "out_tg_instances" {}
variable "internaltg" {}

variable "public_subnet_1" {}
variable "public_subnet_2" {}

variable "amis" {
    
    default = "ami-033b95fb8079dc481"
  
}
variable "instance_type" {

    default = "t2.micro"
  
}
variable "output_web_sg" {} 
variable "external_alb_sg" {} 
variable "output_allow_all" {}   
variable "output_internal_alb_sg" {}

