


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
            * change hostname to `athena`
            * uncomment/change extra user to `overseer`
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
        * Ensure SSH key has correct perms with `chmod 600 <private_key_file>`
        * `GIT_SSH_COMMAND='ssh -i private_key_file -o IdentitiesOnly=yes' git clone git@github.com:gideonwolfe/nix.git'`
* Copy generated `hardware-configuration.nix`
    * `cp /etc/nixos/hardware-configuration.nix /home/overseer/nix/configs/hosts/athena/hardware-configuration.nix`
* Add `hardware-configuration.nix`
    * `GIT_SSH_COMMAND='ssh -i private_key_file -o IdentitiesOnly=yes' git add /home/overseer/nix'`
* Install `home-manager`
    * `sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager`
    * `sudo nix-channel --update`
* Install my flake
    * `nixos-rebuld switch --flake /home/overseer/nix`
* Build home-manager config
    * `nix run #.homeConfigurations.overseer.activationPackage`
* Switch to mainline repo
    * `git remote set-url origin github:gideonwolfe/nix`
    * SSH private key should be in `configs/ssh/keys/`


## Set up drives

I plugged both drives into the two top hot swap slots, and my `lsblk` looks like

```
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0  7.3T  0 disk 
sdb           8:16   0  7.3T  0 disk 
nvme0n1     259:0    0  1.8T  0 disk 
├─nvme0n1p1 259:1    0  1.8T  0 part /nix/store
│                                    /
├─nvme0n1p2 259:2    0 14.9G  0 part [SWAP]
└─nvme0n1p3 259:3    0  487M  0 part /boot
```

`sdb` will be my parity drive, and `sda`, `sdd`, etc will be for data drives that will be merged under one pool with `MergerFS`. I want to do by label because the `sd{a-z}` doesn't remain persistent on reboot

### Format Drives

#### Parity Drive

[Snapraid FAQ](https://www.snapraid.it/faq#fs) suggests that the XFS filesystem is best for parity drives

* Create GPT partition table
    * `parted /dev/sdb -- mklabel gpt`
* Create main partition 
    * `parted /dev/sdb -- mkpart parity xfs 0% 100%`

Now, the top of `lsblk` should include

```
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0  7.3T  0 disk 
sdb           8:16   0  7.3T  0 disk 
└─sdb1        8:17   0  7.3T  0 part 
```

* Create XFS filesystem
    * `mkfs.xfs -L parity /dev/sdb1`
* Create mount point for parity partition
    * `mkdir -p /drives/parity/parity1`
* mount parity partition
    * `mount /dev/sdb1 /drives/parity/parity1`

Which gives us

```
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0  7.3T  0 disk 
sdb           8:16   0  7.3T  0 disk 
└─sdb1        8:17   0  7.3T  0 part /drives/parity/parity1
```

#### Data Drive 1

Going off of the config from above, we know that the first data drive is called `sda`.

* Create GPT partition table
    * `parted /dev/sda -- mklabel gpt`
* Create main partition 
    * `parted /dev/sda -- mkpart data xfs 0% 95%`
    * I want to limit the drive so parity file doesnt get over drive limit

Now we have our partition `sda1`, with 6.9TB storage

```
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0  7.3T  0 disk 
└─sda1        8:1    0  6.9T  0 part 
sdb           8:16   0  7.3T  0 disk 
└─sdb1        8:17   0  7.3T  0 part /drives/parity/parity1
```

* Create XFS filesystem
    * `mkfs.xfs -L data1 /dev/sda1`
* Create mount point for parity partition
    * `mkdir -p /drives/data/data1`
* mount parity partition
    * `mount /dev/sda1 /drives/data/data1`

Now here is our full output of `lsblk`

```
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0  7.3T  0 disk 
└─sda1        8:1    0  6.9T  0 part /drives/data/data1
sdb           8:16   0  7.3T  0 disk 
└─sdb1        8:17   0  7.3T  0 part /drives/parity/parity1
nvme0n1     259:0    0  1.8T  0 disk 
├─nvme0n1p1 259:1    0  1.8T  0 part /nix/store
│                                    /
├─nvme0n1p2 259:2    0 14.9G  0 part [SWAP]
└─nvme0n1p3 259:3    0  487M  0 part /boot
```

Now we need to make this permanent.

* Generate config
    * `sudo nixos-generate-config`
* Copy relevant lines from `/etc/nixos/hardware-configuration.nix` into `~/nix/configs/hosts/athena/hardware-configuration.nix`

In this case, the tool added

```

```

* rebuild `nix`

## Set up Snapraid

drives, content files, and parity files are configured in `./system/system/snapraid.nix`

* Create a directory on boot drive for a content file
    * `mkdir -p /snapraid/content/`
    * `mkdir -p /drives/data/data1/snapraid/content/`
* Sync
    * `sudo snapraid sync`

## Set up mergerfs

First setup run `mergerfs /drives/data/data*: /pool/`

I ran `nixos-generate-config`, then I copied the config out of `/etc/nixos/hardware-configuration.nix` into `./hardware-configuration.nix`

```nix
fileSystems."/pool" =
{ 
  device = "/drives/data/data*";
  fsType = "fuse.mergerfs";
  options = ["cache.files=partial" "dropcacheonclose=true" "category.create=mfs"];
};

```
changed the config to use a glob (so I can easily add more labeled drives) and added options

## Create folders in pooled drives

So the pool can have a symmetrical set of folders on each data drive, I like to create them explicitly so each folder exists on each drive

`mkdir -p /drives/data/data{1..2}/data/media/{tv,music,movies,downloads}`


# Diagram

@startuml Server

cloud Internet


node athena {
    package disks {

        storage "parity (8tb)" as parity1Drive {

        }
        storage "data1 (8tb)" as data1Drive {

        }
        storage "data2 (8tb)" as data2Drive {

        }
        storage "system (2tb)" as systemDrive {

        }

    }

    frame NixOS {
        folder "/" as root {
            folder /dev/disks/by-label/ {
                [parity]
                [data1]
                [data2]
                [boot]
                [nixos]
                [swap]
            }
            folder /drives/ {
                folder "data/" {
                    storage "data1" as _data1{ 

                        folder "/snapraid/content/" as data1snapraidcontentfolder {
                            artifact "snapraid.content" as snapcontent2
                        }

                        folder "/pool/" as data1pool {
                            folder "data" as pooldata1
                        }

                    }
                    storage "data2" as _data2{ 
                        folder "/pool/" as data2pool {
                            folder "data" as pooldata2
                        }
                    }
                }
                folder "parity/" {
                    storage "parity1" as _parity {
                        artifact "snapraid.1-parity"
                    }
                }
            }
            folder "/pool/" as pool {
                folder "data" as pooldata {
                    folder "media" as poolmedia {
                        folder "tv" as pooltv
                        folder "movies" as poolmovies
                        folder "music" as poolmusic
                        folder "books" as poolbooks
                    
                    }
                }
            }

            folder /home/overseer/ {

                folder nix {

                }

                folder /server/services/ {

                }
            }

            folder "/snapraid/content/" as systemsnapraidcontentfolder {
                artifact "snapraid.content" as snapcontent1
            }
        }

        frame snapraid {

        }

        cloud docker {
            package Media {
                Node Jellyfin
                Node Jellyseerr
                Node Lidarr
                Node Radarr
                Node Sonarr
                Node NZBGet
                Node Tdarr
            }
            Node Traefik
        }


    }
}

[systemDrive]-->[boot]
[systemDrive]-->[nixos]
[systemDrive]-->[swap]

[data1Drive]-->[data1]
[data2Drive]-->[data2]
[parity1Drive]-->[parity]

[data1]-->[_data1]
[data2]-->[_data2]
[parity]-->[_parity]
[nixos]-->[root]

[snapraid]-->[snapcontent1]
[snapraid]-->[snapcontent2]
[snapraid]-->[snapraid.1-parity]
		
[pooldata1]-->[pooldata]
[pooldata2]-->[pooldata]


[Internet]-->[Traefik]
[Traefik]-->[Jellyfin]
[Traefik]-->[Jellyseerr]

[Jellyfin]-->[pooltv]
[Jellyfin]-->[poolmovies]
[Jellyfin]-->[poolmusic]
[Jellyfin]-->[poolbooks]

[Jellyseerr]-->[Jellyfin]
@enduml


