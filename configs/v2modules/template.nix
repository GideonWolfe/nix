{ config, lib, pkgs, inputs, ... }:

let cfg = config.OPTION_SET_NAME;
in {
  options.OPTION_SET_NAME = {
    enable = lib.mkEnableOption "Description of Option";

    OPTION_NAME = lib.mkOption {
      type = lib.types.path;
      default = "${inputs.dotfiles}/backgrounds/mist_forest_nord.jpg";
      description = "Description of Option";
    };

    OPTION_2_NAME = lib.mkOption {
      type = lib.types.enum [ "one" "two" ];
      default = "one";
      description = "Description of Option";
    };
  };

  config = lib.mkIf cfg.enable {
    # ARBITRARY NIX OPTIONS GO HERE
    SOME_NIX_OPTION.enable = true;
    SOME_OTHER_NIX_OPTION.OPTION = cfg.OPTION_NAME;
  };
}
