data "template_file" "hosts" {
  template = "${file("${path.module}/templates/hosts.cfg")}"
  depends_on = [
    "aws_instance.master",
    "aws_instance.worker1",
    "aws_instance.worker2"
  ]
  vars {
    master_ip = "${aws_instance.master.public_ip}"
	worker1_ip = "${aws_instance.worker1.public_ip}"
	worker2_ip = "${aws_instance.worker2.public_ip}"
	private_key = "${var.PATH_TO_PRIVATE_KEY}"
  }
}

resource "null_resource" "hosts" {
  triggers {
    template_rendered = "${data.template_file.hosts.rendered}"
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.hosts.rendered}' > hosts"
  }
  provisioner "local-exec" {
    command = <<EOF
      ANSIBLE_HOST_KEY_CHECKING=False \
      ansible-playbook -i hosts playbook.yml
      EOF
  }
}

