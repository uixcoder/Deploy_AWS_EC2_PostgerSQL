#IP of aws instances copied to a file hosts file in local system
resource "local_file" "hosts_file" {
  content  = <<EOT
[app_server]
app_host ansible_host=${aws_instance.App_PetClinic_TF.public_ip}
[db_server]
db_host ansible_host=${aws_instance.DB_PetClinic_TF.public_ip}
EOT  
  filename = "../config/hosts"
}

#IP of aws instances copied to a file hosts file in local system
resource "local_file" "hosts_file_ip" {
  content  = <<EOT
#!/bin/bash

server_ip='${aws_instance.App_PetClinic_TF.public_ip}'
db_server_ip='${aws_instance.DB_PetClinic_TF.public_ip}'
EOT  
  filename = "../config/hosts_app"
}
