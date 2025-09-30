resource "aws_service_discovery_private_dns_namespace" "private" {
  name        = "mysql-semaphore"
  description = "Private dns namespace for service discovery"
  vpc         = aws_vpc.semaphore.id
}

resource "aws_service_discovery_service" "semaphore_db" {
  name = "semaphore-db"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.private.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }
}