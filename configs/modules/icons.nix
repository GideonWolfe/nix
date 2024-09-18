{ lib, ... }: {
  # Central location to manage icons for use in other programs
  options.local.utils.icons = lib.mkOption { };
  config.local.utils.icons = {
      diagnostic = {
          error = "󰅚";
      };
  };
}
