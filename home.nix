{lib, config, pkgs, ... }:

with config.lib.stylix.colors.withHashtag;

{

  imports = [
    ############
    # PACKAGES #
    ############

    #Theming
    ./user/packages/theming.nix

    # Productivity packages
    ./user/packages/productivity/productivity.nix

    # Web
    ./user/packages/productivity/web.nix

    # Audio
    ./user/packages/productivity/audio.nix
    
    # Video
    ./user/packages/productivity/video.nix

    # Art
    ./user/packages/productivity/art.nix

    # Comms
    ./user/packages/productivity/comms.nix

    # Gaming
    #./user/packages/gaming.nix

    # STEM
    ./user/packages/science/astronomy.nix
    ./user/packages/science/biology.nix
    ./user/packages/science/chemistry.nix
    ./user/packages/science/data.nix
    #./user/packages/science/education.nix
    ./user/packages/science/geography.nix
    ./user/packages/science/math.nix
    #./user/packages/science/medecine.nix
    ./user/packages/science/utilities.nix
    ./user/packages/science/engineering.nix

    # Development
    ./user/packages/development/rust.nix
    ./user/packages/development/utils.nix

    # Random fun packages
    ./user/packages/fun.nix

    # My wallpapers
    #./user/packages/wallpapers.nix

    ###########
    # CONFIGS #
    ###########

    # Hyprland
    # Enable when ready for it
    ./user/configs/hyprland.nix
    ./user/configs/sway.nix
    ./user/configs/swaylock.nix
    ./user/configs/swayidle.nix

    # Display configs
    ./user/configs/kanshi.nix

    # Kitty
    ./user/configs/kitty.nix

    # Waybar
    ./user/configs/waybar.nix

    # Wofi
    ./user/configs/wofi.nix

    # Firefox
    ./user/configs/firefox/firefox.nix
    #./user/configs/firefox/userChrome.nix

    # Zathura
    ./user/configs/zathura.nix

    # GTK settings/theming
    ./user/configs/gtk.nix

    # Qt settings/theming
    ./user/configs/qt.nix

    # Custom user directories
    ./user/configs/xdg-user-dirs.nix

    # Custom user directories
    ./user/configs/mimetypes.nix

    # Better CD
    ./user/configs/zoxide.nix

    # Better LS
    ./user/configs/eza.nix

    # Better Cat
    ./user/configs/bat.nix

    # Screenshotting tool
    ./user/configs/flameshot.nix

    # Cava
    ./user/configs/cava.nix

    # Git
    ./user/configs/git.nix

    # SSH
    ./user/configs/ssh/ssh.nix

    # Neomutt
    ./user/configs/neomutt/neomuttrc.nix
    ./user/configs/neomutt/settings.nix
    ./user/configs/neomutt/mailcap.nix
    ./user/configs/neomutt/mappings.nix
    ./user/configs/neomutt/colors.nix

    # Newsboat
    ./user/configs/newsboat/newsboat.nix
    ./user/configs/newsboat/urls.nix

    # Bluetooth (enabling applet)
    ./user/configs/bluetooth.nix

    # Shell config
    ./user/configs/fish.nix

    # Notification client
    ./user/configs/mako.nix

    # Nix theming framwork
    ./user/configs/stylix.nix

    # Nix theming framwork
    ./user/configs/spicetify.nix

  ];

  # enable unfree package use with home manager (ie stylix referencing symbola font which is unfree)
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

  home.activation = {
	  createScreenshotsDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
	    mkdir -p ${config.home.homeDirectory}/pictures/screenshots/
	  '';
	  createScreenRecordings = lib.hm.dag.entryAfter ["writeBoundary"] ''
	    mkdir -p ${config.home.homeDirectory}/videos/screen_recordings/
	  '';
  };



  xdg = {
    configFile = {

      # Creates a config for DarkReader
      # TODO, need to make this auto update?
      darkreader = {
        enable = true;
	#onChange = manually tell darkreader to refresh somehow?
	target = "darkreader/config.json";
	text = ''

	{
	    "schemeVersion": 2,
	    "enabled": true,
	    "fetchNews": true,
	    "theme": {
		"mode": 1,
		"brightness": 100,
		"contrast": 100,
		"grayscale": 0,
		"sepia": 0,
		"useFont": false,
		"fontFamily": "Open Sans",
		"textStroke": 0,
		"engine": "dynamicTheme",
		"stylesheet": "",
		"darkSchemeBackgroundColor": "${base00}",
		"darkSchemeTextColor": "${base05}",
		"lightSchemeBackgroundColor": "${base05}",
		"lightSchemeTextColor": "${base00}",
		"scrollbarColor": "auto",
		"selectionColor": "auto",
		"styleSystemControls": false,
		"lightColorScheme": "Default",
		"darkColorScheme": "Default",
		"immediateModify": false
	    },
	    "presets": [],
	    "customThemes": [],
	    "enabledByDefault": true,
	    "enabledFor": [],
	    "disabledFor": [],
	    "changeBrowserTheme": false,
	    "syncSettings": false,
	    "syncSitesFixes": true,
	    "automation": {
		"enabled": false,
		"mode": "",
		"behavior": "OnOff"
	    },
	    "time": {
		"activation": "18:00",
		"deactivation": "9:00"
	    },
	    "location": {
		"latitude": null,
		"longitude": null
	    },
	    "previewNewDesign": true,
	    "enableForPDF": true,
	    "enableForProtectedPages": true,
	    "enableContextMenus": false,
	    "detectDarkTheme": false,
	    "displayedNews": [
		"thanks-2023"
	    ]
	}

	'';
      };
    };
  };



  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  #home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  #];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gideon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "nvim";
     TERM = "kitty";
     BROWSER = "firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
