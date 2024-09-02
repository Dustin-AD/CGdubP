output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.cgdubp_vpc.id
}

output "public_subnet1_id" {
  description = "The ID of the first public subnet"
  value       = aws_subnet.public_subnet1.id
}

output "public_subnet2_id" {
  description = "The ID of the second public subnet"
  value       = aws_subnet.public_subnet2.id
}

output "private_app_subnet1_id" {
  description = "The ID of the first private application subnet"
  value       = aws_subnet.private_app_subnet1.id
}

output "private_app_subnet2_id" {
  description = "The ID of the second private application subnet"
  value       = aws_subnet.private_app_subnet2.id
}

output "private_db_subnet1_id" {
  description = "The ID of the first private database subnet"
  value       = aws_subnet.private_db_subnet1.id
}

output "private_db_subnet2_id" {
  description = "The ID of the second private database subnet"
  value       = aws_subnet.private_db_subnet2.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.internet_gateway.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_route_table.id
}
