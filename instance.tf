provider "aws" {
  access_key = "From security of AWS IAM"
  secret_key = "From security of AWS IAM"
  region = "us-east-2"
}

resource "aws_instance" "terraform_example" {
  ami = "ami-00bf61217e296b409"
  instance_type = "t2.micro"
  key_name = "SM"

  provisioner "file" {
    source = "myscript.sh"
destination = "/tmp/myscript.sh"
  }
provisioner "remote-exec" {
    inline = [
   "sudo chmod 755 /tmp/myscript.sh",
   "sudo sh /tmp/myscript.sh",
    ]
  }

  connection {
host= "${self.public_ip}"
    user = "ec2-user"
    private_key = "${file("SM.pem")}"
  }

}

