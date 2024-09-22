{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.ags_style = {

    enable = true;
    #onChange = manually tell darkreader to refresh somehow?
    target = "ags/styles/colors.scss";
    text = ''
          $red: ${base08};
          $orange: ${base09};
          $yellow: ${base0A};
          $green: ${base0B};
          $cyan: ${base0C};
          $blue: ${base0D};
          $magenta: ${base0E};
          $brown: ${base0F};
          $bright-red: ${base12};
          $bright-orange: ${base13};
          $bright-green: ${base14};
          $bright-cyan: ${base15};
          $bright-blue: ${base16};
          $bright-magenta: ${base17};

          $bg: ${base00};
          $bg-alt: ${base01};
          $fg: ${base05};
          $fg-alt: ${base04};
    '';
  };
}
