{ config, lib, pkgs, ... }:

{
  options.ai = {
    enable = lib.mkEnableOption "AI tools and services";
    
    localai = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable LocalAI service";
    };
  };

  config = lib.mkIf config.ai.enable {
    # Import LocalAI configuration if enabled
    imports = lib.optionals config.ai.localai [
      ../modules/localai.nix
    ];
  };
}
