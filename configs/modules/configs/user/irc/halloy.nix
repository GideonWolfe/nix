{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{

  xdg.configFile.halloy-config = {
    enable = true;
    target = "halloy/config.toml";
    text = ''
      theme = "Stylix"
      scale_factor = 1.3

      [servers.liberachat]
      nickname = "demoncore"
      username = "demoncore"
      realname = "demoncore"
      nick_password_file = "${config.sops.secrets."irc/libera/password".path}"
      server = "irc.libera.chat"
      port = 6697
      channels = [
          "#halloy",
          "#python",
          "#linux",
          "#python",
          "#security",
          "#networking",
          "#bash",
          "#git",
          "##programming",
          "#go-nuts",
          "#hardware",
          "#vim",
          "#wireguard",
          "#weechat",
          "#docker",
          "#nixos",
          "#neovim",
          "##math",
          "#raspberrypi",
          "#systemd",
          "#hamradio",
          "##rtlsdr",
          "#javascript",
          "#nextcloud",
          "#datahoarder",
          "#firefox",
          "#gamingonlinux",
          "#arduino",
          "##space",
          "#latex",
          "#neomutt",
          "##science",
          "#blender",
          "##ibmthinkpad",
          "#sonar",
          "#devops",
          "#jellyfin",
          "##astronomy",
          "##re",
          "#godotengine",
          "#mechboards"
      ]


      [file_transfer]
      save_directory = "${config.xdg.userDirs.download}"


      [font]
      family = "${config.stylix.fonts.monospace.name}"
      size = ${builtins.toString config.stylix.fonts.sizes.desktop}

      [keyboard]
      move_up = "alt+k"
      move_down = "alt+j"
      move_left = "alt+h"
      move_right = "alt+l"

      [pane]
      split_axis = "horizontal"

      # Values: "new-pane", "replace-pane", "new-window"
      [sidebar]
      buffer_action = "replace-pane"
      buffer_focused_action = "close-pane"

      [buffer.server_messages.join]
      smart = 180

      [buffer.server_messages.part]
      smart = 180

      [buffer.server_messages.quit]
      smart = 180

      [buffer.server_messages.topic]
      enabled = false

    '';
  };

  #HACK: just hardcoding here until stylix gets an update and I can use the default halloy target (which I copied this from)
  xdg.configFile.halloy-theme = {
    enable = true;
    target = "halloy/themes/Stylix.toml";
    text = ''
      [general]
      background = "${base00}"
      border = "${base07}"
      horizontal_rule = "${base02}"
      unread_indicator = "${base0A}"


      [text]
      primary = "${base05}"
      secondary = "${base04}"
      tertiary = "${base0A}"
      success = "${base0B}"
      error = "${base08}"


      [buffer]
      action = "${base0B}"
      background = "${base00}"
      background_text_input = "${base01}"
      background_title_bar = "${base01}"
      border = "${base03}"
      border_selected = "${base07}"
      code = "${base0E}"
      highlight = "${base01}"
      nickname = "${base0C}"
      selection = "${base02}"
      timestamp = "${base05}"
      topic = "${base04}"
      url = "${base0D}"

      [buffer.server_messages]
      join = "${base0B}"
      part = "${base08}"
      quit = "${base08}"
      default = "${base0C}"



      [buttons.primary]
      background = "${base00}"
      background_hover = "${base02}"
      background_selected = "${base03}"
      background_selected_hover = "${base04}"


      [buttons.secondary]
      background = "${base01}"
      background_hover = "${base02}"
      background_selected = "${base03}"
      background_selected_hover = "${base04}"
    '';
  };
}
