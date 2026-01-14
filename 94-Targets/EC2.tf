resource "aws_instance" "terraform" {
  ami                    = "ami-0220d79f3f480ecf5"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.lifecycle.id]
  tags = {
    Name      = "terraform"
    Terraform = "true"
  }

}

resource "aws_instance" "another" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t2.micro"
    tags = {
        Name = "another"
        Terraform = "true"
    }
    /* lifecycle{
      prevent_destroy = true
    } */
}

resource "aws_security_group" "lifecycle" {
  name = "lifecycle"

  egress {
    from_port   = 0 # from port 0 to to port 0 means all ports
    to_port     = 0
    protocol    = "-1"          # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"] # internet
  }

  ingress {
    from_port   = 0 # from port 0 to to port 0 means all ports
    to_port     = 0
    protocol    = "-1"          # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"] # internet
  }

  tags = {
    Name = "lifecycle"
  }
  lifecycle {
    prevent_destroy = false  ## true
}
}