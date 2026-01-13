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
        systemd-boot.enable = lib.mkForce false; 
        # Using GRUB so we don't have to worry about another EFI disk
        grub = {
          enable = lib.mkForce true;
          #devices = [ "/dev/vda" ];
          devices = [ "nodev" ];
        };
      };

      # automatically grows the boot partition to match the size of the disk.
      growPartition = true; 
    };

    # Automatically format and mount the data disk
    fileSystems."/data" = {
      device = "/dev/sdb";
      fsType = "ext4";
      autoFormat = true;  # Automatically format if not formatted
      options = [ "defaults" ];
    };

    # Define root FS, this is the disk we already generated
    fileSystems."/" = {
      #device = "/dev/sda";
      # This is the label created by the qcow2 generator
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  };
}
