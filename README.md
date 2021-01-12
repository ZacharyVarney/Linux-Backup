# Zachs Linux Backup
Backed up files of things I use & configs I have set for my GNU/Linux experience


## Single GPU Passthrough
We all know Linux gaming & software availability is getting better & better, but there are still occasions where you need to play a game or use specific software on Windows for whatever reason, mine ends up being anti-cheat-related reasons for games. If you're like me you hate having to run Windows natively, so I KVM virtualize it with single GPU passthrough. Here are the steps I take to get it running on my current machine, "specs listed below". I hope this helps you as it has me.

### Current PC Specs
CPU: AMD Ryzen 7 1700 (16) @ 3.00GHz  
GPU: MSI Gaming X 4G Geforce GTX 1050Ti  
Motherboard: ASRock B450M Pro4  
RAM: Crucial Ballistix (2x8GB)16GB DDR4 3000MHz  
PSU: EVGA B1 Bronze 500W  
Storage: 2 7200RPM 300GB Hard drives & 1 500GB Samsung 970 Evo NVME SSD  
Case: DIYPC D480W

### Requirments
- A motherboard capable of IOMMU
- A motherboard with sane IOMMU group separation("NOT NECISARALLY A REQUIREMENT BUT YOU WANT THAT")
- A dedicated GPU("I DON'T KNOE IF THIS WORKS WITH AN iGPU")
- A hex editor

### Getting started
#### 1. Install the necessary virtualization packages for your distribution

**I ONLY USE ARCH**  
So you will have to do a bit of research to follow the differences on fedora or a debian based distro.

```
sudo pacman -S qemu libvirt ovmf virt-manager ebtables iptables dnsmasq
```

#### 2. Setting up the services to run & auto start with your PC

```
sudo systemctl enable libvirtd.service  
sudo systemctl start libvirtd.service  
sudo systemctl enable virtlogd.socket  
sudo systemctl start virtlogd.socket  
sudo sudo systemctl restart libvirtd  
sudo virsh net-start default  
sudo virsh net-autostart default
```

#### 3. Getting IOMMU ready

To enable IOMMU you will need to add some parameters to your grub config file which is located at /etc/default/grub for me  

Find the line towards the top titled GRUB_CMDLINE_LINUX_DEFAULT & add amd_iommu=on iommu=pt or intel_iommu=on depending on what CPU you have, for example for me it would be
```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 amd_iommu=on iommu=pt"
```

After saving the changes to your grub config file we need to regenerate it by running the following command
```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

After regenerating the grub config file you will need to reboot your machine.  

Now we need to check our IOMMU groups, we can do this by running the following command
```
#!/bin/bash
shopt -s nullglob
for g in /sys/kernel/iommu_groups/*; do
    echo "IOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done;
done;
```

In this list find your GPU & see if it's in its own group, for example mine
```
IOMMU Group 13:
	23:00.0 VGA compatible controller [0300]: NVIDIA Corporation GP107 [GeForce GTX 1050 Ti] [10de:1c82] (rev a1)
	23:00.1 Audio device [0403]: NVIDIA Corporation GP107GL High Definition Audio Controller [10de:0fb9] (rev a1)
```

If it's in its own group you're golden, but if it's not then there are some extra measures you will need to take called ACS patching that I will not cover here  

#### 4. Setting up the hooks

**Special thanks to [risingprismtv](https://gitlab.com/risingprismtv) for providing these scripts & his [Discord](https://discord.com/invite/bh4maVc) for helping me get all this stuff working!**  

Follow these instructions to install the scripts properly
```
sudo rm -rf /etc/libvirt/hooks/qemu.d
git clone https://gitlab.com/risingprismtv/single-gpu-passthrough
sudo mkdir  /etc/libvirt/hooks/
cd single-gpu-passthrough/
git checkout minimal
sudo chmod +x install_hooks.sh
sudo ./install_hooks.sh
sudo systemctl restart libvirtd
```

#### 5. Getting a patched vbios rom for your GPU

There are two ways you can obtain the correct GPU rom

1. Getting it from https://www.techpowerup.com/vgabios/, it is possible it wont have yours & you will have to do #2  
**YOU NEED TO MAKE SURE YOU GET THE EXACT VERSION ON YOUR GPU**

2. Dump the current bios from your GPU, plenty of tutorials online on how to do that

Next you will need to patch the rom, if you have a NVIDIA 10 series card you can use [NVIDIA vBios Patcher](https://github.com/Matoking/NVIDIA-vBIOS-VFIO-Patcher)

If you don't you will have to patch it manually by opening the dumped/downloaded rom with a hex editor
