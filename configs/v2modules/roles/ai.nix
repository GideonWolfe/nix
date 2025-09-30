{ config, lib, pkgs, pathConfig ? {}, ... }:

{
  options.ai = {
    enable = lib.mkEnableOption "AI tools and services";
  };

  config = lib.mkIf config.ai.enable {
    # Enable LocalAI by default when ai role is enabled
    ai.localai.enable = lib.mkDefault true;
  };
}
