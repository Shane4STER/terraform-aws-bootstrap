resource "aws_launch_configuration" "bastion" {
  name_prefix     = "lab-bastion-host-"
  image_id        = "${var.bastion_ami_id}"
  instance_type   = "t2.micro"
  key_name        = "${var.ssh_key}"
  security_groups = ["${aws_security_group.bastion_asg.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion" {
  name                      = "lab-bastion-host"
  launch_configuration      = "${aws_launch_configuration.bastion.name}"
  min_size                  = 1
  max_size                  = 1
  target_group_arns         = ["${aws_lb_target_group.bastion.arn}"]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  vpc_zone_identifier       = ["${var.dmz_subnets}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "bastion" {
  name               = "lab-bastion-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["${var.dmz_subnets}"]

  tags {
    ManagedByTerraform = "true"
  }
}

resource "aws_lb_target_group" "bastion" {
  name     = "lab-bastion-tg"
  port     = 22
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_listener" "bastion" {
  load_balancer_arn = "${aws_lb.bastion.arn}"
  port              = 22
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.bastion.arn}"
  }
}

resource "aws_security_group" "bastion_asg" {
  name        = "lab-bastion-asg"
  description = "Allows SSH access from the bastion NLB to the Bastion ASG instances"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "bastion_in_ssh" {
  security_group_id = "${aws_security_group.bastion_asg.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = "${var.inbound_ssh_cidrs}"
}

resource "aws_security_group_rule" "bastion_out_ssh" {
  security_group_id        = "${aws_security_group.bastion_asg.id}"
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_access.id}"
}

resource "aws_security_group" "bastion_access" {
  name        = "lab-bastion-access"
  description = "Provides bastion access to resources in this group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion_asg.id}"]
  }
}
