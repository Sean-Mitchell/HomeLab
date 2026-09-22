# Table of Contents
- [IaC Secrets](#iac-secrets)
- [Packer](#packer)
- [Ansible](#ansible)
- [Docker](#ansible)

## IaC Secrets
- [x] Define "at-rest" management of IaC secrets
    - [X] Research Vault
    - [X] Research Ansible-Vault
    - [X] Research Docker Swarm Secrets vs .env files
- [X] Purchase Yubikey + USBs
    - [X] Research Yubikey + Veracrypt + USB
        - [tutorial](https://yubico.gitbook.io/yubikey5/tutorials/veracrypt)
- [X] Create Veracrypt file
- [X] Set Veracrypt file up to be used with my Yubikeys + Long Passpharse
    - Using Veracrypt for variables and passwords instead of vault like Jim's Garage example
~~  - [ ] Create "Password" file in veracrypt~~
~~        - [ ] To use the Jim's Garage password command [Run Here](https://youtu.be/DoiBm5VC-oo?t=410)~~
    - [ ] Create SSH key in veracrypt

## Vagrant Homelab-Deploy VM
- [X] Update Vagrant box to mount the entire Homelab repo as a shared folder so that I only need to pull this repo once
    - [X] TBD: Figure out how to elegantly copy the repo + silo any actions to happen on the VM only
        - Make sure secrets are never unencrypted on host machine
    - [X] Search for a provisioner box w/ a GUI so that I can do veracrypt shenanigans via the GUI & test via the CLI
        - ^ Just doing CLI only, no need for GUI

## Packer

## Ansible

## Docker