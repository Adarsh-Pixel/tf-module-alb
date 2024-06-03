# Creates Application Load Balancer

resource "aws_lb" "alb" {
  name               = var.ALB_NAME
  internal           = var.INTERNAL
  load_balancer_type = "application"
  security_groups    = var.INTERNAL ? aws_security_group.alb_private.*.id : aws_security_group.alb_public.*.id
  subnets            = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS : data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_IDS

  tags = {
    NAME = var.ALB_NAME
  }
}

# Creates listerner for the PRIVATE ALB

# This creates the listernr and adds to the PRIVATE ALB
resource "aws_lb_listener" "private" {
  count             = var.INTERNAL ? 1 : 0 
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    target_group_arn = aws_lb_target_group.app.arn
  }
}