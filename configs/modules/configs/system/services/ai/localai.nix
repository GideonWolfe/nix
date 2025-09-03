{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.localai = {
    #image = "localai/localai:latest-aio-cpu";
    image = "localai/localai:latest-aio-gpu-hipblas";
    ports = [ "6767:8080" ];
    autoStart = true;
    environment = {
      DEBUG = "true";
      LOCALAI_CONTEXT_SIZE = "8192";
    };
    volumes = [
      # model cache
      "/home/gideon/.local/share/localai/models:/models:cached"
    ];
  };
}
