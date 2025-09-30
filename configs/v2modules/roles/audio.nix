{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let cfg = config.audio;
in {
  options.audio = { enable = lib.mkEnableOption "Audio support"; };

  config = lib.mkIf cfg.enable {

    services.pipewire = {
      # Enable Pipewire services
      enable = true;
      # Use Pipewire as primary server
      audio.enable = true;
      # Enable wireplummber session manager
      wireplumber.enable = true;
      # Handle other audio servers too
      jack.enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

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
