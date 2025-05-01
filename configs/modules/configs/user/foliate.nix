{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.foliate = {

    enable = true;
    #onChange = manually tell darkreader to refresh somehow?
    target = "com.github.johnfactotum.Foliate/themes/stylix.json";
    # TODO: seems like you manually have to press Alt+, to bring up menu to change to stylix theme
    text = ''
      {
          "label": "Stylix",
          "light": {
              "fg": "${base00}",
              "bg": "${base05}",
              "link": "${base0E}"
          },
          "dark": {
              "fg": "${base05}",
              "bg": "${base00}",
              "link": "${base0E}"
          }
      }
    '';
  };

  dconf.settings."com/github/johnfactotum/Foliate/viewer/view" = {
    theme = "stylix.json";
  };

}
