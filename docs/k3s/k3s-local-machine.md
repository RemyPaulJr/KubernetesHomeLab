I would like to be able to run kubectl commands on my local machine to interact with my k3s cluster. Eliminating the need to ssh into the master to do everything.

Being able to pretty much do everything I need on my homelab without having to ssh into the VMs is ideal for me.

This doc will outline the process of doing so.

## Step 1: Create .kube directory on local machine
```bash
mkdir -p ~/.kube
```

-p stands for "parents".
It tells mkdir to create parent directories if they don't exist, and not to throw an error if the directory already exists.

## Step 2: Install kubectl on local machine

>Official doc: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

Download the latest release with the command:
```bash
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```
Install kubectl:
```bash
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

## Step 3: SSH into k3s master and copy contents of k3s.yaml to local machine .kube directory
```bash
ssh user@<master_ip> "sudo cat /etc/rancher/k3s/k3s.yaml" > ~/.kube/config
```
I originally attempted to do a ssh copy '```scp```' but I needed to use a root user. I used my vm user I use to ssh into my VMs created with my cloud-init template, but now thinking about it maybe I could have passed the root user instead.

Regardless, this works and to fix I just did a ssh and sudo cat to reach the contents of the k3s.yaml and passed it to my local machines .kube directory ```>``` into a new file named config.

## Step 4: Change server IP in config file to reference master nodes IP

Initially the config file will have a server: key referencing an IP like 127.0.0 etc.

Change that IP to the master IP we used to ssh into.