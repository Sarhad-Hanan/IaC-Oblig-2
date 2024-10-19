output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  description = "A list of the Subnet IDs"
  value       = [for subnet in azurerm_subnet.subnet : subnet.id]
}

output "lb_public_ip" {
  description = "The public IP of the Load Balancer"
  value       = azurerm_public_ip.lb_public_ip.ip_address
}

output "lb_backend_pool_id" {
  description = "The ID of the Load Balancer Backend Pool"
  value       = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

output "lb_id" {
  description = "The ID of the Load Balancer"
  value       = azurerm_lb.app_lb.id
}
