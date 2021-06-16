# New version

## Terraform + AWS + Consul + Backup .tfstate + Cloudflare DNS + Jenkins

### create-ec2.tf

This code use for create simple ec2 + Elastic IP ( Public IP ).

   * Create EC2 AMI Based.
   * Previously created, SG group, vpc, subnet, Key pair and AMI image.
   * Copy tfstate to HashiCorp Consul.
   * Get the new ami based on initial name.
   * Add the monitoring API, based the IP from EC2.
   * Send mail with info for vm access.
   * Create backup tfstate on aws bucket
   * Create entrance on cloudflare DNS for the external access.


### This Terraform is separated in 5 file.
   
   * create-ec2.tf
   * data.tf
   * locals.tf
   * provider.tf
   * variabel.tf


### Consul Server

My Consul Server I created by this documentation..

https://learn.hashicorp.com/tutorials/consul/docker-compose-datacenter?in=consul/docker

The consul server use docker-compose up --detach command, this command run docker with persistent volume.


### Jenkins CI/CD

I use Jenkins CI/CD for deploy the VM, and build job with parameter "client" and change the variable with sed command the locals.tf
The jenkins pipeline run the commands for terraform deploy ( terraform init and terraform apply --auto-approve )


Coding by Fabricio Eiras.
