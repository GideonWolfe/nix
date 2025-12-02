{ pkgs, lib, config, inputs, ... }:

let
  # Define the scripts directory - currently pointing to v2modules
  scriptsDir = ../../v2modules/scripts;
in {
  imports = [

    ###########
    # Modules #
    ###########
    inputs.nixvim.homeManagerModules.nixvim
    inputs.spicetify-nix.homeManagerModules.default

    ###############
    # Shell Stuff #
    ###############
  ./apps/shell/fish.nix # Primary shell
  ./apps/shell/bash.nix # backup shell
  ./apps/shell/starship.nix # gives a good prompt to bash and nix shells
  ./apps/kitty/kitty.nix # preferred terminal
  ./apps/zellij/zellij.nix # better screen/tmux
  ./apps/nh/nh.nix # wrapper for nix builds
  ./apps/zoxide/zoxide.nix # better cd
  ./apps/eza/eza.nix # better ls
  ./apps/bat/bat.nix # better cat
  ./apps/atuin/atuin.nix # TUI shell history
  ./apps/kdeconnect/kdeconnect.nix

    ###############
    # Environment #
    ###############
  ./sessions/global/session-variables.nix # environment vars
  ./sessions/global/xdg-user-dirs.nix # default directories
  ./sessions/global/mimetypes.nix # default programs
  ./sessions/global/udiskie.nix # automount USB drives
  ./sessions/global/blueman-applet.nix # enables BT applet
  ./apps/gpg/gpg.nix # enable GPG to run

    #######
    # Git #
    #######
  ./apps/git/git.nix
  ./apps/gh/gh.nix

    ##############
    # UI/Desktop #
    ##############
  ./sessions/global/ui/stylix.nix
  ./sessions/global/ui/cursor.nix
  ./sessions/global/ui/gtk.nix
  ./sessions/global/ui/qt.nix
  ./apps/wofi/wofi.nix # app launcher
  ./apps/swappy/swappy.nix # Screenshot editor
  ./apps/fusuma/fusuma.nix # touchpad gestures
  ./apps/kando/kando.nix # circle app launcher
  ./apps/clipse/clipse.nix # clipboard manager TUI

    #################
    # Browser Stuff #
    #################
  ./apps/chromium/chromium.nix
  ./apps/firefox/firefox.nix
  ./apps/darkreader/darkreader.nix
  ./apps/startpage/service.nix

    ####################
    # Scripts & Tools  #
    ####################
    # ../../v2modules/scripts/wofi-web-search
    # ../../v2modules/scripts/git
    # ../../v2modules/scripts/portapack
    # ../../v2modules/scripts/hyprland-window-switcher
    # ../../v2modules/scripts/sway-window-switcher
    # ../../v2modules/scripts/power-scripts
    # ../../v2modules/scripts/mako-toggle
    # ../../v2modules/scripts/screen-recorder

    ####################
    # Kubernetes Stuff #
  ./apps/kube/kube.nix

    ############
    # Hyprland #
    ############
  ./sessions/hypr/hyprland.nix
  ./sessions/hypr/hyprpaper.nix
  ./sessions/hypr/hypridle.nix
  ./sessions/hypr/hyprlock.nix
  ./sessions/hypr/hyprpanel.nix

    ########
    # Sway #
    ########
  #./sessions/sway/sway.nix
  #./sessions/sway/swaylock.nix # this was causing a build bug
  #./sessions/sway/swayidle.nix
  #./sessions/global/ui/waybar/waybar.nix

    #############################
    # Essential Program Configs #
    #############################
  ./apps/nixvim/nixvim.nix

    ################################
    # NonEssential Program Configs #
    ################################
  ./apps/imv/imv.nix # imv theme
  ./apps/zathura/zathura.nix # zathura theme
  ./apps/foliate/foliate.nix # foliate theme
  ./apps/halloy/halloy.nix # halloy settings/theme # HAS SECRET
  ./apps/btop/btop.nix # btop theme
  ./apps/gnuplot/gnuplot.nix # gnuplot theme
  ./apps/cava/cava.nix # cava settings/theme
  ./apps/cavalier/cavalier.nix # cavalier settings/theme
  ./apps/newsboat/newsboat.nix
  ./apps/spicetify/spicetify.nix # spicetify theme
  ./apps/fastfetch/fastfetch.nix
  ./apps/vscode/vscode.nix # VScode settings
  ./apps/blender/blender-theme.nix # blender theme
  #./apps/obsidian/obsidian-stylix-css.nix # obsidian theme # GIDEON MENTIONED
  ./apps/element/element.nix # element settings/theme
  ./apps/ghidra/ghidra.nix # Ghidra theme
  ./apps/kicad/kicad.nix # Kicad theme
  ./apps/mpv/mpv.nix # mpv theme
  ./apps/libreoffice/libreoffice.nix # libreoffice theme
  ./apps/blockbench/blockbench.nix # blockbench theme
  ./apps/minimeters/minimeters.nix
  ./apps/godot/godot-theme.nix
  ./apps/astrolog/astrolog.nix
  ./apps/shortwave/shortwave.nix
  ./apps/sdrpp/sdrpp.nix #TODO BROKEN
  ./apps/hackernews-tui/hackernews-tui.nix
  ./apps/television/television.nix
  ./apps/sourcegit/sourcegit.nix
  ./apps/xyosc/xyosc.nix
  ./apps/vesktop/vesktop.nix
  ./apps/freetube/freetube.nix
  ];
}
