{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.kiwix-serve = {
    image = "ghcr.io/kiwix/kiwix-serve";
    ports = [ "4235:8080" ];
    autoStart = true;
    volumes = [ "/pool/data/media/zim:/data" ];
    cmd = [ "--verbose" "--address=0.0.0.0" "*.zim" ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.kiwix.rule" = "Host(`kiwix.gideonwolfe.xyz`)";
      "traefik.http.routers.kiwix.entrypoints" = "https";
      "traefik.http.routers.kiwix.tls.certresolver" = "myresolver";
      "traefik.http.services.kiwix.loadbalancer.server.port" = "8080";
    };
    extraOptions = [ "--network=traefik_proxy" ];
  };

}
