So far I've been interacting with my pxm vms via my windows powershell terminal. But to use ansible there's a few hoops to jump through on windows, so I will use my wsl ubuntu env to interact.

- First, I'll need to copy my existing ssh key I created and attached to my vms via terraform/cloud-init, to my wsl ubuntu env.

```bash
cp /mnt/c/Users/<YourWindowsUser>/.ssh/id_rsa ~/.ssh/
cp /mnt/c/Users/<YourWindowsUser>/.ssh/id_rsa.pub ~/.ssh/
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```
- Now the below command works:
```bash
ssh -i ~/.ssh/id_rsa user_name@192.xxx.x.xxx
```

To run my playbooks:
```bash
ansible-playbook -i inventory.ini update_upgrade.yml
```
