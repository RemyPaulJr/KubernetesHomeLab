# Terraform Proxmox VM Deployment (bpg/proxmox)

## Overview

This Terraform configuration deploys a 3-node K3s cluster (1 master, 2 workers) into a Proxmox Virtual Environment (PVE) using the bpg/proxmox provider.
It uses a cloud-init template as the base for each VM, and provisions CPU, memory, storage, and network settings.

### Prerequisites
1. Proxmox VE up and running.

2. Cloud-init template available in Proxmox (example VM ID: 9000).

3. Terraform v1.5+ installed.

4. API Token created in Proxmox with VM management permissions.

5. SSH key pair generated (public key path: ~/.ssh/id_rsa.pub).

### Notes
- The disk size in bpg/proxmox is an integer in GB (no G suffix required).

- Ensure your cloud-init template has SSH enabled and matches your desired OS.

- API token must have VM create/modify/delete permissions.

- If Terraform state gets corrupted, manually remove VMs from Proxmox and delete .terraform & terraform.tfstate* before retrying.

- I wasn't able to use the Telmate provider because the plugin wouldn't capture the state with terraform for me. I'm still not entirely sure why but when switching to bpg it worked seamlessly. Could be because telmate works better for older pxm versions or terraform versions, it still works to setup but can't destroy your setup since terraform won't know the state.

- I also needed to do a lot of tinkering in Proxmox GUI to get terraform to coporate. Involving permissions mostly. In localnetwork I had to create two permissions, one for my terraform user and another for my terraform api token that's assigned to the user. I had to give it the **PVESDNUser** role.

- Another tinker in Proxmox GUI was the cloud-init template. I'm assuming you can specify the user and password upon creation but I didn't so I had to specify this initally to get into my VMs when using Telmate at first. I'm assuming the setup I had with telmate didn't fully integrate 100% with cloud-init because the ip address wouldn't get assigned and I had trouble logging in since I didn't know the username or password. You can specify this within Cloud-init which I did and ended up not really mattering since switching to bpg I can now access via my ssh keys but it may be good to have in case I ever need it in the future.

