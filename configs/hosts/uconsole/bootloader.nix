{ pkgs, lib, config, ... }:

let
  config_txt = pkgs.writeText "config.txt" config.boot.loader.rpi.config_txt;
in {
  options = {
    boot.loader.rpi = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      config_txt = lib.mkOption {
        type = lib.types.str;
        # default = ''
        #   initramfs initrd followkernel
        #   gpu_mem=16
        #   arm_boost=1
        #   max_framebuffers=2
        #   dtoverlay=vc4-kms-v3d-pi4
        #   dtoverlay=uconsole,cm4,hwi2c
        #   dtoverlay=dwc2,dr_mode=host
        # '';
        # This is confirmed booting after editing
        default = ''
          initramfs initrd followkernel
          gpu_mem=16
        '';
      };
    };
  };
  config = lib.mkIf config.boot.loader.rpi.enable {
    system.boot.loader.id = "rpi";
    system.build.installBootLoader = pkgs.replaceVarsWith {
      isExecutable = true;
      replacements = {
        crossShell = pkgs.runtimeShell;
        fw = "${pkgs.raspberrypifw}/share/raspberrypi/boot";
        inherit config_txt;
      };
      src = ./reinstall-bootloader.sh;
    };
  };
}
