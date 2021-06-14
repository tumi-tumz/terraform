# Create Microsoft AD for Remote Desktop Gateway connections
resource "aws_directory_service_directory" "directory" {
  name = "ad.inhancesc.com"
  password = "Hdnthu8746Hgtd"
  edition = "Standard"
  type = "MicrosoftAD"
  size = "Small"

  vpc_settings {
    vpc_id = aws_vpc.custom.id
    subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]
  }

  tags = {
    "Name" = "ad.inhancesc.com"
  }
}