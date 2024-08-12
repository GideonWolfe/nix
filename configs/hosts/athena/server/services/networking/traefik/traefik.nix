{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.traefik = {
    image = "traefik:v3.1";
    ports = [ "443:443" "8080:8080" "80:80" ];
    autoStart = true;
    volumes = [
      "/home/overseer/server/services/networking/traefik/data/:/letsencrypt"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
      "/home/overseer/nix/configs/hosts/athena/server/services/networking/traefik/configs:/configs"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
    cmd = [
      # Setting up API and web UI
      "--api.insecure=true"
      "--providers.docker=true"
      "--providers.docker.exposedbydefault=false"
      "--entryPoints.web.address=:80"
      # HTTPS setup
      "--entryPoints.websecure.address=:443"
      "--certificatesresolvers.myresolver.acme.tlschallenge=true"
      "--certificatesresolvers.myresolver.acme.email=gideon@gideonwolfe.xyz"
      "--certificatesresolvers.myresolver.acme.storage=/letsencrypt/acme.json"
      # Crowdsec plugin
      #"--experimental.plugins.crowdsec-bouncer-traefik-plugin.modulename=github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin"
      #"--experimental.plugins.crowdsec-bouncer-traefik-plugin.version=1.3.3"
      #"--providers.file.directory=/dyn"
      "--providers.file"
      #"--providers.file.filename=/nextcloud.yml"
      "--providers.file.filename=/configs/nextcloud.yml"
      "--providers.file.watch=true"
    ];
    #environmentFiles = [ /home/overseer/.secrets/services/traefik/.env ];

  };

}
