# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "ahci" "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8850353a-cafa-498f-964c-ecaadc12ca4f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4864-F2CD";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/2eed8a07-189e-4f6a-bb89-9157b54df477"; }];

  fileSystems."/drives/parity/parity1" = {
    #device = "/dev/disk/by-uuid/377b8cee-99a0-43af-a24f-3f7704d34579";
    device = "/dev/disk/by-label/parity";
    fsType = "xfs";
  };

  fileSystems."/drives/data/data1" = {
    #device = "/dev/disk/by-uuid/888b9b78-d9d7-4c50-8bdf-cff5e8e85827";
    device = "/dev/disk/by-label/data1";
    fsType = "xfs";
  };

  fileSystems."/drives/data/data2" = {
    #device = "/dev/disk/by-uuid/888b9b78-d9d7-4c50-8bdf-cff5e8e85827";
    device = "/dev/disk/by-label/data2";
    fsType = "xfs";
  };
  fileSystems."/drives/data/data3" = {
    device = "/dev/disk/by-label/data3";
    fsType = "xfs";
  };
  fileSystems."/drives/data/data4" = {
    device = "/dev/disk/by-label/data4";
    fsType = "xfs";
  };

  fileSystems."/pool" = {
    #device = "1:2";
    device = "/drives/data/data*";
    fsType = "fuse.mergerfs";
    options =
      [ "cache.files=partial" "dropcacheonclose=true" "category.create=mfs" ];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp17s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp18s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
