provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
	ami = "ami-061e388c127cfdae7"
	subnet_id = var.network-module.subnetid
	instance_type = "t2.small"
	vpc_security_group_ids = [var.network-module.sgid]

	tags = {
		Name = "Doh!"
	}
}

data "aws_eip" "bac_ip" {
	public_ip = "3.22.150.18"
}

resource "aws_eip_association" "bac_assoc" {
	instance_id = aws_instance.web.id
	allocation_id = data.aws_eip.bac_ip.id
}
