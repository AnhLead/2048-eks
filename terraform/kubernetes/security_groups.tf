resource "aws_security_group" "api-elb-k8s-local" {
  name        = "api-elb.${var.cluster_name}.k8s.local"
  vpc_id      = aws_vpc.main.id
  description = "Security group for api ELB"
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #ICMP - Internet  Control Message Protocol
  #HostA -> Request -> Server
  #HostA <- Request <- Server
  ingress {
    from_port   = 3
    to_port     = 4
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Allow traffic -> Anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    KubernetesCluster = "${var.cluster_name}.k8s.local"
    Name              = "api-elb.${var.cluster_name}.k8s.local"
  }
}

#BASTION 
resource "aws_security_group" "bastion_node" {
  name = "bastion_node"
  description = "Allow required traffic to bastion node"
  vpc_id = aws_vpc.main.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH from outside"
    from_port = 22
    to_port = 22
    protocol = "TCP"
  } 

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

  tags = {
    Name = "sg_bastion"
  }
}

#SECUIRTY GROUP FOR WORKER NODE
#Allow woker node to receive taffic from any worker node on vpc
resource "aws_security_group" "k8s_worker_nodes" {
  name = "k8_workers_${var.cluster_name}"
  description = "Worker nodes security group"
  vpc_id = aws_vpc.main.id

  ingress {
    cidr_blocks = [aws_vpc.main.cidr_block]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

  tags = {
    Name = "${var.cluster_name}_nodes"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group" "k8s_master_nodes" {
  name = "k8s_masters_${var.cluster_name}"
  description = "Master nodes security group"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.cluster_name}_nodes"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group_rule" "traffic_from_worker_to_masters" {
  type = "ingress"
  description = "Traffic from worker nodes to master nodes is allowed"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.k8s_master_nodes.id
  source_security_group_id = aws_security_group.k8s_worker_nodes.id
}

resource "aws_security_group_rule" "traffic_from_bastion_to_masters" {
  type = "ingress"
  description = "Traffic from bastion nodes to master nodes is allowed"
  from_port = 22
  to_port = 22
  protocol = "TCP"
  security_group_id = aws_security_group.k8s_master_nodes.id
  source_security_group_id = aws_security_group.bastion_node.id
}

resource "aws_security_group_rule" "masters_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.k8s_master_nodes.id
}