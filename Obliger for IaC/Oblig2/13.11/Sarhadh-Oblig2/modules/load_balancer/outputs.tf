# Outputs the public IP address of the load balancer
output "load_balancer_ip" {
  description = "Public IP address of the Load Balancer"  # Description for context
  value       = azurerm_public_ip.lb_public_ip.ip_address # The actual public IP address of the load balancer
}

# Outputs the ID of the load balancer
output "load_balancer_id" {
  description = "ID of the Load Balancer"   # Description for context
  value       = azurerm_lb.load_balancer.id # The unique identifier for the load balancer resource
}
