packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "profile" {
  type = string
}

variable "region" {
  type = string
}
locals {
  username = "ec2-user"
}
source "amazon-ebs" "windows-build" {
  ami_name      = "packer-windows-build-${uuidv4()}"
  communicator  = "winrm"
  instance_type = "t2.xlarge"
  profile       = var.profile
  region        = var.region
  ssh_username  = local.username

  source_ami_filter {
    filters = {
      name                = "Windows_Server-2019-English-Full-ContainersLatest-*"
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }

    owners      = ["amazon"]
    most_recent = true
  }
  ami_block_device_mappings {
    volume_type = "gp3"
    device_name = "/dev/sda1"
    delete_on_termination = true
    volume_size = 100
    encrypted = true
  }
  tags = {
    Name = "packer-windows-build"
  }
  user_data_file = "../windows/userdata_win_build.txt"
  winrm_password = "<Your PASSWD>"
  winrm_username = "Administrator"
}
build {
  sources = [
    "source.amazon-ebs.windows-build"]
  provisioner "powershell" {
    environment_vars = [
      "DEVOPS_LIFE_IMPROVER=PACKER"]
    inline = [
      "Write-Host \"HELLO NEW USER; WELCOME TO $Env:DEVOPS_LIFE_IMPROVER\"",
      "Write-Host \"You need to use backtick escapes when using\"",
      "Write-Host \"characters such as DOLLAR`$ directly in a command\"",
      "Write-Host \"or in your own scripts.\""]
  }
  provisioner "powershell" {
    inline = [
      "cd C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts",
      "./InitializeInstance.ps1 -SchedulePerBoot"
    ]
  }
  provisioner "windows-restart" {}
  provisioner "powershell" {
    script = "../windows/Enable_smb.ps1"
  }
  provisioner "powershell" {
    script = "../windows/chocolatey-install.ps1"
  }
}
