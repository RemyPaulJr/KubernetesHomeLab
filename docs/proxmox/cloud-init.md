# Step 1: Download the Ubuntu Jammy Cloud Image

Run this on the proxmox host:

```bash
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
```

# Step 2: Create a new VM in Proxmox without a disk

Create the VM with the desired settings but without a disk (because we'll import the image as a disk).

Choose an ID that is open in your environment. I chose 9000.

```bash
qm create 9000 --name ubuntu-22.04-cloudinit --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
```

# Step 3: Import the cloud image as the VM disk

Import the downloaded .img file into Proxmox storage (adjust storage name):

```bash
qm importdisk 9000 jammy-server-cloudimg-amd64.img local-lvm
```

# Step 4: Attach the imported disk to the VM

```bash
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
```

# Step 5: Add the Cloud-Init drive

```bash
qm set 9000 --ide2 local:cloudinit
```

# Step 6: Configure boot order and serial console

```bash
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0
```

# Step 7: (Optional) Set OS type

```bash
qm set 9000 --ostype l26
```

# Step 8: Convert the VM to a template

```bash
qm template 9000
```

# Step 9: Verify creation

```bash
qm config 9000
```
---

# What happens with this Cloud-Init template VM?
- It’s a golden image: clean Ubuntu Server + cloud-init ready.

- When you clone this template to create new VMs, Proxmox + cloud-init let you customize hostname, SSH keys, IPs, etc. automatically at VM creation time.

- This makes provisioning fully automated and fast.

- Terraform can clone from this template, then inject Cloud-Init config for each VM.

# Why use a Cloud-Init template?
- Avoid manually installing/configuring each VM.

- Automate network, users, SSH keys, and other first-boot tasks.

- Perfect for infra as code workflows with Terraform + Ansible.