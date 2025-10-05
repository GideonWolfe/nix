{ pkgs, lib, ... }:

{
  # Enable User Dirs
  xdg.userDirs = {
    enable = true;
    videos = "$HOME/videos";
    pictures = "$HOME/pictures";
    music = "$HOME/music";
    download = "$HOME/downloads";
    documents = "$HOME/documents";
    desktop = "$HOME/desktop";
    publicShare = "$HOME/public";
    templates = "$HOME/templates";
  };
}
