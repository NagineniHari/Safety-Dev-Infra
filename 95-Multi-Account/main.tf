##VPC Creation
resource "aws_vpc" "Prod" {
    provider =aws.Prod
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true

    tags = {
        Name="safety-Prod"
    }
}

resource "aws_vpc" "Dev" {
    provider = aws.Dev
    cidr_block       = "10.10.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true

    tags = {
        Name="safety-Dev"
    }
}

##Request 
resource "aws_vpc_peering_connection" "Dev_Prod" {
    provider = aws.Dev
    peer_owner_id = var.Prod ## Owner is always Accepter
    peer_vpc_id   = aws_vpc.Prod.id ## Accepter
    vpc_id        = aws_vpc.Dev.id ## Requester

    tags = {
    Name = "safety-Dev-to-Prod"
  }
}


resource "aws_vpc_peering_connection_accepter" "Dev_Prod" {
  provider                  =aws.Prod
  vpc_peering_connection_id = aws_vpc_peering_connection.Dev_Prod.id
  auto_accept               = true # Automatically accepts the connection

  tags = {
    Name = "safety-Dev-to-Prod"
  }
}
