provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
	ami = "ami-061e388c127cfdae7"
	subnet_id = var.subnetid
	instance_type = var.insttype
	vpc_security_group_ids = [var.sgid]

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
