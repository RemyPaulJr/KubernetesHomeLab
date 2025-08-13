# Proxmox provider using bpg registry
terraform {
      required_providers {
        proxmox = {
          source  = "bpg/proxmox"
          version = "~> 0.65.0" # Specify latest stable version in tf registry
        }
      }
    }

# Defining connection to my local proxmox
provider "proxmox" {
  endpoint = var.virtual_environment_endpoint
  api_token = var.virtual_environment_api_token
  insecure = true
}

# K3s-master VM definition
resource "proxmox_virtual_environment_vm" "k3s-master" {
  node_name = "pve"
  name      = "k3s-master"
  
  clone {
    vm_id = 9000  # your cloud-init template ID
    full  = true
  }

  cpu {
    cores        = 2
    type         = "x86-64-v2-AES"  # recommended for modern CPUs
  }
  
  memory {
    dedicated = 4096 # Allocate 4096 MB (4GB) of dedicated memory
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 20
    file_format  = "raw"
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    interface           = "ide2"
    type                = "nocloud"
    
    user_account {
      keys = [file("~/.ssh/id_rsa.pub")]
    }

    ip_config {
      ipv4 {
        address = var.master_ip
        gateway = var.gateway_ip
      }
    }
  }
}

# K3s-worker VMs definition
resource "proxmox_virtual_environment_vm" "k3s-worker" {
  count = length(var.worker_ips)
  node_name = "pve"
  name      = "k3s-worker-${count.index + 1}"
  
  clone {
    vm_id = 9000  # your cloud-init template ID
    full  = true
  }

  cpu {
    cores        = 4
    type         = "x86-64-v2-AES"  # recommended for modern CPUs
  }
  
  memory {
    dedicated = 8192 # Allocate 8192 MB (8GB) of dedicated memory
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 40
    file_format  = "raw"
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    interface           = "ide2"
    type                = "nocloud"
    
    user_account {
      keys = [file("~/.ssh/id_rsa.pub")]
    }

    ip_config {
      ipv4 {
        address = "${var.worker_ips[count.index]}"
        gateway = var.gateway_ip
      }
    }
  }
}