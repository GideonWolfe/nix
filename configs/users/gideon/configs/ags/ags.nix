{ inputs, pkgs, config, ... }:

{

  # add the home manager module
  #imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    configDir = ./config;
    #configDir = ${config.home.homeDirectory}/nix/configs/users/gideon/configs/ags/config;
    #configDir = ${config.home.homeDirectory}/nix/configs/users/gideon/configs/ags/config;

    extraPackages = with pkgs; [ gtksourceview webkitgtk accountsservice ];
  };
}
