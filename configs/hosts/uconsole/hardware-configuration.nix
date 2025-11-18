{ pkgs, pkgs-unstable, config, inputs, lib, ... }:

{
  imports = [
    ./bootloader.nix
  ];
  boot = {
    #kernelPackages = inputs.nixpkgs-unstable.legacyPackages.aarch64-linux.linuxPackages_rpi4;
    kernelPackages = pkgs.linuxPackages_rpi4;

    # TODO eventually lock this to a stable kernel version
    # kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_rpi4.override {
    #   argsOverride = {
    #     # Version for commit 99972b2fa5395542e7c24e4d894be5ede383055f
    #     version = "6.12.48";
    #     modDirVersion = "6.12.48";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "raspberrypi";
    #       repo = "linux";
    #       rev = "99972b2fa5395542e7c24e4d894be5ede383055f";
    #       hash = "sha256-Q7PEjEpnkeBevJduxSGFvtBQpRsFUqr2crDmbW3VyEU=";
    #     };
    #   };
    # });

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

  # TODO: eventually enable swap
  # Swap configuration (optional, but helpful for limited RAM)
  # swapDevices = [
  #   {
  #     device = "/swapfile";
  #     size = 1024; # 1GB swap
  #   }
  # ];
}
