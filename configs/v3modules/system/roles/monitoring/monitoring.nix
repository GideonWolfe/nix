{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let cfg = config.custom.features.monitoring;
in {
  imports = [
    # Always import monitoring components - they'll conditionally enable themselves
    ./prometheus.nix
    ./alloy.nix
    ./scrutiny.nix
  ];

  options.custom.features.monitoring = {
    enable = lib.mkEnableOption "Monitoring Support";
  };

  config = lib.mkIf cfg.enable {
    # Additional monitoring configuration can go here
    # The actual services are configured in the imported modules
  };
}
