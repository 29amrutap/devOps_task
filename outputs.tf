
output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "subnets_names" {
  value       = module.vpc.subnets_names
  description = "The names of the subnets being created"
}

output "subnets_ips" {
  value       = module.vpc.subnets_ips
  description = "The IP and cidrs of the subnets being created"
}

output "bastion_host" {
  value       = google_compute_instance.bastion.name
  description = "bastion instance"
}

output "web_host" {
  value       = google_compute_instance.web.name
  description = "web instance"
}

output "app_host" {
  value       = google_compute_instance.app.name
  description = "app instance"
}
