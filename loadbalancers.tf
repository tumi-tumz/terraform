# Create a Load Balancer to route traffic to Web server
resource "aws_lb" "alb" {
  name = "Custom-ALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.lb.id]
  subnets = [aws_subnet.public1.id, aws_subnet.public1.id]
  enable_deletion_protection = true

  tags = {
      Environment = "Production"
  }
}
