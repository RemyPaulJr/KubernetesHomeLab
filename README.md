# Kubernetes Home Lab

This repository documents the setup and management of a personal Kubernetes home lab environment.

## Table of Contents

- [Overview](#overview)
- [Why Kubernetes?](#why-kubernetes?)
- [Architecture](#architecture)
- [Applications to deploy](#applications-to-deploy)
- [Contributing](#contributing)
- [License](#license)

## Overview

This git repo is my central source of truth for everything going on with my homelab. It includes knowledge points, pain points, and everything in between. This will be used for my personal learning journey and for anything I want to self host.

## Why Kubernetes?

As my IT career is progressing I am seeing the importance of kubernetes. At work I currently don't have much oppurtunity to interact with k8s directly so I wanted to use it in my homelab where I'll be able to explore the tool from the ground up.

## Architecture

- Hardware is a old HP Elitedesk running Proxmox. I am able to make use of the 32gb of RAM and provision VMs to run all the different services I plan on running.
- OS for now is Ubuntu Server 20.04 for all VMs. It's the flavor of Linux I am used to.
- Infrastructure as Code (IaC) is done using terraform. Using terraform I am able to spin up VMs and destroy VMs in a matter of minutes.
- Automation of setting up the various VMs is done with Ansible. I am able to use playbooks to install all the necessary application, dependencies and updates to get my VMs ready for use with a simple command.
- Kubernetes is used to deploy applications. For this I went with K3s as it's a lightweight version of k8s meant for smaller homelabs like mine.

## Applications to deploy

- Argo-cd
- Grafana & Prometheus
- NGINX
- Maybe Loki
- Maybe Vault
- Jellyfin

## License

This project is licensed under the MIT License.