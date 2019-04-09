resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "master" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.sgswarm.id}",
    "${data.aws_security_group.default.id}"
  ]
  provisioner "file" {
    source = "${var.BOOTSTRAP_NAME}"
    destination = "/tmp/${var.BOOTSTRAP_NAME}"
  }
  provisioner "file" {
    source = "../${var.EF_INSTALLER_NAME}"
    destination = "/tmp/${var.EF_INSTALLER_NAME}"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/${var.EF_INSTALLER_NAME}"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/${var.BOOTSTRAP_NAME}",
      "sudo /tmp/${var.BOOTSTRAP_NAME}"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
  tags {
    Name  = "master"
  }
}

resource "aws_instance" "worker1" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.sgswarm.id}",
    "${data.aws_security_group.default.id}"
  ]
  provisioner "file" {
    source = "${var.BOOTSTRAP_NAME}"
    destination = "/tmp/${var.BOOTSTRAP_NAME}"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/${var.BOOTSTRAP_NAME}",
      "sudo /tmp/${var.BOOTSTRAP_NAME}"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
  tags {
    Name  = "worker1"
  }
}

resource "aws_instance" "worker2" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.sgswarm.id}",
    "${data.aws_security_group.default.id}"
  ]
  provisioner "file" {
    source = "${var.BOOTSTRAP_NAME}"
    destination = "/tmp/${var.BOOTSTRAP_NAME}"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/${var.BOOTSTRAP_NAME}",
      "sudo /tmp/${var.BOOTSTRAP_NAME}"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
  tags {
    Name  = "worker2"
  }
}
