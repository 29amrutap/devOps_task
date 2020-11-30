/*
provider "google" {
  version = "~> 3.3.0"
}


provider "null" {
  version = "~> 2.1"
}
*/

module "net-firewall" {
  source              = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  project_id          = var.project_id
  network             = module.vpc.network_name
  custom_rules = {
     allowed-to-bastion = {
      description          = "Allow all traffic from admin-users"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = ["10.0.0.0/8","10.20.0.0/22"]                   # this is a dummy list of allowed ip ranges
      use_service_accounts = false                                          
      targets              = ["bastion"]                                     # this rule will be applied to bastion instance which has the tag bastion-tier
      sources              = null                                            
      rules = [{
        protocol = "tcp"
        ports    = ["22", "80", "443"] 
        }
      ]
      extra_attributes = {}
     }
     allow-web = {
      description          = "Allow traffic on web tier from internet on port 443"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = ["0.0.0.0/0"]                                   # allow traffic from internet to web instance on port 443
      use_service_accounts = false
      targets              = ["web-tier"]                                    # this rule will be applied to web instance which has the tag web-tier
      sources              = null
      rules = [{
        protocol = "tcp"
        ports    = ["443"]
        }
      ]
      extra_attributes = {}
     }
     allow-web-to-app = {
      description          = "Allow web to app connection on port 80"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = null
      use_service_accounts = false
      targets              = ["app-tier"]                                   # this rule will be applied to app instance which has the tag app-tier
      sources              = ["web-tier"]                                   # web instance can reach app instance on port 80
      rules = [{
        protocol = "tcp"
        ports    = ["80"]
      }]

      extra_attributes = {}
    }
    deny-app-to-web = {
      description          = "Deny app to web connection on port 443"
      direction            = "INGRESS"
      action               = "deny"
      ranges               = null
      use_service_accounts = false
      targets              = ["web-tier"]                                   # this rule will be applied to web instance which has the tag web-tier
      sources              = ["app-tier"]                                   # app instance cannot reach web instance on port 443
      rules = [{
        protocol = "tcp"
        ports    = ["443"]
      }]

      extra_attributes = {}
    }
    allow-ssh-from-bastion = {
      description          = "Allow ssh from bastion host to web and app on internal ip's"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = null
      use_service_accounts = false
      targets              = ["app-tier", "web-tier"]                       # this rule will be applied to web and app instance with respective tags
      sources              = ["bastion"]                                    # bastion can ssh to app and web instances 
      rules = [{
        protocol = "tcp"
        ports    = ["22"]
      }]

      extra_attributes = {}
    }
    deny-to-internet = {
      description          = "Deny outbound to internet from bastion,web and app instances"
      direction            = "EGRESS"
      action               = "deny"
      ranges               = ["0.0.0.0/0"]                                 # Deny outbound to internet from app, web bastion instances
      use_service_accounts = false
      targets              = ["app-tier", "web-tier", "bastion"]           # this rule will be applied to app,web and instance with the respective tags
      sources              = null 
      rules = [{
         protocol = "tcp"
         ports    = ["0-65535"]
      }]

      extra_attributes = {}
    }
  
  }

}
