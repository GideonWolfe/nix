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

    services.qemuGuest = {
      enable = true;
    };

    boot = {
      loader = mkDefault {
        systemd-boot.enable = false; 
        # Using GRUB so we don't have to worry about another EFI disk
        grub = {
          enable = true;
          #devices = [ "/dev/vda" ];
          devices = [ "nodev" ];
        };
      };

      # automatically grows the boot partition to match the size of the disk.
      growPartition = true; 
    };


  };
}
