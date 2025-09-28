{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.halloy # IRC GUI
    pkgs.weechat # IRC TUI
    pkgs.weechatScripts.weechat-notify-send # allow weechat to send notifications
    pkgs.weechatScripts.autosort
    pkgs.weechatScripts.highmon
  ];
}
