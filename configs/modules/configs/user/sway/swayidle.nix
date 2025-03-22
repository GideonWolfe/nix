{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  services.swayidle = {
    enable = true;
    timeouts = [{
      timeout = 300;
      command =
        "${config.home.homeDirectory}/nix/configs/modules/scripts/user/desktop/power/lock.sh";
      # TODO this chained command doesn't seem to work
      #command = "${pkgs.swaylock}/bin/swaylock -f; systemctl suspend";
    }];

  };
}
