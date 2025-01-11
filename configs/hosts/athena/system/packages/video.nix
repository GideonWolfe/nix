{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Video Players
    mpv
    mpvScripts.mpris # make mpv use mpris
    vlc
    # converter and DVD ripper
    handbrake # GUI command is ghb
    # Downloaders
    yt-dlp # better youtube-dl
  ];
}
