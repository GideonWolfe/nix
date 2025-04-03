{ config, lib, pkgs, ... }:

{
  #INFO: https://discourse.nixos.org/t/how-to-enable-ddc-brightness-control-i2c-permissions/20800/4

  # # Add i2c kernel module
  # boot.kernelModules = [ "i2c-dev" ];
  # # Set udev rules for i2c
  # services.udev.extraRules = ''
  #   KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  # '';
  hardware.i2c.enable = true;
}
