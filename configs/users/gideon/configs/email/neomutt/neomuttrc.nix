{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile = {
    neomuttrc = {
      enable = true;
      target = "neomutt/neomuttrc";
      text = ''
        # vim: filetype=muttrc

        source ~/.config/neomutt/settings
        source ~/.config/neomutt/colors
        source ~/.config/neomutt/mappings
        			'';
    };
  };
}
