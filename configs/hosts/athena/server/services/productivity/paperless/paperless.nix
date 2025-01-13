{ pkgs, lib, config, ... }: {
  networking.firewall = { allowedTCPPorts = [ 4232 ]; };
  services.paperless = {
    enable = true;
    passwordFile = config.age.secrets.paperless_admin_pass.path;
    mediaDir = "/pool/data/media/documents/";
    port = 4234;
    #address = "pngx.gideonwolfe.xyz"; # to access over lan
    address = "0.0.0.0"; # to access over lan
    settings = { PAPERLESS_URL = "https://pngx.gideonwolfe.xyz"; };
  };

}
