{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.weechat_buflist = {

    enable = true;
    #onChange = manually tell darkreader to refresh somehow?
    target = "weechat/buflist.conf";
    text = ''
      [look]
      add_newline = on
      auto_scroll = 50
      display_conditions = "''${buffer.hidden}==0 && ((''${type}!=server && ''${buffer.full_name}!=core.weechat) || ''${buffer.active}==1)"
      enabled = on
      mouse_jump_visited_buffer = on
      mouse_move_buffer = on
      mouse_wheel = on
      nick_prefix = off
      nick_prefix_empty = on
      signals_refresh = ""
      sort = "number,-active"

      [format]
      buffer = "''${format_number}''${indent}''${format_nick_prefix}''${color_hotlist}''${format_name}"
      buffer_current = "''${color:magenta}''${if:''${type}==server?''${color:brown,default}:''${color:cyan,default}}''${if:''${buffer.name}=~^server?''${if:''${buffer.prev_buffer.number}==''${buffer.number}?├:┬}:''${if:''${type}==channel||''${type}==private?: }}''${indent}''${color_hotlist}''${format_nick_prefix}''${cut:15,…,''${name}} ''${hotlist}"
      hotlist = " ''${color:green}(''${hotlist}''${color:green})"
      hotlist_highlight = "''${color:magenta}"
      hotlist_low = "''${color:white}"
      hotlist_message = "''${color:brown}"
      hotlist_none = "''${color:default}"
      hotlist_private = "''${color:blue}"
      hotlist_separator = "''${color:default},"
      indent = "''${color:green}''${if:''${buffer.next_buffer.local_variables.type}=~^(channel|private)$?├─:└─}"
      lag = " ''${color:green}[''${color:brown}''${lag}''${color:green}]"
      name = "''${name}"
      nick_prefix = "''${color_nick_prefix}''${nick_prefix}"
      number = ""
    '';
  };
}
