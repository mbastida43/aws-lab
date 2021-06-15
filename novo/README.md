# New version

## Terraform + AWS + Consul + Backup .tfstate + Cloudflare DNS

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


### Consul Server

My Consul Server I created by this documentation..

https://learn.hashicorp.com/tutorials/consul/docker-compose-datacenter?in=consul/docker

The consul server use docker-compose up --detach command, this command run docker with persistent volume.


Coding by Fabricio Eiras.
