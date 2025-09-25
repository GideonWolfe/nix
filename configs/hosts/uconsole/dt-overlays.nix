{ config, lib, pkgs, ... }:

{
  # Additional device tree overlays for graphics and audio
  hardware.deviceTree.overlays = [
    {
      name = "vc4-kms-v3d-pi4,cma-384";
      dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/vc4-kms-v3d-pi4.dtbo";
      filter = "bcm2711-rpi-cm4.dtb";
    }
    {
      name = "audremap,pins_12_13";
      dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/audremap.dtbo";
      filter = "bcm2711-rpi-cm4.dtb";
    }
  ];
}
