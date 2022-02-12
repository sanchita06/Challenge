resource "aws_lb" "felb" {
  name               = "fe-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_deletion_protection = true

  tags = {
    Environment = "test"
  }
}

output "output_felb" {
  value = aws_lb.felb.arn
}


resource "aws_lb_target_group" "fe_tg" {
  name     = "te-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

output "output_fe_tg" {
  value = aws_lb_target_group.fe_tg.arn

}

resource "aws_lb" "alb_app" {

    name               = "app_lbr"
    load_balancer_type = "application"
    subnets            = ["10.0.1.0/24", "10.0.2.0/24"] 
    security_groups    = [var.internal_alb_sg]
    enable_deletion_protection = true
    tags               = {
        
    Environment        = "test"
    }
  
}

output "output_albweb" {
  value = aws_lb.alb_app.arn
}


# Missing IP address of the Instances, Health Checks, tags
resource "aws_lb_target_group" "tg" {
    name     = "IP-lb-instancetype-tg"
    port     = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id   = var.vpc_id
    
}

output "out_tg_instances" {  # to register the instance in the ALB
  value = aws_lb_target_group.tg.arn
}

resource "aws_lb_listener" "external_listener_web" {

    load_balancer_arn = aws_lb.albweb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.tg.arn  
    }
  
}
