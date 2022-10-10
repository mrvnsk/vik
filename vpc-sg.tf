# Create Security group for the Application Load Balancer
resource "aws_security_group" "alb_sg" {
    name = "ALB-SG"
    description = "Enable HTTP/HTTPS access on Port 80/443"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "HTTP access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ALB-SG"
    }
}

# Create security group for the bastion host aka jump box
resource "aws_security_group" "ssh-sg" {
    name = "ssh-access"
    description = "Enable SSH access on port 22"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "ssh-access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.ssh-location}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "SSH security group"
    }
}

# Create security group for webservers
resource "aws_security_group" "webservers-sg" {
    name = "Webserver-sg"
    description = "Enable HTTP/HTTPS access on port 80/443 via LB and SSH on port 22 via SSH SG"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "HTTP ACCESS"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.alb_sg.id}"]
    }

    ingress {
        description = "HTTPS ACCESS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = ["${aws_security_group.alb_sg.id}"]
    }

    ingress {
        description = "SSH ACCESS"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = ["${aws_security_group.ssh-sg.id}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "WebServer-sg"
    }
}

# Create a security group for database
resource "aws_security_group" "database-sg" {
    name = "DATABASE SG"
    description = "Enable MYSQL Access on port 3306"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "MYSQL access"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${aws_security_group.webservers-sg.id}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "Database-sg"
    }
}