# Inventory ini file meaning:
Here I'll outline the purpose of this file and what everything does. This is for my personal learning journey and referring back to in the future.

- First, we define the groups using []. So master is where the info for my k3s-master vm.
- ansible_host= defines the ip of the vm.
- ansible_user= defines the username to access the vm.
- note, since we copied the ssh keys over we have passwordless login.
- next we define the workers group with the two worker vms.
- with this we can run tasks on each group doing the below:
```bash
ansible -i inventory.ini workers -m ping
```
- [all:vars] says apply everything in this group to all hosts in the inventory.
- ansible_python_interpreter= tells ansible which Python to use on the remote VM. most modern ubuntu systems default to python3.

# Summary

- Groups: [master] and [workers] → organize hosts.

- Host lines: define aliases, IPs, and SSH users.

- [all:vars] → set global variables (like Python interpreter).

Basically, this file is how Ansible knows “who to talk to and how”.
