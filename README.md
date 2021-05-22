# aws-lab

### create-ec2.tf

This code use for create simple ec2 + Elastic IP ( Public IP ).

   * Create EC2 AMI Based.
   * Previously created, SG group, vpc, subnet, Key pair and AMI image.
   * Copy tfstate to HashiCorp Consul.

### s3.sh

This code use for .tf upload on AWS S3 Bucket. 

I use Jenkins pipeline for create EC2, but need a backup the .tf archive, for case use the command terraform destroy.

                
                
