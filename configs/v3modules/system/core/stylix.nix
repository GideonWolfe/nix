{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  # Simple stylix configuration with sensible defaults
  stylix = {
    # Enable stylix at the SYSTEM level
    enable = true;
    
    # Theme configuration
    image = "${inputs.self}/wallpapers/topo.jpg";
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    
    # Opacity settings
    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };
    
    # Cursor theme
    cursor = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
      size = 32;
    };
    
    # Font configuration
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
      };
      serif = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
      };
      sizes = {
        applications = 15;
        terminal = 12;
        desktop = 13;
        popups = 8;
      };
    };
    
    # System-level targets only
    targets = {
      plymouth.enable = false;
      # Enable GTK theming at system level
      gtk.enable = true;
    };
  };

  # Install essential theming packages
  environment.systemPackages = with pkgs; [
    # Base16 schemes
    base16-schemes
    
    # Icon themes
    papirus-icon-theme
    papirus-folders
    adwaita-icon-theme
    material-icons
    libsForQt5.breeze-icons
    
    # Qt theming tools
    libsForQt5.qt5ct
    qt6ct
    libsForQt5.qtcurve
    libsForQt5.qtstyleplugins
    
    # Additional theming tools
    spicetify-cli
  ];
}