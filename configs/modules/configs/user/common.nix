{ pkgs, lib, config, inputs, ... }:

{
  imports = [

    ###########
    # Modules #
    ###########
    inputs.agenix.homeManagerModules.age
    inputs.nixvim.homeManagerModules.nixvim
    inputs.spicetify-nix.homeManagerModules.default
    inputs.hyprpanel.homeManagerModules.hyprpanel
    inputs.sops-nix.homeManagerModules.sops

    # TODO remove we just need waybar to build cuz it uses the secret
    ../../../secrets/user_secrets.nix

    ###############
    # Shell Stuff #
    ###############
    ./shell/fish.nix # Primary shell
    ./shell/bash.nix # backup shell
    ./shell/starship.nix # gives a good prompt to bash and nix shells
    ./kitty/kitty.nix # preferred terminal
    ./zellij/zellij.nix # better screen/tmux
    ./nh/nh.nix # wrapper for nix builds
    ./zoxide/zoxide.nix # better cd
    ./eza/eza.nix # better ls
    ./bat/bat.nix # better cat
    ./atuin/atuin.nix # TUI shell history

    ###############
    # Environment #
    ###############
    ./session-variables/session-variables.nix # environment vars
    ./xdg-user-dirs/xdg-user-dirs.nix # default directories
    ./mimetypes/mimetypes.nix # default programs
    ./udiskie/udiskie.nix # automount USB drives

    ############
    # Networks #
    ############
    ./bluetooth/bluetooth.nix # enables BT applet
    ./kdeconnect/kdeconnect.nix

    #######
    # Git #
    #######
    ./git/git.nix
    ./gh/gh.nix

    ##############
    # UI/Desktop #
    ##############
    ./cursor/cursor.nix
    ./gtk/gtk.nix
    ./qt/qt.nix
    ./wofi/wofi.nix # app launcher
    ./swappy/swappy.nix # Screenshot editor
    ./fusuma/fusuma.nix # touchpad gestures
    ./kando/kando.nix # circle app launcher
    ./clipse/clipse.nix # clipboard manager TUI

    #################
    # Browser Stuff #
    #################
    ./chromium/chromium.nix
    ./firefox/firefox.nix
    ./darkreader/darkreader.nix
    ./startpage/style.nix
    ./startpage/service.nix

    ############
    # Hyprland #
    ############
    ./hypr/hyprland.nix
    ./hypr/hyprpaper.nix
    ./hypr/hypridle.nix
    ./hypr/hyprlock.nix
    ./hypr/hyprpanel.nix

    ########
    # Sway #
    ########
    ./sway/sway.nix
    ./sway/swaylock.nix # this was causing a build bug
    ./sway/swayidle.nix
    ./waybar/waybar.nix

    #############################
    # Essential Program Configs #
    #############################
    ./nixvim/nixvim.nix

    ################################
    # NonEssential Program Configs #
    ################################
    ./imv/imv.nix # imv theme
    ./zathura/zathura.nix # zathura theme
    ./foliate/foliate.nix # foliate theme
    ./irc/halloy.nix # halloy settings/theme
    ./btop/btop.nix # btop theme
    ./gnuplot/gnuplot.nix # gnuplot theme
    ./cava/cava.nix # cava settings/theme
    ./cavalier/cavalier.nix # cavalier settings/theme
    ./newsboat/newsboat.nix
    ./spicetify/spicetify.nix # spicetify theme
    ./fastfetch/fastfetch.nix
    ./vscode/vscode.nix # VScode settings
    ./blender/blender-theme.nix # blender theme
    ./obsidian/obsidian-stylix-css.nix # obsidian theme
    ./element/element.nix # element settings/theme
    ./ghidra/ghidra.nix # Ghidra theme
    ./kicad/kicad.nix # Kicad theme
    ./mpv/mpv.nix # mpv theme
    ./libreoffice/libreoffice.nix # libreoffice theme
    ./blockbench/blockbench.nix # blockbench theme
    ./minimeters/minimeters.nix
    ./godot/godot-theme.nix
    ./astrolog/astrolog.nix
    ./shortwave/shortwave.nix
    ./sdrpp/sdrpp.nix
    ./hackernews-tui/hackernews-tui.nix
    ./television/television.nix
    ./sourcegit/sourcegit.nix
  ];
}
