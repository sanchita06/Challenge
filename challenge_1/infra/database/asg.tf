resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}

resource "aws_launch_configuration" "fe_lc" {

    name                       = "fe_Launch_config"
    image_id                   = var.amis
    instance_type              = var.instance_type
    security_groups            = [
                                 var.external_alb_sg,
                                 var.output_allow_all,
                                  ]

    associate_public_ip_address = true
    key_name                   = "mykp"
  
}

output "web_lc_name" {
  value = aws_launch_configuration.fe_lc.name
}


resource "aws_autoscaling_group" "fe_asg" {
  name                      = "fed_asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 4
  force_delete              = true
  placement_group           = aws_placement_group.test.id
  launch_configuration      = aws_launch_configuration.fe_lc.name
  vpc_zone_identifier       = [var.public_subnet_1,var.public_subnet_2]

  initial_lifecycle_hook {
    name                 = "fed_asg"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
  }

  timeouts {
    delete = "15m"
  }
}


resource "aws_launch_configuration" "app_lc" {

    name                       = "app_launch_config"
    image_id                   = var.amis
    instance_type              = var.instance_type
    security_groups            = [
                                 var.output_internal_alb_sg,
                                 var.output_allow_all,
                                  ]


    key_name                   = "mykp"
  
}

output "app_lc_name" {
  value = aws_launch_configuration.app_lc.name
}

resource "aws_autoscaling_group" "app_asg" {
  name                      = "app_asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 4
  force_delete              = true
  placement_group           = aws_placement_group.test.id
  launch_configuration      = aws_launch_configuration.app_lc.name
  vpc_zone_identifier       = [var.public_subnet_1,var.public_subnet_2]

  initial_lifecycle_hook {
    name                 = "app_asg"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
  }

  timeouts {
    delete = "15m"
  }
}