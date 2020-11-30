
The terraform code uses GCP CFT(Cloud Foundations Toolkit) modules and terraform resources to create the GCP infra. There are different files to create network & sub-networks, firewall rules, instances. The resources and module dependency is automatically resolved by terraform.

Dependencies: 
1. You need Terraform v0.12.29 to run this code.
2. This repo does not include terraform code for project and network creation. You need a project and a network already created to use this code. 

Note: you can use "google_compute_network" and "google_project" terraform resources to create network and project respectively 


The state file generated is stored in your local machine. 


****************
Steps to run:
****************

1. Clone the repo to your local
2. Execute Terraform init
3. Execute Terraform plan. Provide the network name you want, and the project id of the project in which the resources should be created.
4. Execute Terraform apply. Provide the same inputs as in above point 3.

****************************************************************************************
Fyi, Below is the plan of resources that will be created when you hit Terraform plan(point 2)
****************************************************************************************


$ terraform apply
var.network_name
  The name of the VPC network being created

  Enter a value: test-network

var.project_id
  The project ID to host the network in

  Enter a value: test-project


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_instance.app will be created
  + resource "google_compute_instance" "app" {
      + can_ip_forward          = false
      + cpu_platform            = (known after apply)
      + deletion_protection     = false
      + guest_accelerator       = (known after apply)
      + id                      = (known after apply)
      + instance_id             = (known after apply)
      + label_fingerprint       = (known after apply)
      + machine_type            = "n1-standard-1"
      + metadata_fingerprint    = (known after apply)
      + metadata_startup_script = "sudo apt update && sudo apt install apache2 && sudo apt install curl"
      + min_cpu_platform        = (known after apply)
      + name                    = "app"
      + project                 = "atvi-infra-cloud-sandbox"
      + self_link               = (known after apply)
      + tags                    = [
          + "app-tier",
        ]
      + tags_fingerprint        = (known after apply)
      + zone                    = "us-west1-a"

      + boot_disk {
          + auto_delete                = true
          + device_name                = (known after apply)
          + disk_encryption_key_sha256 = (known after apply)
		  + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)

          + initialize_params {
              + image  = "debian-cloud/debian-9"
              + labels = (known after apply)
              + size   = (known after apply)
              + type   = (known after apply)
            }
        }

      + network_interface {
          + name               = (known after apply)
          + network            = "test-network"
          + network_ip         = (known after apply)
          + subnetwork         = "test-network-frontend-02"
          + subnetwork_project = "atvi-infra-cloud-sandbox"
        }

      + scheduling {
          + automatic_restart   = (known after apply)
          + on_host_maintenance = (known after apply)
          + preemptible         = (known after apply)

          + node_affinities {
              + key      = (known after apply)
              + operator = (known after apply)
              + values   = (known after apply)
            }
        }

      + scratch_disk {
          + interface = "SCSI"
        }

      + service_account {
          + email  = (known after apply)
          + scopes = [
              + "https://www.googleapis.com/auth/compute.readonly",
              + "https://www.googleapis.com/auth/devstorage.read_only",
              + "https://www.googleapis.com/auth/userinfo.email",
            ]
        }
    }
	
	# google_compute_instance.bastion will be created
  + resource "google_compute_instance" "bastion" {
      + can_ip_forward       = false
      + cpu_platform         = (known after apply)
      + deletion_protection  = false
      + guest_accelerator    = (known after apply)
      + id                   = (known after apply)
      + instance_id          = (known after apply)
      + label_fingerprint    = (known after apply)
      + machine_type         = "n1-standard-1"
      + metadata_fingerprint = (known after apply)
      + min_cpu_platform     = (known after apply)
      + name                 = "bastion"
      + project              = "atvi-infra-cloud-sandbox"
      + self_link            = (known after apply)
      + tags                 = [
          + "bastion",
        ]
      + tags_fingerprint     = (known after apply)
      + zone                 = "us-west1-a"

      + boot_disk {
          + auto_delete                = true
          + device_name                = (known after apply)
          + disk_encryption_key_sha256 = (known after apply)
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)

          + initialize_params {
              + image  = "debian-cloud/debian-9"
              + labels = (known after apply)
              + size   = (known after apply)
              + type   = (known after apply)
            }
        }

      + network_interface {
          + name               = (known after apply)
          + network            = "test-network"
          + network_ip         = (known after apply)
          + subnetwork         = "test-network-backend-03"
          + subnetwork_project = "atvi-infra-cloud-sandbox"

          + access_config {
              + nat_ip       = (known after apply)
              + network_tier = (known after apply)
            }
        }

      + scheduling {
          + automatic_restart   = (known after apply)
          + on_host_maintenance = (known after apply)
          + preemptible         = (known after apply)

          + node_affinities {
              + key      = (known after apply)
              + operator = (known after apply)
              + values   = (known after apply)
            }
        }

      + scratch_disk {
          + interface = "SCSI"
        }

      + service_account {
          + email  = (known after apply)
          + scopes = [
              + "https://www.googleapis.com/auth/compute.readonly",
              + "https://www.googleapis.com/auth/devstorage.read_only",
              + "https://www.googleapis.com/auth/userinfo.email",
            ]
        }
    }

  # google_compute_instance.web will be created
  + resource "google_compute_instance" "web" {
      + can_ip_forward          = false
      + cpu_platform            = (known after apply)
      + deletion_protection     = false
      + guest_accelerator       = (known after apply)
      + id                      = (known after apply)
      + instance_id             = (known after apply)
      + label_fingerprint       = (known after apply)
      + machine_type            = "n1-standard-1"
      + metadata_fingerprint    = (known after apply)
      + metadata_startup_script = "sudo apt update && sudo apt install apache2 && sudo apt install curl"
      + min_cpu_platform        = (known after apply)
      + name                    = "web"
      + project                 = "atvi-infra-cloud-sandbox"
      + self_link               = (known after apply)
	  + tags                    = [
          + "web-tier",
        ]
      + tags_fingerprint        = (known after apply)
      + zone                    = "us-west1-a"

      + boot_disk {
          + auto_delete                = true
          + device_name                = (known after apply)
          + disk_encryption_key_sha256 = (known after apply)
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)

          + initialize_params {
              + image  = "debian-cloud/debian-9"
              + labels = (known after apply)
              + size   = (known after apply)
              + type   = (known after apply)
            }
        }

      + network_interface {
          + name               = (known after apply)
          + network            = "test-network"
          + network_ip         = (known after apply)
          + subnetwork         = "test-network-bastion-01"
          + subnetwork_project = "atvi-infra-cloud-sandbox"
        }

      + scheduling {
          + automatic_restart   = (known after apply)
          + on_host_maintenance = (known after apply)
          + preemptible         = (known after apply)

          + node_affinities {
              + key      = (known after apply)
              + operator = (known after apply)
              + values   = (known after apply)
            }
        }

      + scratch_disk {
          + interface = "SCSI"
		  }

      + service_account {
          + email  = (known after apply)
          + scopes = [
              + "https://www.googleapis.com/auth/compute.readonly",
              + "https://www.googleapis.com/auth/devstorage.read_only",
              + "https://www.googleapis.com/auth/userinfo.email",
            ]
        }
    }

  # module.net-firewall.google_compute_firewall.allow-tag-http[0] will be created
  + resource "google_compute_firewall" "allow-tag-http" {
      + creation_timestamp = (known after apply)
      + description        = "Allow HTTP to machines with the 'http-server' tag"
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + id                 = (known after apply)
      + name               = "test-network-ingress-tag-http"
      + network            = "test-network"
      + priority           = 1000
      + project            = "atvi-infra-cloud-sandbox"
      + self_link          = (known after apply)
      + source_ranges      = [
          + "0.0.0.0/0",
        ]
      + target_tags        = [
          + "http-server",
        ]

      + allow {
          + ports    = [
              + "80",
            ]
          + protocol = "tcp"
        }
    }

  # module.net-firewall.google_compute_firewall.allow-tag-https[0] will be created
  + resource "google_compute_firewall" "allow-tag-https" {
      + creation_timestamp = (known after apply)
      + description        = "Allow HTTPS to machines with the 'https' tag"
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + id                 = (known after apply)
      + name               = "test-network-ingress-tag-https"
      + network            = "test-network"
	  + priority           = 1000
      + project            = "atvi-infra-cloud-sandbox"
      + self_link          = (known after apply)
      + source_ranges      = [
          + "0.0.0.0/0",
        ]
      + target_tags        = [
          + "https-server",
        ]

      + allow {
          + ports    = [
              + "443",
            ]
          + protocol = "tcp"
        }
    }

  # module.net-firewall.google_compute_firewall.allow-tag-ssh[0] will be created
  + resource "google_compute_firewall" "allow-tag-ssh" {
      + creation_timestamp = (known after apply)
      + description        = "Allow SSH to machines with the 'ssh' tag"
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + id                 = (known after apply)
      + name               = "test-network-ingress-tag-ssh"
      + network            = "test-network"
      + priority           = 1000
      + project            = "atvi-infra-cloud-sandbox"
      + self_link          = (known after apply)
      + source_ranges      = [
          + "0.0.0.0/0",
        ]
      + target_tags        = [
          + "ssh",
        ]

      + allow {
          + ports    = [
              + "22",
            ]
          + protocol = "tcp"
        }
    }

   # module.net-firewall.google_compute_firewall.custom["allow-ssh-from-bastion"] will be created
  + resource "google_compute_firewall" "custom" {
      + creation_timestamp = (known after apply)
      + description        = "Allow ssh from bastion host to web and app on internal ip's"
      + destination_ranges = (known after apply)
      + direction          = "INGRESS"
      + disabled           = false
      + id                 = (known after apply)
      + name               = "allow-ssh-from-bastion"
      + network            = "test-network"
      + priority           = 1000
      + project            = "atvi-infra-cloud-sandbox"
      + self_link          = (known after apply)
      + source_ranges      = (known after apply)
      + source_tags        = [
          + "bastion",
        ]
      + target_tags        = [
          + "app-tier",
          + "web-tier",
        ]

      + allow {
          + ports    = [
              + "22",
            ]
          + protocol = "tcp"
        }
    }

  # module.net-firewall.google_compute_firewall.custom["allow-web"] will be created
  + resource "google_compute_firewall" "custom" {
      + creation_timestamp = (known after apply)
      + description        = "Allow traffic on web tier from internet on port 443"
      + destination_ranges = (known after apply)
      + direction          = "INGRESS"
      + disabled           = false
      + id                 = (known after apply)
      + name               = "allow-web"
      + network            = "test-network"
      + priority           = 1000
      + project            = "atvi-infra-cloud-sandbox"
      + self_link          = (known after apply)
      + source_ranges      = [
          + "0.0.0.0/0",
        ]
      + target_tags        = [
	     + "web-tier",
        ]

      + allow {
          + ports    = [
              + "443",
            ]
          + protocol = "tcp"
        }
    }

  # module.net-firewall.google_compute_firewall.custom["allow-web-to-app"] will be created
  + resource "google_compute_firewall" "custom" {
      + creation_timestamp = (known after apply)
      + description        = "Allow web to app connection on port 80"
      + destination_ranges = (known after apply)
      + direction          = "INGRESS"
      + disabled           = false
      + id                 = (known after apply)
      + name               = "allow-web-to-app"
      + network            = "test-network"
      + priority           = 1000
      + project            = "atvi-infra-cloud-sandbox"
      + self_link          = (known after apply)
      + source_ranges      = (known after apply)
      + source_tags        = [
          + "web-tier",
        ]
      + target_tags        = [
          + "app-tier",
        ]

      + allow {
          + ports    = [
              + "80",
            ]
          + protocol = "tcp"
        }
    }

  # module.net-firewall.google_compute_firewall.custom["allowed-to-bastion"] will be created
  + resource "google_compute_firewall" "custom" {
      + creation_timestamp = (known after apply)
      + description        = "Allow all traffic from admin-users"
      + destination_ranges = (known after apply)
      + direction          = "INGRESS"
      + disabled           = false
      + id                 = (known after apply)
	   + name               = "allowed-to-bastion"
      + network            = "test-network"
      + priority           = 1000
      + project            = "atvi-infra-cloud-sandbox"
      + self_link          = (known after apply)
      + source_ranges      = [
          + "10.0.0.0/8",
          + "10.20.0.0/22",
        ]
      + target_tags        = [
          + "bastion",
        ]

      + allow {
          + ports    = [
              + "22",
              + "80",
              + "443",
            ]
          + protocol = "tcp"
        }
    }

  # module.net-firewall.google_compute_firewall.custom["deny-app-to-web"] will be created
  + resource "google_compute_firewall" "custom" {
      + creation_timestamp = (known after apply)
      + description        = "Deny app to web connection on port 443"
      + destination_ranges = (known after apply)
      + direction          = "INGRESS"
      + disabled           = false
      + id                 = (known after apply)
      + name               = "deny-app-to-web"
      + network            = "test-network"
      + priority           = 1000
      + project            = "atvi-infra-cloud-sandbox"
      + self_link          = (known after apply)
      + source_ranges      = (known after apply)
      + source_tags        = [
          + "app-tier",
        ]
      + target_tags        = [
          + "web-tier",
        ]

      + deny {
          + ports    = [
              + "443",
            ]
          + protocol = "tcp"
        }
    }

  # module.net-firewall.google_compute_firewall.custom["deny-to-internet"] will be created
  + resource "google_compute_firewall" "custom" {
      + creation_timestamp = (known after apply)
      + description        = "Deny outbound to internet from bastion,web and app instances"
      + destination_ranges = [
          + "0.0.0.0/0",
        ]
      + direction          = "EGRESS"
      + disabled           = false
      + id                 = (known after apply)
      + name               = "deny-to-internet"
      + network            = "test-network"
      + priority           = 1000
      + project            = "atvi-infra-cloud-sandbox"
      + self_link          = (known after apply)
      + source_ranges      = (known after apply)
      + target_tags        = [
          + "app-tier",
          + "bastion",
          + "web-tier",
        ]

      + deny {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
    }

  # module.vpc.module.subnets.google_compute_subnetwork.subnetwork["us-west1/test-network-backend-03"] will be created
  + resource "google_compute_subnetwork" "subnetwork" {
      + creation_timestamp       = (known after apply)
      + enable_flow_logs         = (known after apply)
      + fingerprint              = (known after apply)
      + gateway_address          = (known after apply)
      + id                       = (known after apply)
      + ip_cidr_range            = "10.10.30.0/24"
      + name                     = "test-network-backend-03"
      + network                  = "test-network"
      + private_ip_google_access = false
      + project                  = "atvi-infra-cloud-sandbox"
      + region                   = "us-west1"
	  + secondary_ip_range       = []
      + self_link                = (known after apply)
    }

  # module.vpc.module.subnets.google_compute_subnetwork.subnetwork["us-west1/test-network-bastion-01"] will be created
  + resource "google_compute_subnetwork" "subnetwork" {
      + creation_timestamp       = (known after apply)
      + enable_flow_logs         = (known after apply)
      + fingerprint              = (known after apply)
      + gateway_address          = (known after apply)
      + id                       = (known after apply)
      + ip_cidr_range            = "10.10.10.0/24"
      + name                     = "test-network-bastion-01"
      + network                  = "test-network"
      + private_ip_google_access = false
      + project                  = "atvi-infra-cloud-sandbox"
      + region                   = "us-west1"
      + secondary_ip_range       = []
      + self_link                = (known after apply)
    }

  # module.vpc.module.subnets.google_compute_subnetwork.subnetwork["us-west1/test-network-frontend-02"] will be created
  + resource "google_compute_subnetwork" "subnetwork" {
      + creation_timestamp       = (known after apply)
      + enable_flow_logs         = (known after apply)
      + fingerprint              = (known after apply)
      + gateway_address          = (known after apply)
      + id                       = (known after apply)
      + ip_cidr_range            = "10.10.20.0/24"
      + name                     = "test-network-frontend-02"
      + network                  = "test-network"
      + private_ip_google_access = false
      + project                  = "atvi-infra-cloud-sandbox"
      + region                   = "us-west1"
      + secondary_ip_range       = []
      + self_link                = (known after apply)
    }

  # module.vpc.module.vpc.google_compute_network.network will be created
  + resource "google_compute_network" "network" {
      + auto_create_subnetworks         = false
      + delete_default_routes_on_create = false
      + gateway_ipv4                    = (known after apply)
      + id                              = (known after apply)
      + ipv4_range                      = (known after apply)
      + name                            = "test-network"
      + project                         = "atvi-infra-cloud-sandbox"
	   + routing_mode                    = "GLOBAL"
      + self_link                       = (known after apply)
    }

Plan: 16 to add, 0 to change, 0 to destroy.
	  
      

