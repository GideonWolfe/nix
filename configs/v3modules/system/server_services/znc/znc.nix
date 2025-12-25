{ config, lib, pkgs, inputs, ... }:

let cfg = config.custom.features.znc;
in {
  options.custom.features.znc = {
    enable = lib.mkEnableOption "ZNC IRC bouncer service";
  };

  config = lib.mkIf cfg.enable {
    services.znc = {
      enable = true;
      openFirewall = true;
      mutable = true; # eventually shift this to false to lock it down

      config = {
        LoadModule = [ 
          "webadmin"
          "adminlog"
          "fail2ban" # double layer of protection since we sohuld already have crowdsec
        ];
        User.demoncore = {
          Admin = false;
          Nick = "demoncore";
          AltNick = "demonc0re";
          LoadModule = [ "chansaver" "controlpanel" ];
          Network.libera = {
            Server = "irc.libera.chat +6697";
            LoadModule = [ "simple_away" ];
            Chan = {
              "#nixos" = { Detached = false; };
              "##linux" = { Disabled = true; };
            };
          };
          Pass.password = {
            Method = "sha256";
            Hash = "";
            Salt = "";
          };
        };
      };
    };
  };
}
