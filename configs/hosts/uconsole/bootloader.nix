{ pkgs, lib, config, ... }:

let
  config_txt = pkgs.writeText "config.txt" ''
    initramfs initrd followkernel
    gpu_mem=16
  '';
in {
  options = {
    boot.loader.rpi = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
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
