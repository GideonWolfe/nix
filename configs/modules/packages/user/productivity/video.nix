{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.obs-studio
    pkgs.obs-studio-plugins.obs-pipewire-audio-capture
    pkgs.footage # lightweight video editor with a few operations
    pkgs.gnomecast # GTK client to chromecast local files
    pkgs.kdePackages.kdenlive # full video editor

    pkgs.jellyfin-media-player # official desktop client
    pkgs.jftui # Jellyfin TUI
    pkgs.delfin # GTK Jellyfin client
  ];
}
