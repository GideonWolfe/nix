{ pkgs, lib, config, ... }: {
  environment.etc."nextcloud-admin-pass".text = "PWD";
  services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen =
    [{
      addr = "127.0.0.1";
      port = 9999; # NOT an exposed port
    }];
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    #hostName = "nc.gideonwolfe.xyz";
    hostName = "localhost";
    #hostName = "192.168.0.158";
    config.adminpassFile = "/etc/nextcloud-admin-pass";

  };

}
