{
  config,
  lib,
  pkgs,
  inputs,
  pathConfig ? { },
  modulesPath,
  ...
}:

let
  cfg = config.custom.features.proxmox-guest;
in
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  # This option should be enabled on any machine that will be virtualized
  options.custom.features.proxmox-guest = {
    enable = lib.mkEnableOption "Options for Proxmox Virtual Machines";
  };

  config = lib.mkIf cfg.enable {

    # Enable QEMU Guest Agent for better Proxmox integration
    services.qemuGuest = {
      enable = true;
    };

    # why is this enabled on my VMs?
    services.smartd.enable = lib.mkForce false;

    # boot = {
    #   loader = {
    #     # Use systemd-boot for EFI systems
    #     systemd-boot.enable = true;
    #     systemd-boot.configurationLimit = lib.mkForce 5; # to save space
    #     efi.canTouchEfiVariables = true;
    #     grub.enable = lib.mkForce false;
    #   };

    #   # automatically grows the boot partition to match the size of the disk.
    #   growPartition = true; 
    # };

    boot = {
      growPartition = true;
      #kernelModules = [ "kvm-amd" ];
      kernelParams = lib.mkForce [ ];

      loader = {

        efi.canTouchEfiVariables = lib.mkForce false;
        efi.efiSysMountPoint = "/boot";
        grub = {
          enable = true;
          device = "nodev";
          #device = "/dev/disk/by-label/ESP";
          efiSupport = true;
          efiInstallAsRemovable = true;
        };
        systemd-boot.enable = lib.mkForce false;
        # wait for 3 seconds to select the boot entry
        # timeout = lib.mkForce 3;
      };


      initrd = {
        availableKernelModules = [ "9p" "9pnet_virtio" "ata_piix" "uhci_hcd" "virtio_blk" "virtio_mmio" "virtio_net" "virtio_pci" "virtio_scsi" ];
        kernelModules = [ "virtio_balloon" "virtio_console" "virtio_rng" ];
      };

      # clear /tmp on boot to get a stateless /tmp directory.
      tmp.cleanOnBoot = true;
    };

    # Define root FS, this is the disk we already generated
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      autoResize = true;
      fsType = "ext4";
    };

    # Mount the EFI System Partition
    fileSystems."/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };

    # Automatically format and mount the data disk
    fileSystems."/data" = {
      device = "/dev/sdb";
      fsType = "ext4";
      autoFormat = true;  # Automatically format if not formatted
      options = [ "defaults" ];
    };

    # reduce size of the VM
    services.fstrim = {
      enable = true;
      interval = "weekly";
    };

  };
}
