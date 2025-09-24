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


    # Rex Kernel # 
    ./kernels/rex/kernel.nix
    ./kernels/rex/boot.nix
    ./system.nix
    ./hardware.nix
    ./hardware-configuration.nix
    
     # Potato Kernel # 
    ./kernels/potato/kernel.nix
    ./kernels/rex/kernel.nix
    ./boot.nix
    ./system.nix
    ./hardware.nix
    ./dt-misc.nix
    ./dt-display.nix
    ./dt-pmu.nix
    ./dt-overlays.nix
    ./hardware-configuration.nix
  ];

  # HACK: fix the bug with missing firmware
  nixpkgs.overlays = [ overlay ];
}
