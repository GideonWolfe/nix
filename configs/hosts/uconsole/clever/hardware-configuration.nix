{ pkgs, pkgs-unstable, config, lib, ... }:

{
  imports = [
    ./bootloader.nix
  ];
  boot = {
    kernelPackages = pkgs-unstable.linuxPackages_rpi4;
    loader = {
      grub.enable = false;
    };
  };
  fileSystems = {
    "/boot/firmware" = {
      label = "FIRMWARE";
    };
    "/" = {
      label = "NIXOS_SD";
      fsType = "ext4";
    };
  };
  hardware.enableAllHardware = lib.mkForce false;
}
