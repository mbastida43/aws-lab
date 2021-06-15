data "aws_ami" "my-ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["my-2k19*"]
  }
  owners = ["XXXXXXXXXXXXX"]
}
