# Installation Steps

## Install NixOS

1. Boot into BIOS, make sure Secure Boot is disabled
2. Boot from NixOS USB
3. run `passwd` to set password for `nixos` user

### WiFi (ignore if wired in)

* `systemctl enable wpa_supplicant`
* `wpa_cli`
    * `scan`
    * `scan_results`
    * `add_network` (returns `network_id`)
    * `set_network <network_id> ssid "<ssid>"`
    * `set_network <network_id> psk "<passphrase>"`
    * `enable_network <network_id>`
    * `save_config`
    * `quit`
    

### Partitioning

On my motherboard, `/dev/nvme0n1` is the default path of my new M.2 SSD

* Create GPT partition table
    * `parted /dev/nvme0n1 -- mklabel gpt`
* Create root partition 
    * `parted /dev/nvme0n1 -- mkpart root ext4 512MB -16GB`
    * allows for 512MB boot partition and 16GB swap
* Create swap partition 
    * `parted /dev/nvme0n1 -- mkpart swap linux-swap -16GB 100%`
* Create boot partition 
    * `parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 512MB`
    * `parted /dev/nvme0n1 -- set 3 esp on`

### Formatting

* Format root partition 
    * `mkfs.ext4 -L nixos /dev/nvme0n1p1`
* Format swap partition 
    * `mkswap -L swap /dev/nvme0n1p2`
* Format boot partition 
    * `mkfs.fat -F 32 -n boot /dev/nvme0n1p3`

### Installing

* Mount the target filesystem (our new nixos root)
    * `mount /dev/disk/by-label/nixos /mnt`
* Mount the boot partition
    * `mkdir -p /mnt/boot`
    * `mount /dev/disk/by-label/boot /mnt/boot`
* Turn the swap on
    * `swapon /dev/nvme0n1p2`
* Generate initial config files
    * `nixos-generate-config --root /mnt`
        * This should generate `/mnt/etc/nixos/configuration.nix`
            * enable `network-manager`
            * change hostname
        * This should generate `/mnt/etc/nixos/hardware-configuration.nix`
* Install
    * `nixos-install`
* Reboot

## Initial setup

* Setup `overseer` user
    * `useradd --create-home overseer`
    * `passwd overseer`
* Enable flakes in original `configuration.nix`?
    * `nixos-rebuild switch`

## Switch to my config

* Clone `nix` config repo
    * `cd /home/overseer/`
    * Get github SSH key on system (`scp`?)
    * Clone repo
        * `ssh-agent bash -c 'ssh-add /somewhere/yourkey; git clone git@github.com:gideonwolfe/nix.git'` OR
        * `GIT_SSH_COMMAND='ssh -i private_key_file -o IdentitiesOnly=yes' git clone git@github.com:gideonwolfe/nix.git'`
* Copy generated `hardware-configuration.nix`
    * `cp /etc/nixos/hardware-configuration.nix /home/overseer/nix/configs/hosts/athena/hardware-configuration.nix`
* Install my flake
    * `nixos-rebuld switch --flake /home/overseer/nix`
