Follow up questions:

1. How would you make this deployment fault tolerant and highly available?

Answer: 
We can have instance groups of web-tier and app-tier for autoscaling and auto-repair and add a load balancer on top of web-tier to distribute the load 
  
2. How would you make this deployment more secure?
Answer: 
   1. Use IGW for Routing the traffic to internet and use NAT ip for the instances having private ip's to download the patches for any vulnerabilities. 
   2. provide granular level of permissions to users for accessing the istances.

3. How would you make this deployment cloud agnostic?

Answer: 
Terraform has multiple cloud providers. It can be run on any cloud platform to codify the infrastructure and maintain it using statefiles. The terraform state files can be stored in GCS bucket to make it available for multiple people to work on.
