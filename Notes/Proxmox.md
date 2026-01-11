# Clean Install Init
1. Install Proxmox (Current version is 9.1)
1. Run [Post Install Helper Script](https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install)
    - `bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/tools/pve/post-pve-install.sh)"`
    1. Disable `pve-enterprise`
    1. Disable `ceph-enteprise`
    1. Add `pve-no-subscription` 
    1. Don't add `ceph-enterprise`
    1. Don't add `pvetest`
    1. Disable subscription nag
    1. Disable high availability
    1. Disable Corosync
    1. Update Proxmox VE
    1. Reboot
        - Outputs: Completed Post Install Routines

## Setup Passthrough & Disable i915/XE Graphics
1. Validate AMD IOMMU is on
    - Copied from here: [Link](https://forum.proxmox.com/threads/enabling-iommu.119217/post-517232)
    - `for d in /sys/kernel/iommu_groups/*/devices/*; do n=${d#*/iommu_groups/*}; n=${n%%/*}; printf 'IOMMU group %s ' "$n"; lspci -nns "${d##*/}"; done`
    - Ouput should be along the lines of:
    ```
    IOMMU group 0 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge [1022:14da]
    IOMMU group 10 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 0 [1022:14e0]
    IOMMU group 10 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 1 [1022:14e1]
    IOMMU group 10 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 2 [1022:14e2]
    IOMMU group 10 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 3 [1022:14e3]
    IOMMU group 10 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 4 [1022:14e4]
    IOMMU group 10 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 5 [1022:14e5]
    IOMMU group 10 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 6 [1022:14e6]
    IOMMU group 10 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 7 [1022:14e7]
    IOMMU group 11 01:00.0 PCI bridge [0604]: Intel Corporation Device [8086:e2ff] (rev 01)
    IOMMU group 12 02:01.0 PCI bridge [0604]: Intel Corporation Device [8086:e2f0]
    IOMMU group 13 02:02.0 PCI bridge [0604]: Intel Corporation Device [8086:e2f1]
    IOMMU group 14 03:00.0 VGA compatible controller [0300]: Intel Corporation Battlemage G21 [Intel Graphics] [8086:e212]
    IOMMU group 15 04:00.0 Audio device [0403]: Intel Corporation Device [8086:e2f7]
    IOMMU group 16 05:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Upstream Port [1022:43f4] (rev 01)
    IOMMU group 17 06:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
    IOMMU group 17 07:00.0 PCI bridge [0604]: Intel Corporation Device [8086:4fa1] (rev 01)
    IOMMU group 17 08:01.0 PCI bridge [0604]: Intel Corporation Device [8086:4fa4]
    IOMMU group 17 08:04.0 PCI bridge [0604]: Intel Corporation Device [8086:4fa4]
    IOMMU group 17 09:00.0 VGA compatible controller [0300]: Intel Corporation DG2 [Arc A310] [8086:56a6] (rev 05)
    IOMMU group 17 0a:00.0 Audio device [0403]: Intel Corporation DG2 Audio Controller [8086:4f92]
    IOMMU group 18 06:08.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
    IOMMU group 18 0b:00.0 PCI bridge [0604]: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150] (rev 06)
    IOMMU group 18 0c:00.0 VGA compatible controller [0300]: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000] (rev 52)
    IOMMU group 19 06:09.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
    IOMMU group 19 0d:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Controller I226-LM [8086:125b] (rev 04)
    IOMMU group 1 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge [1022:14db]
    IOMMU group 20 06:0a.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
    IOMMU group 20 0e:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. Device [10ec:8127] (rev 05)
    IOMMU group 21 06:0b.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
    IOMMU group 22 06:0c.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
    IOMMU group 22 10:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 800 Series Chipset USB 3.x XHCI Controller [1022:43fc] (rev 01)
    IOMMU group 23 06:0d.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01)
    IOMMU group 23 11:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset SATA Controller [1022:43f6] (rev 01)
    IOMMU group 24 12:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Granite Ridge [Radeon Graphics] [1002:13c0] (rev d1)
    IOMMU group 25 12:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Family 19h PSP/CCP [1022:1649]
    IOMMU group 26 12:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 3.1 xHCI [1022:15b6]
    IOMMU group 27 12:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 3.1 xHCI [1022:15b7]
    IOMMU group 28 13:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 2.0 xHCI [1022:15b8]
    IOMMU group 2 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge [1022:14da]
    IOMMU group 3 00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge [1022:14db]
    IOMMU group 4 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge [1022:14da]
    IOMMU group 5 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge [1022:14da]
    IOMMU group 6 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge [1022:14da]
    IOMMU group 7 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Internal GPP Bridge to Bus [C:A] [1022:14dd]
    IOMMU group 8 00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Internal GPP Bridge to Bus [C:A] [1022:14dd]
    IOMMU group 9 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 71)
    IOMMU group 9 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
    ```
1. Add VFIO to the modules`nano /etc/modules`
    - Paste: 
        ``` 
        vfio
        vfio_iommu_type1
        vfio_pci
        ```
    - Save and close
1. Add ``iommu=pt` to grub command line
    1. Call `nano /etc/default/grub` to edit the grub file
    1. Add `iommu=pt` to the default command line
    1. Save & quit the file
    1. Call `update-grub`
1. Blacklist `xe` & `i915` drivers
    1. Navigate to `/etc/modprobe.d/`
    1. Create & edit a `blacklist.conf` file with `nano blacklist.conf`
    1. Add the following 2 lines
    ```
    blacklist xe
    blacklist i915
    ```
    1. Call `echo "softdep xe pre: vfio-pci" >> /etc/modprobe.d/xe.conf`
    1. Call `echo "softdep i915 pre: vfio-pci" >> /etc/modprobe.d/i915.conf`
    1. Create & edit a `vfio.conf` file with `nano vfio.conf`
    1. Add the following line: `options vfio-pci ids=8086:e212,8086:56a6`
        - Depending on where the physical device is in the motherboad, these IDs may change(?)
    1. Update initramfs to update the modules `update-initramfs -u -k all`
1. Reboot Proxmox: `reboot now`
1. Validate if the `xe` or `i915` drivers are loaded by calling `lspci -nnk`
    - You should see a screen for anything that uses those drivers with the output: 
    <br>
    <img width=50% height=50% src="../Assets/Notes/Proxmox/IOMMU-VFIO-Kernel-Driver-Module-XE.png">
1. Passthrough should now be good to go for the Intel A310 & the Intel B50 GPUs