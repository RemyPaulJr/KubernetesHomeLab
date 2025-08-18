This file details the update_upgrade.ini ansible file and how it updates and upgrades my ubuntu vms.

1. -hosts: all
- this tells ansible to run this playbook and all hosts listed in my inventory.ini file.
2. become: yes
- this tells ansible to run tasks with sudo perms. necessary for updating/upgrading packages.
3. tasks:
- this section lists the actions ansible will perform.
4. - name:
- each name is a different task. this is a human readable description of the task, name it what you want to describe the tasks. i just named it the commands that will run as it's easy for me to understand.
5. apt:
- uses the ansible apt module, this is the package manager for ubuntu.
6. update_cache: yes
- runs sudo apt update
7. next task upgrade: dist
- runs sudo apt upgrade -y
8. autoremove: yes
- removes uneccessary packages that were auto installed but are no longer needed.
9. autoclean: yes
- cleans up the local package cache to save space.

# Summary
- This playbook does system maintenance on all my nodes:

- Updates the package lists (apt update).

- Upgrades all packages (apt upgrade -y).

- Cleans up unnecessary files and packages.
