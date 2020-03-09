# Jenkins Setup

Jenkins AMI using Packer and env setup using Terraform.

  - Dockerised Jenkins
  - Pre-configured with preloaded plugins
  - Pre-configured with login username/pass

### Packer

Build a quick, immutable jenkins image with all bootstrap files inside the image.

```sh
$ cd packer
$ packer build jenkins.json
``` 


### Terraform

Copy the newly created AMI from the above step and add it to variables file. Run terraform init, plan and apply.

```sh
$ cd terraform
$ terraform init
$ terraform plan
$ terraform apply
```

### Jenkins

  - Access jenkins with https://<EC2_Public_DNS_NAME>:8080
  - One can add more required plugins to packer/bootstrap/plugins.txt file to pre-configure the jenkins with that plugin
  - One can change usename/password to login to jenkins by changing "hudsonRealm.createAccount("admin", "admin")" entry in packer/bootstrap/security.groovy file
