# outputs.tf
output "instance_ip" {
  description = "The public IP of the DVWA instance"
  value       = aws_instance.dvwa_instance.public_ip
}
