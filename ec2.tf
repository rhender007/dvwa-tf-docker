# ec2.tf
resource "aws_instance" "dvwa_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dvwa_subnet.id
  security_groups = [aws_security_group.dvwa_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              # sudo amazon-linux-extras install docker -y
              sudo yum install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo chkconfig docker on

              # Install Docker Compose
              sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose

              # Clone DVWA and run with Docker Compose
              git clone https://github.com/your_github_username/terraform-dvwa.git /home/ec2-user/terraform-dvwa
              cd /home/ec2-user/terraform-dvwa
              sudo /usr/local/bin/docker-compose up -d
              EOF

  tags = {
    Name = "DVWA-Instance"
  }
}
