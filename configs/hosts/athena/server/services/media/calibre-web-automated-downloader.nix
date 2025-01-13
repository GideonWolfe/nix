{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.calibre-web-automated-book-downloader =
    {
      image = "ghcr.io/calibrain/calibre-web-automated-book-downloader:latest";
      ports = [ "4233:8084" ];
      autoStart = true;
      # environment = {
      # };
      volumes = [ "/tmp/cwa-book-ingest/:/cwa-book-ingest" ];
      #extraOptions = [ "--network=traefik_proxy" ];
    };

}
