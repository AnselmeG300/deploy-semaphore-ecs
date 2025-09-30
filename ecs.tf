resource "aws_ecs_cluster" "semaphore" {
  name = "semaphore"
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}


resource "aws_ecs_task_definition" "semaphore_front" {
  
  family                   = "semaphore-front"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = file("container-definitions/semaphore-front.json")
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
}


resource "aws_ecs_task_definition" "semaphore_db" {
  
  family                   = "semaphore-db"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "1024"
  container_definitions    = file("container-definitions/semaphore-db.json")
  execution_role_arn       = aws_iam_role.ecs_task_role.arn

  volume {
    name = "ebs-semaphore-volume"
    configure_at_launch = true
  }

  ephemeral_storage {
    size_in_gib = 50
  }
}


resource "aws_ecs_service" "semaphore_front" {

  depends_on = [
    aws_iam_role_policy_attachment.ecs_secrets_attachment,
    aws_iam_role_policy_attachment.ecs_awslogs_attachment
  ]
  
  name             = "semaphore-front"
  cluster          = aws_ecs_cluster.semaphore.id
  task_definition  = aws_ecs_task_definition.semaphore_front.arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "1.4.0"


  network_configuration {
    security_groups = [
      aws_security_group.semaphore_front_sg.id
    ]
    subnets = var.activated_auto_scaling ? [
      aws_subnet.private_subnet.id,
      aws_subnet.private_subnet1[0].id,
      ] : [
      aws_subnet.private_subnet.id,
    ]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.semaphore_lb_tg.arn
    container_name   = "semaphore-front"
    container_port   = 3000
  }

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

}


resource "aws_ecs_service" "semaphore_db" {

  depends_on = [
    aws_iam_role_policy_attachment.ecs_secrets_attachment,
    aws_iam_role_policy_attachment.ecs_awslogs_attachment,
    aws_iam_role_policy_attachment.ecs_ebs_attachment,
    aws_iam_role.ecs_task_role,
  ]

  name             = "semaphore-db"
  cluster          = aws_ecs_cluster.semaphore.id
  task_definition  = aws_ecs_task_definition.semaphore_db.arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "1.4.0"

  network_configuration {
    security_groups = [
      aws_security_group.semaphore_db_sg.id
    ]
    subnets = [
      aws_subnet.private_subnet.id
    ]
    assign_public_ip = false
  }

  service_registries {
    registry_arn   = aws_service_discovery_service.semaphore_db.arn
    container_name = "semaphore-db"
  }

  volume_configuration {
    name = "ebs-semaphore-volume"
    managed_ebs_volume {
      role_arn = aws_iam_role.ecs_task_role.arn
      size_in_gb = 50
      file_system_type = "ext4"
      snapshot_id = var.snapshot_id
    }
  }

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
}
