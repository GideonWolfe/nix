{ pkgs, pkgs-unstable, config, inputs, lib, ... }:

{
  imports = [
    ./bootloader.nix
  ];
  boot = {
    # TODO eventually lock this to a stable kernel version
    kernelPackages = inputs.nixpkgs-unstable.legacyPackages.aarch64-linux.linuxPackages_rpi4;
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
