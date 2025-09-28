{ config, lib, pkgs, inputs, ... }:

let cfg = config.monitoring;
in {
  options.monitoring = {
    enable = lib.mkEnableOption "Monitoring Support";

    metrics = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable metrics monitoring";
    };

    logs = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable logs monitoring";
    };

  };

  config = lib.mkIf cfg.enable {
    #imports = [];
  };
}
