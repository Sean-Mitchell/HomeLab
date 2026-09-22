The goal of this section is to be able to create simple starter golden images provisioned by packer and ansible in concert to my proxmox server.
The hope is that I can automate template creation and so I can update my env easier the longer I have it.

To make sure that packer is set up, I need to run the `packer init packer.pkr.hcl`.  This will install the proxmox and ansible provisioners and make them available for later on

 `packer build -var-file="/vera/Packer/Packer-proxmox.pkrvars.hcl" ubuntu-server-2404.pkr.hcl`
 `packer validate -var-file="/vera/Packer/Packer-proxmox.pkrvars.hcl" .`
 `packer validate .`

 To validate this and fix silent errors that show up when you validate the template only, you need to call `packer validate .` in the /Packer folder and then iterate over errors
 To get rid of the missing username password proxmox_url, call `packer validate -var-file="/vera/Packer/Packer-proxmox.pkrvars.hcl" .`
 don't  use sudo when running packer build or validate as certain packer plugin installs are user specific and sudo is != vagrant