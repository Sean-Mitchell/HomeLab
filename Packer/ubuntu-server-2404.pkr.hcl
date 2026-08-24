variable "proxmox_api_url" {
    type = string
    default = env("PROXMOX_API_URL")
}

variable "proxmox_api_token_id" {
    type = string
    default = env("PROXMOX_API_TOKEN_ID")
    sensitive = true
}

variable "proxmox_api_token_secret" {
    type = string
    default = env("PROXMOX_API_TOKEN_SECRET")
    sensitive = true
}

source "proxmox-iso" "ubuntu-ai-server" {
 
    # Proxmox Connection Settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    # (Optional) Skip TLS Verification
    # insecure_skip_tls_verify = true
    
    # VM General Settings
    node = "prod"
    vm_name = "ubuntu-ai-server"
    template_description = "Intel B50 based GPU server for Llama.cpp"

    # VM OS Settings
    # (Option 1) Local ISO File
    # iso_file = "local:iso/ubuntu-20.04-live-server-amd64.iso"
    # - or -
    # (Option 2) Download ISO
    boot_iso = {
        iso_checksum = "e907d92eeec9df64163a7e454cbc8d7755e8ddc7ed42f99dbc80c40f1a138433"
        iso_url = "https://releases.ubuntu.com/24.04.4/ubuntu-24.04.4-live-server-amd64.iso"
        type = "scsi"
        unmount_iso = true
    }
    

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = "virtio-scsi-pci"

    disks {
        disk_size = "20G"
        format = "qcow2"
        storage_pool = "local-lvm"
        storage_pool_type = "lvm"
        type = "virtio"
    }

    # VM CPU Settings
    cores = "4"
    
    # VM Memory Settings
    memory = "8096" 

    # VM Network Settings
    network_adapters {
        model = "virtio"
        bridge = "vmbr0"
        firewall = "false"
    } 

    # VM Cloud-Init Settings
    cloud_init = true
    cloud_init_storage_pool = "local-lvm"

    # PACKER Boot Commands
    boot_command = [
        "<esc><wait>",
        "<esc><wait>",
        "c<wait>",
        "set gfxpayload=keep",
        "<enter><wait>",
        "linux /casper/vmlinuz quiet<wait>",
        " autoinstall<wait>",
        " ds=nocloud;<wait>",
        "<enter><wait>",
        "initrd /casper/initrd",
        "<enter><wait>",
        "boot<enter><wait>",
    ]

    # PACKER Autoinstall Settings
    http_directory = "ubuntu-ai-server" 
    # (Optional) Bind IP Address and Port
    // http_bind_address = "0.0.0.0"
    http_port_min = 8800
    http_port_max = 8810

    ssh_username = "ubuntu"

    # (Option 1) Add your Password here
    # ssh_password = "PLAINTEXT_PASSWORD"
    # - or -
    # (Option 2) Add your Private SSH KEY file here
    ssh_private_key_file = "~/.ssh/id_rsa"

    # Raise the timeout, when installation takes longer
    ssh_timeout = "20m"
}

# Build Definition to create the VM Template
build {

    name = "ubuntu-ai-server"
    sources = ["source.proxmox-iso.ubuntu-ai-server"]

    # Provisioning the VM Template for Cloud-Init Integration in Proxmox #1
    provisioner "shell" {
        inline = [
            "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
            "sudo rm /etc/ssh/ssh_host_*",
            "sudo truncate -s 0 /etc/machine-id",
            "sudo apt -y autoremove --purge",
            "sudo apt -y clean",
            "sudo apt -y autoclean",
            "sudo cloud-init clean",
            "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
            "sudo rm -f /etc/netplan/00-installer-config.yaml",
            "sudo sync",
        ]
    }

    # Provisioning the VM Template for Cloud-Init Integration in Proxmox #2
    provisioner "file" {
        source = "cloud-init-config/99-pve.cfg"
        destination = "/tmp/99-pve.cfg"
    }

    # Provisioning the VM Template for Cloud-Init Integration in Proxmox #3
    provisioner "shell" {
        inline = [ 
            "sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg"
            ]
    }

    # Add additional provisioning scripts here
    # ...

}
