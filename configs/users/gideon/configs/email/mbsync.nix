{ pkgs, lib, config, ... }:

{
  # Enable managing MBSync settings
  programs.mbsync = { enable = true; };
  # Configure the mbsync service
  services.mbsync = {
    enable = true;
    postExec = "notify-send -u low 'mbsync' 'Sync Successful'";
  };
}
