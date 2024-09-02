{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.crowdsec = {
    image = "crowdsecurity/crowdsec";
    ports = [ "4223:8080" ];
    autoStart = true;
    environment = {
      PGID = "1000";
      COLLECTIONS = "crowdsecurity/traefik crowdsecurity/http-cve crowdsecurity/appsec-generic-rules";
    };
    volumes = [
      "/var/lib/crowdsec/data/:/var/lib/crowdsec/data/"
      "/etc/crowdsec:/etc/crowdsec"
      "/var/lib/traefik/logs/:/var/log/traefik/:ro"
      "/home/overseer/nix/configs/hosts/athena/server/services/networking/crowdsec/acquis.yaml:/etc/crowdsec/acquis.yaml"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
  };
}
