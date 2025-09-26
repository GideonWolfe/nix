{ config, lib, pkgs, modulesPath, inputs, ... }:
let

  overlay = final: super: {
    makeModulesClosure = x:
      super.makeModulesClosure (x // { allowMissing = true; });
  };

in {
  imports = [
    # Hardware configuration for Raspberry Pi
    "${modulesPath}/profiles/base.nix"
    # Temporarily disabled for manual control
    # inputs.nixos-hardware.nixosModules.raspberry-pi-4

    # Rex Kernel # 
    ./kernels/rex/kernel.nix
    ./kernels/rex/boot.nix
    ./system.nix
    ./hardware.nix
    ./hardware-configuration.nix
  ];

  # HACK: fix the bug with missing firmware
  nixpkgs.overlays = [ overlay ];
}
