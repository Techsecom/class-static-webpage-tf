resource "hcloud_ssh_key" "ssh-key" {
  name       = "Developer SSH Key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "hcloud_server" "node1" {
  count       = var.vm-count
  name        = "dev-o1-${count.index}"
  image       = "ubuntu-22.04"
  server_type = "cpx21"
  location    = "ash"
  ssh_keys = [
    hcloud_ssh_key.ssh-key.id
  ]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  connection {
    user = "root"
    type = "ssh"
    host = self.ipv4_address
    private_key = file("~/.ssh/id_rsa")
  }
  provisioner "remote-exec" {
    inline = [
      "apt-get update -y",
      "apt-get install -y apache2",
      "rm -rf /var/www/html/*",
    ]
  }
  provisioner "file" {
    source      = "static-webpage/"
    destination = "/var/www/html/"
    
  }
  provisioner "file" {
    source      = "static-webpage/index.html"
    destination = "/var/www/html/index.html"
  }
}

variable "vm-count" {
  type    = number
  default = 5
}

output "name" {
  value = hcloud_server.node1.*.name

}

output "ipv4_address" {
  value = hcloud_server.node1.*.ipv4_address
}