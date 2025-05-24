{ config, lib, pkgs, inputs, ... }:

{
  # Enable Stylix for system level theming
  stylix = {

    enable = true;

    image = ../../../../../wallpapers/FzrFRrt.jpg;

    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";

    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
      };

      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font Mono";
      };

      # TODO this font isn't found, and gucharmap doesn't show it providing the emojis? 
      # But it shows up as installed
      emoji = {
        name = "Noto Emoji";
        package = pkgs.noto-fonts-monochrome-emoji;
      };

      # This DOES provide the monochrome symbols according to gucharmap
      # but for whatever reason colored emojis show up
      #emoji = {
      #	name = "Symbola";
      #	package = pkgs.symbola;
      #};

      sizes = {
        desktop = 13;
        applications = 15;
      };
    };

    targets = {
      # Disable this so I can set the theme from the system and specify a custom one
      # stylix doesn't have a theme option
      plymouth = { enable = false; };
    };

  };
}
