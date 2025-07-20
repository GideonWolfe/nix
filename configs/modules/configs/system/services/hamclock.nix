{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.hamclock = {
    image = "ghcr.io/chrisromp/hamclock-docker:latest";
    ports = [ "9900:8080" "9901:8081" ];
    autoStart = true;
    volumes = [ "/home/gideon/.local/share/hamclock/data/:/root/.hamclock" ];
  };
}
