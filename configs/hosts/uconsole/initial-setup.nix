{ pkgs, config, modulesPath, ... }:

let
  # upstream nixos/lib/make-ext4-fs.nix doesnt leave enough inodes
  # resulting in an image that fails the first boot
  # this creates enough inodes to fill the 8k table, and create a new 8k table
  dummy = pkgs.runCommand "dummy" {} ''
    mkdir $out
    cd $out
    touch {1..1900}
  '';
in {
  imports = [
    "${modulesPath}/installer/sd-card/sd-image.nix"

    "${modulesPath}/installer/cd-dvd/channel.nix"
  ];
  boot = {
    postBootCommands = ''
      # ${dummy}
      if ! [ -e /etc/nixos/hardware-configuration.nix ]; then
        mkdir -pv /etc/nixos/
        pushd /etc/nixos/
        cp ${./configuration.nix} configuration.nix
        cp ${./hardware-configuration.nix} hardware-configuration.nix
        cp ${./bootloader.nix} bootloader.nix
        cp ${./reinstall-bootloader.sh} reinstall-bootloader.sh
        popd
        rm /root/.nix-defexpr/channels
      fi
    '';
  };
  sdImage = {
    firmwareSize = 512;
    populateFirmwareCommands = ''
      DEST=./ ${config.system.build.installBootLoader} ${config.system.build.toplevel}
    '';
    populateRootCommands = ''
    '';
  };
}
