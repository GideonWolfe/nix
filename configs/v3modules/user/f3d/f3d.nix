{ pkgs, lib, config, ... }:

with config.lib.stylix.colors;

{
  xdg.configFile.f3d = {

    enable = true;
    #onChange = manually tell darkreader to refresh somehow?
    target = "f3d/config.json";
    #HACK: docs say it's "background-color" but this is the only thing that works
    #BUG: bg-color and color don't look like my theme colors

        # put this in text below to add background image
        #"hdri-file": "${config.stylix.image}",
    text = ''
      {
          ".*": {
              "bg-color": "${base00-dec-r},${base00-dec-g},${base00-dec-b},",
              "color": "${base0E-dec-r},${base0E-dec-g},${base0E-dec-b},",
              "grid-color": "${base0A-dec-r},${base0A-dec-g},${base0A-dec-b},",
              "ambient-occlusion": true,
              "grid": true,
              "grid-absolute": true,
              "up": "+Z",
              "watch": true,
              "hdri-skybox": false,
              "blur-background": false
          }
      }
    '';
  };
}
