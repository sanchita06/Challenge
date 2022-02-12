
# EC2 Instance
resource "aws_instance" "web_server" {

    ami                         = var.amis
    instance_type               = var.instance_type
    subnet_id                   = var.public_subnet_1
    associate_public_ip_address = true
    key_name                    = "mykp"
    vpc_security_group_ids      = [var.output_allow_all]

    tags                        = {
        Name = "web_server"
    }  
}

#Subnet

resource "aws_instance" "instance_private_subnet_1" {

    ami                         = var.amis
    instance_type               = var.instance_type
    subnet_id                   = var.private_subnet_1
    key_name                    = "mykp"
    vpc_security_group_ids      = [
                                  var.output_allow_all,
                                  var.output_private_sg
                                  
    ]
    tags                        = {
        Name                    = "instance_private_subnet_1"
    }
  
}

resource "aws_instance" "instance_private_subnet_2" {

    ami                         = var.amis
    instance_type               = var.instance_type
    subnet_id                   = var.private_subnet_4
    key_name                    = "mykp"
    vpc_security_group_ids      = [
                                  var.output_allow_all,
                                  var.output_private_sg
                                  
    ]
    tags                        = {
        Name                    = "instance_private_subnet_2"
    }
  
}


