resource "aws_instance" "pabx-_CLIENTE_" {
  ami           = data.aws_ami.my.image_id
  key_name      = var.my2k19key
  subnet_id     = var.mysubnet
  instance_type = var.myec2type


  tags = merge(var.default_tags, {
    Name    = "my-_CLIENTE_"
    Created = timestamp()
  })

  root_block_device {
    delete_on_termination = true
  }

  vpc_security_group_ids = var.cxsg["sgc-my-default"]

}

resource "aws_eip_association" "eip_assoc-_CLIENTE_" {
  instance_id   = aws_instance.my-_CLIENTE_.id
  allocation_id = aws_eip.eip-my-_CLIENTE_.id

}

resource "aws_eip" "eip-my-_CLIENTE_" {
  vpc = true

  tags = merge(var.default_tags, {
    Name    = "my-_CLIENTE_"
    Created = timestamp()
  })

  depends_on = [aws_instance.my-_CLIENTE_]
}

resource "cloudflare_record" "zone" {
  zone_id = var.cloudflare_zone_id
  name    = "my-_CLIENTE_"
  value   = aws_eip_association.eip_assoc-_CLIENTE_.public_ip
  type    = "A"
  ttl     = 3600

}

resource "local_file" "instance_public_ips" {
  content  = aws_eip_association.eip_assoc-_CLIENTE_.public_ip
  filename = "public_ip"
}

resource "local_file" "mon" {
  filename = "./mon.sh"
  content  = <<-EOT
    #!/bin/bash
    IP=$(cat public_ip)
    sleep 1
    curl -X POST "url for api monitor"
    
  EOT
}

resource "local_file" "mail" {
  filename = "mail.txt"
  content  = <<-EOT
  To: email@com.br
  Subject: New VM do _CLIENTE_ - AWS SP
  From: email@com.br

  Olá,

  Para acessar a vm  use o endereço: my-_CLIENTE_.dge.mobi porta XXX RDP

  Obs.: O acesso está liberado somente para o range de IP DGE

  EOT
}

resource "null_resource" "prtg" {
  provisioner "local-exec" {
    command = "./mon.sh && sendmail -vt < mail.txt"
  }
  depends_on = [local_file.instance_public_ips]
}

output "instance_public_ips" {
  value = aws_eip_association.eip_assoc-_CLIENTE_.public_ip
}

resource "aws_s3_bucket_object" "tf-dge-sp" {

  bucket = "tf-dge-sp"
  key    = "_CLIENTE_/create-ec2.tf"
  source = "create-ec2-new.tf"
  etag   = filemd5("create-ec2.tf")

  tags = merge(var.default_tags, {
    Name    = "my-_CLIENTE_"
    Created = timestamp()
  })

}

terraform {
  backend "consul" {
    address = "consul.xxxx.com:8500"
    scheme  = "http"
    path    = "tf-dge/_CLIENTE_-terraform.tfstate"
    lock    = true
    gzip    = false
  }
}
