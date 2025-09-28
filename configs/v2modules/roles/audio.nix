{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let cfg = config.audio;
in {
  options.audio = { enable = lib.mkEnableOption "Audio support"; };

  config = lib.mkIf cfg.enable {
    # Enable Pipewire services
    services.pipewire.enable = true;
    # Use Pipewire as primary server
    services.pipewire.audio.enable = true;
    # Enable wireplummber session manager
    services.pipewire.wireplumber.enable = true;
    # Handle other audio servers too
    services.pipewire.jack.enable = true;
    services.pipewire.alsa.enable = true;
    services.pipewire.pulse.enable = true;

    # Install audio-related system packages
    environment.systemPackages = with pkgs; [
      # Pipewire
      pipewire
      qpwgraph # QT patchbay for pipewire
      helvum # GTK patchbay
      coppwr # Low level control GUI for the PipeWire multimedia server
      pwvucontrol # volume control gui

      # Pulseaudio
      pulseaudio # included to get pactl, not actually running via hardware.pulseaudio
      pavucontrol # PulseAudio control GUI

      # Alsa
      alsa-utils # amixer and other utilities

      # General
      playerctl # MPRIS control CLI
      ffmpeg
      soundconverter # sound conversion GUI
      decibels # GNOME simple audio player GUI
    ];
  };
}
