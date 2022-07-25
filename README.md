# packer-ec2-windows-jenkins-slave
packer ec2 windows jenkins slave

Create an AWS jenkins slave over windows for EC2 plugin
```packer init win2019-jenkins-node.pkr.hcl
packer build -var 'profile=<YOUR AWS PROFILE>' -var 'region=<YOUR AWS REGION>' win2019-jenkins-node.pkr.hcl```
