provider aws {

  profile = "zerops-general-iamadmin"
  region = "ap-south-1"

}

resource aws_instance "sws-instance" {

  ami = "ami-0caf778a172362f1c"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sws-sg.id]
  user_data = <<-EOF
		#! /bin/bash
                sudo apt-get update -y
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
	EOF
  user_data_replace_on_change = true

  tags = {
    Name = "terraform-single-web-server-example"
         }

}

resource "aws_security_group" "sws-sg" {
  name = "terraform-sws-sg"

  ingress {

    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
          }

}
