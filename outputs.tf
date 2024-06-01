output "ALB_ARN" {
    value = aws_lb.alb.arn
}

output "ALB_ADDRESS" {
    value = aws_lb.alb.dns_name
}