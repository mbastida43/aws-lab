resource "aws_instance" "pabx-cliente" {
  ami           = data.aws_ami.my.image_id
  key_name      = var.my2k19key
  subnet_id     = var.mysubnet
  instance_type = var.myec2type


  tags = merge(var.default_tags, {
    Name    = "my-${local.client}"
    Created = timestamp()
  })

  root_block_device {
    delete_on_termination = true
  }

  vpc_security_group_ids = var.cxsg["sgc-my-default"]

}

resource "aws_eip_association" "eip_assoc-cliente" {
  instance_id   = aws_instance.my-cliente.id
  allocation_id = aws_eip.eip-my-cliente.id

}

resource "aws_eip" "eip-my-cliente" {
  vpc = true

  tags = merge(var.default_tags, {
    Name    = "my-${local.client}"
    Created = timestamp()
  })

  depends_on = [aws_instance.my-cliente]
}

resource "cloudflare_record" "zone" {
  zone_id = var.cloudflare_zone_id
  name    = "my-${local.client}"
  value   = aws_eip_association.eip_assoc-cliente.public_ip
  type    = "A"
  ttl     = 3600

}

resource "local_file" "instance_public_ips" {
  content  = aws_eip_association.eip_assoc-cliente.public_ip
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
  Subject: New VM do ${local.client} - AWS SP
  From: email@com.br

  Olá,

  Para acessar a vm  use o endereço: my-${local.client}.dge.mobi porta XXX RDP

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
  value = aws_eip_association.eip_assoc-cliente.public_ip
}

resource "aws_s3_bucket_object" "tf-dge-sp" {

  bucket = "tf-dge-sp"
  key    = "c-${local.client}/create-ec2.tf"
  source = "create-ec2-new.tf"
  etag   = filemd5("create-ec2.tf")

  tags = merge(var.default_tags, {
    Name    = "my-${local.client}"
    Created = timestamp()
  })

}

terraform {
  backend "consul" {
    address = "consul.xxxx.com:8500"
    scheme  = "http"
    path    = "tf-dge/c-${local.client}-terraform.tfstate"
    lock    = true
    gzip    = false
  }
}
