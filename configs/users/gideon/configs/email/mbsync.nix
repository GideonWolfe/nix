{ pkgs, lib, config, ... }:

{
  # Enable managing MBSync settings
  programs.mbsync = { enable = true; };
  # Configure the mbsync service
  services.mbsync = {
    enable = true;
    #TODO: Get this to send a useful notification
    #postExec = "notify-send -u low 'mbsync' 'Sync Successful'";
  };
}
