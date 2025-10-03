{ config, lib, pkgs, pathConfig ? {}, ... }:

{
  options.custom.features.ai.localai = {
    enable = lib.mkEnableOption "LocalAI service";
    
    port = lib.mkOption {
      type = lib.types.port;
      default = 6767;
      description = "Port to expose LocalAI service on";
    };

    image = lib.mkOption {
      type = lib.types.str;
      default = "localai/localai:latest-aio-gpu-hipblas";
      description = "Docker image to use for LocalAI";
    };

    contextSize = lib.mkOption {
      type = lib.types.int;
      default = 8192;
      description = "Context size for LocalAI models";
    };

    modelsPath = lib.mkOption {
      type = lib.types.str;
      default = "/home/${config.custom.user.name}/.local/share/localai/models";
      description = "Host path for LocalAI models cache";
    };

    debug = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable debug mode";
    };

    autoStart = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Automatically start the LocalAI container";
    };
  };

  config = lib.mkIf config.custom.features.ai.localai.enable {
    virtualisation.oci-containers.containers.localai = {
      image = config.custom.features.ai.localai.image;
      ports = [ "${toString config.custom.features.ai.localai.port}:8080" ];
      autoStart = config.custom.features.ai.localai.autoStart;
      environment = {
        DEBUG = toString config.custom.features.ai.localai.debug;
        LOCALAI_CONTEXT_SIZE = toString config.custom.features.ai.localai.contextSize;
      };
      volumes = [
        # model cache
        "${config.custom.features.ai.localai.modelsPath}:/models:cached"
      ];
    };
  };
}
