#!/bin/bash

### Create folder client name in AWS S3 Bucket, this script run on local of .tf ###
aws s3api put-object --bucket tf-NAME --key NAME-OF-DIR/
sleep 2

### Upload to AWS S3 ###
aws s3 cp create-ec2.tf s3://tf-NAME/NAME-OF-DIR/
sleep 2
