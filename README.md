# HomeLab
Repository for personal HomeLab configs

## Goals
1. Learn Docker/Containerization
1. Learn Terraform/Ansible
1. Learn VLAN/Routing/Networking
1. Learn CI/CD
1. Media + Personal Storage
1. Cyber shenanigans


## Repo Folder Structure
``` bash
├── Ansible
│   └── TBD
├── Configs
│   └── TOOL
│       └── config.yaml
├── Docker
│   ├── App1
│   │   ├── .env
│   │   ├── compose.yaml
│   │   ├── Data
│   │   └── Config
│   └── App2        
├── Notes
│   └── Troubleshooting
│       ├── PfSense.txt
│       ├── Network.txt
│       └── Proxmox.txt
├── Terraform
│   └── TBD
└── README.md
```

# Current Hardware
## Network
- [Pfsense+ Netgate 4200](https://shop.netgate.com/products/netgate-4200-max-pfsense-security-gateway)
- [TP-Link TL-SG3428XPP-M2](https://www.omadanetworks.com/us/business-networking/omada-switch-access-pro/sg3428xpp-m2/)
- [Omada EAP773](https://www.omadanetworks.com/us/business-networking/omada-wifi-ceiling-mount/eap773/)
- [Omada OC200](https://www.omadanetworks.com/us/business-networking/omada-controller-hardware/oc200/)

## Prod
Proxmox
- [Asus Pro WS B850M-ACE](https://www.asus.com/us/motherboards-components/motherboards/workstation/pro-ws-b850m-ace-se/)
- [Epyc 4545p](https://www.amd.com/en/products/processors/server/epyc/4005-series/amd-epyc-4545p.html)
- 2X 512GB Samsung boot SSD
- 2X 1TB data ssd
- [Intel B50 GPU](https://www.intel.com/content/www/us/en/products/sku/242615/intel-arc-pro-b50-graphics/specifications.html)
    - Used for AI
- [Intel 310 GPU](https://www.intel.com/content/www/us/en/products/sku/227958/intel-arc-a310-graphics/specifications.html)
    - Used for Jellyfin
 
## Test
Proxmox
- [GA-Z170X-UD5](https://www.gigabyte.com/Motherboard/GA-Z170X-UD5-rev-10)
- [i7-7700k](https://www.intel.com/content/www/us/en/products/sku/97129/intel-core-i77700k-processor-8m-cache-up-to-4-50-ghz/specifications.html)
- 32GB mixed DDR4
- 2X 256GB Intel boot SSD
- 1X 1TB data ssd
- [MSI 2070 Super GPU](https://www.msi.com/Graphics-Card/GeForce-RTX-2070-SUPER-GAMING-X/Specification)

## NAS
TrueNAS Scale
- [Supermicro A2SDI-H-TF-O](https://www.supermicro.com/en/products/motherboard/a2sdi-h-tf)
- Embedded Intel CPU
- 2x 240GB Intel boot SSD
- 3x 12TB WD Red HDD
- 4X 2TB enterprise SSD
- 750GB P4800X Optane U.2

## UPS
- EATON 5PX2200RT
