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

    boot = {
      loader = {
        # Use systemd-boot for EFI systems
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = lib.mkForce 5; # to save space
        efi.canTouchEfiVariables = true;
        grub.enable = lib.mkForce false;
      };

      # automatically grows the boot partition to match the size of the disk.
      growPartition = true; 
    };

    # Define root FS, this is the disk we already generated
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
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

  };
}
