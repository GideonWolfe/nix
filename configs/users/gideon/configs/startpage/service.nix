{ pkgs, lib, config, ... }:

{
#BUG: changing index.html doesnt update the server, needs a manual restart
  systemd.user.services.startpage = {
    Unit = { Description = "startpage being served by miniserv"; };
    Install = { WantedBy = [ "default.target" ]; };
    Service = {
      Type = "simple";
      Restart = "always";
      RestartSec = 1;
      WorkingDirectory =
        "${config.home.homeDirectory}/nix/configs/users/gideon/configs/startpage/data";
      ExecStart = "${pkgs.miniserve}/bin/miniserve --index index.html -p 9876";
    };
  };
}
