{ config, lib, pkgs, modulesPath, inputs, ... }:
let

  overlay = final: super: {
    makeModulesClosure = x:
      super.makeModulesClosure (x // { allowMissing = true; });
  };

in {
  imports = [
    # Import the SD image generator
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"

    # Hardware configuration for Raspberry Pi
    "${modulesPath}/profiles/base.nix"

    # This is automatically included from flake.nix now
    # inputs.nixos-hardware.nixosModules.raspberry-pi-4

    # uConsole modular configuration
    ./kernel.nix
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
}
