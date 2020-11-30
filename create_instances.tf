
/******************************************************************************
#Creation of Bastion host
******************************************************************************/
resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "n1-standard-1"
  zone         = "us-west1-a"
  project      = var.project_id
  tags = ["bastion"]                                       # Adding tags for reference
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }
  network_interface {
    network = module.vpc.network_name
    subnetwork = module.vpc.subnets_names[0]                # Subnet for bastion
    subnetwork_project = var.project_id
    access_config {
      // Ephemeral IP                                       # public ip is enabled for Bastion host 
    }
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

/********************************************************************************
#Creation of web host
********************************************************************************/

resource "google_compute_instance" "web" {
  name         = "web"
  machine_type = "n1-standard-1"
  zone         = "us-west1-a"
  project      = var.project_id
  tags = ["web-tier"]                                       # Adding tags for reference
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = module.vpc.network_name
    subnetwork = module.vpc.subnets_names[1]                 # Subnet for web-tier
    subnetwork_project = var.project_id
    }
  metadata_startup_script = "sudo apt update && sudo apt install apache2 && sudo apt install curl"
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

/************************************************************************************
#Creation of app host
************************************************************************************/

resource "google_compute_instance" "app" {
  name         = "app"
  machine_type = "n1-standard-1"
  zone         = "us-west1-a"
  project      = var.project_id
  tags = ["app-tier"]                                        # Adding tags for reference
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = module.vpc.network_name
    subnetwork = module.vpc.subnets_names[2]                 # Subnet for app-tier
    subnetwork_project = var.project_id
    }
  
  metadata_startup_script = "sudo apt update && sudo apt install apache2 && sudo apt install curl"
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
