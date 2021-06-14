# Create KMS key
resource "aws_kms_key" "key" {
  description = "DefaultKMSKey"
  tags = {
    "Name" = "DefaultKMSKey"
  }
}
resource "aws_ebs_default_kms_key" "kms" {
  key_arn = aws_kms_key.key.arn
}

# Create Remote Desktop Gateway server
resource "aws_instance" "rdgw" {
  ami = "ami-06a9feec6378b9907"
  instance_type = "t3a.small"

  # Configure instance
  subnet_id = aws_subnet.public1.id
  associate_public_ip_address = aws_subnet.public1.map_public_ip_on_launch
  disable_api_termination = true
  vpc_security_group_ids = [aws_security_group.rdgw.id]
  key_name = var.keyname
  
  # Add EBS volume
  root_block_device {
    delete_on_termination = true
    device_name = "RGDW"
    encrypted = true
    kms_key_id = aws_ebs_default_kms_key.kms.id
    volume_size = 100
    volume_type = "gp2"
    tags = {
      "Name" = "RGDW"
    }
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    "Name" = "RGDW"
  }
}

# Create Active Directory server
resource "aws_instance" "ad" {
  ami = "ami-06a9feec6378b9907"
  instance_type = "t3a.small"

  # Configure instance
  subnet_id = aws_subnet.private1.id
  disable_api_termination = true
  vpc_security_group_ids = [aws_security_group.pvt.id]
  key_name = var.keyname
  
  # Add EBS volume
  root_block_device {
    delete_on_termination = true
    device_name = "ADServer"
    encrypted = true
    kms_key_id = aws_ebs_default_kms_key.kms.id
    volume_size = 100
    volume_type = "gp2"
    tags = {
      "Name" = "ADServer"
    }
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    "Name" = "ADServer"
  }
}

# Create Application server
resource "aws_instance" "app" {
  ami = "ami-06a9feec6378b9907"
  instance_type = "t3a.large"

  # Configure instance
  subnet_id = aws_subnet.private1.id
  disable_api_termination = true
  vpc_security_group_ids = [aws_security_group.pvt.id]
  key_name = var.keyname
  
  # Add EBS volume
  root_block_device {
    delete_on_termination = true
    device_name = "AppServer"
    encrypted = true
    kms_key_id = aws_ebs_default_kms_key.kms.id
    volume_size = 100
    volume_type = "gp2"
    tags = {
      "Name" = "AppServer"
    }
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    "Name" = "AppServer"
  }
}

# Create Web Application server
resource "aws_instance" "web" {
  ami = "ami-06a9feec6378b9907"
  instance_type = "t3a.large"

  # Configure instance
  subnet_id = aws_subnet.public1.id
  associate_public_ip_address = false
  disable_api_termination = true
  vpc_security_group_ids = [aws_security_group.pvt.id]
  key_name = var.keyname
  
  # Add EBS volume
  root_block_device {
    delete_on_termination = true
    device_name = "WebServer"
    encrypted = true
    kms_key_id = aws_ebs_default_kms_key.kms.id
    volume_size = 100
    volume_type = "gp2"
    tags = {
      "Name" = "WebServer"
    }
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    "Name" = "WebServer"
  }
}

# Create Linux servers for config management
resource "aws_instance" "mst" {
  ami = "ami-05be6e4068fb1d09a"
  instance_type = "t3a.micro"

  # Configure instance
  subnet_id = aws_subnet.public1.id
  associate_public_ip_address = true
  disable_api_termination = true
  vpc_security_group_ids = [aws_security_group.tst.id]
  key_name = "linuxmachines"
  
  # Add EBS volume
  root_block_device {
    volume_type = "gp2"
    volume_size = 100
    delete_on_termination = "true"
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    "Name" = "ConfigMaster"
  }
}

resource "aws_instance" "slv" {
  ami = "ami-05be6e4068fb1d09a"
  instance_type = "t3a.micro"

  # Configure instance
  subnet_id = aws_subnet.public1.id
  associate_public_ip_address = true
  disable_api_termination = true
  vpc_security_group_ids = [aws_security_group.tst.id]
  key_name = "linuxmachines"
  
  # Add EBS volume
  root_block_device {
    volume_type = "gp2"
    volume_size = 100
    delete_on_termination = "true"
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    "Name" = "ConfigSlave"
  }
}