{ config, lib, pkgs, pathConfig ? {}, ... }:

{
  options.custom.features.ai = {
    enable = lib.mkEnableOption "AI tools and services";
  };

  config = lib.mkIf config.custom.features.ai.enable {
    # Enable LocalAI by default when ai feature is enabled
    custom.features.ai.localai.enable = lib.mkDefault true;
  };
}
