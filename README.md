## Terraform + AWS + Consul + Backup .tf

### create-ec2.tf

This code use for create simple ec2 + Elastic IP ( Public IP ).

   * Create EC2 AMI Based.
   * Previously created, SG group, vpc, subnet, Key pair and AMI image.
   * Copy tfstate to HashiCorp Consul.

### s3.sh

This code use for .tf upload on AWS S3 Bucket. 

I use Jenkins pipeline for create EC2, but need a backup the .tf archive, for case use the command terraform destroy.


### Consul Server

My Consul Server I created by this documentation..

https://learn.hashicorp.com/tutorials/consul/docker-compose-datacenter?in=consul/docker

The consul server use docker-compose up --detach command, this command run docker with persistent volume.


                
                
