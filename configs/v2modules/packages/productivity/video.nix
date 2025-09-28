{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [

    # Video Editing
    footage # lightweight video editor with a few operations
    kdePackages.kdenlive # full video editor
    obs-studio
    obs-studio-plugins.obs-pipewire-audio-capture
    gnomecast # GTK client to chromecast local files

    # Video Players
    mpv
    mpvScripts.mpris # make mpv use mpris
    vlc
    jftui # Jellyfin TUI
    jellyfin-media-player # official desktop client
    delfin # GTK Jellyfin client

    # converter and DVD ripper
    handbrake # GUI command is ghb

    # Downloaders
    yt-dlp # better youtube-dl
    vdhcoapp # companion for video downloader firefox plugin

    # Take photos through webcam
    cheese
    cameractrls
  ];
}
