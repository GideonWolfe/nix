{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.cavalier-settings = {
    enable = true;
    target = "Nickvision Cavalier/config.json";
    text = ''
      {
        "WindowWidth": 500,
        "WindowHeight": 300,
        "WindowMaximized": false,
        "AreaMargin": 0,
        "AreaOffsetX": 0,
        "AreaOffsetY": 0,
        "Borderless": false,
        "SharpCorners": false,
        "ShowControls": false,
        "AutohideHeader": true,
        "Framerate": 60,
        "BarPairs": 16,
        "Autosens": true,
        "Sensitivity": 10,
        "Stereo": true,
        "Monstercat": true,
        "NoiseReduction": 0.56,
        "ReverseOrder": false,
        "Direction": 1,
        "ItemsOffset": 0.1,
        "ItemsRoundness": 0.5,
        "Filling": false,
        "LinesThickness": 6,
        "Mode": 6,
        "Mirror": 0,
        "ReverseMirror": false,
        "InnerRadius": 0.5,
        "Rotation": 0,
        "ColorProfiles": [
          {
            "Name": "Default",
            "FgColors": [
              "${base0D}",
              "${base0E}",
              "${base07}"
            ],
            "BgColors": [
              "${base00}"
            ],
            "Theme": 1
          }
        ],
        "ActiveProfile": 0,
        "BgImageIndex": -1,
        "BgImageScale": 1,
        "BgImageAlpha": 1,
        "FgImageIndex": -1,
        "FgImageScale": 1,
        "FgImageAlpha": 1
      }
    '';
  };
}
