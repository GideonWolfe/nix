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
        "${config.home.homeDirectory}/nix/configs/modules/configs/user/startpage/data";
      ExecStart = "${pkgs.miniserve}/bin/miniserve --index index.html -p 9876";
    };
  };
  # Oneshot to restart service
  systemd.user.services.startpage-restarter = {
    Unit = { Description = "watches index.html and updates if needed"; };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl --user restart startpage.service";
    };
  };

  systemd.user.paths.startpage-restarter = {
    Install = { WantedBy = [ "default.target" ]; };
    Path = {
      PathChanged =
        "${config.home.homeDirectory}/nix/configs/modules/configs/user/startpage/data/index.html";
    };
    #BUG: this should create [Path] according to docs, but it creates [pathConfig]
    # pathConfig = {
    #   PathChanged =
    #     "${config.home.homeDirectory}/nix/configs/users/gideon/configs/startpage/data/index.html";
    # };
  };
}
