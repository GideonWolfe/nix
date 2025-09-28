{ config, lib, pkgs, inputs, ... }:

let cfg = config.audio;
in {
  options.audio = { enable = lib.mkEnableOption "Audio support"; };

  config = lib.mkIf cfg.enable {
    # Enable Pipewire
    services.pipewire.enable = true;
    # Use Pipewire as primary server
    services.pipewire.audio.enable = true;
    # Enable wireplummber session manager
    services.pipewire.wireplumber.enable = true;
    # Handle other audio servers too
    services.pipewire.jack.enable = true;
    services.pipewire.alsa.enable = true;
    services.pipewire.pulse.enable = true;
  };
}
