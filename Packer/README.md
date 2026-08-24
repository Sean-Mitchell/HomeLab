The goal of this section is to be able to create simple starter golden images provisioned by packer and ansible in concert to my proxmox server.
The hope is that I can automate template creation and so I can update my env easier the longer I have it.

To make sure that packer is set up, I need to run the `packer init packer.pkr.hcl`.  This will install the proxmox and ansible provisioners and make them available for later on
