# ec2.tf
resource "aws_instance" "dvwa_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 LTS AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dvwa_subnet.id
  security_groups = [aws_security_group.dvwa_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y docker.io docker-compose
              sudo systemctl start docker
              sudo systemctl enable docker

              # Clone DVWA and run with Docker Compose
              git clone https://github.com/your_github_username/terraform-dvwa.git /home/ubuntu/terraform-dvwa
              cd /home/ubuntu/terraform-dvwa
              sudo docker-compose up -d
              EOF

  tags = {
    Name = "DVWA-Instance"
  }
}
