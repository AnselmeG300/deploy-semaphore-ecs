resource "aws_security_group" "semaphore_front_sg" {
  vpc_id      = aws_vpc.semaphore.id
  name        = "Semaphore-Front-SG"
  description = "Semaphore SG Fargate"
  
  ingress {
    protocol    = "tcp"
    from_port   = 3000
    to_port     = 3000
    security_groups = [ aws_security_group.semaphore_alb_sg.id ]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["13.37.32.161/32", "51.44.6.46/32"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}


resource "aws_security_group" "semaphore_db_sg" {
  vpc_id      = aws_vpc.semaphore.id
  name        = "Semaphore-BD-SG"
  description = "MySQL SG Fargate"
  ingress {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
    security_groups = [ aws_security_group.semaphore_front_sg.id ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "semaphore_alb_sg" {
  vpc_id      = aws_vpc.semaphore.id
  name        = "Semaphore-ALB-SG"
  description = "Semaphore ALB SG to allow all connection from ECS Cluster"
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

