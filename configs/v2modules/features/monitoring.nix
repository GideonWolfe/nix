{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let cfg = config.custom.features.monitoring;
in {
  options.custom.features.monitoring = {
    enable = lib.mkEnableOption "Monitoring Support";
  };

  imports = lib.optionals cfg.enable [
    # Only import monitoring components when feature is enabled
    ../configs/system/monitoring/prometheus.nix
    ../configs/system/monitoring/alloy.nix
  ];

  config = lib.mkIf cfg.enable {
    # Additional monitoring configuration can go here
    # The actual services are configured in the imported modules
  };
}
