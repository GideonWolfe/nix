{ pkgs, lib, config, osConfig, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.newsboat = {
    enable = true;
    extraConfig = ''
                  urls-source "freshrss"
                  freshrss-url "https://rss.gideonwolfe.xyz/api/greader.php"
                  freshrss-login "gideon"
                  #freshrss-passwordfile "${config.home.homeDirectory}/.secrets/rss/freshrss_api_key"
                  freshrss-passwordfile "${
                    osConfig.sops.secrets."freshrss/apikey".path
                  }"

      # -- feeds ---------------------------------------------------------------------

                  auto-reload yes
                  reload-time 120
                  reload-threads 4
                  download-retries 4
                  download-timeout 10
                  prepopulate-query-feeds yes
                  download-full-page yes

      # -- display -------------------------------------------------------------------

                  show-read-feeds yes
                  feed-sort-order unreadarticlecount-asc

                  color info blue default
                  color listnormal blue default
                  color listnormal_unread cyan default
                  color listfocus red default bold
                  color listfocus_unread red default bold


                  color article cyan default
                  color listnormal yellow default

                  text-width 80

      # Article Colors
      #
                  articlelist-format "%4i %f %D  %?T?|%-17T| ?%t"

      # highlight feedlist    "^  *[0-9]+  *N  "                    magenta  default
                  highlight articlelist "^  *[0-9]+  *N  "                    magenta  default

                  highlight article     "(^Feed:.*|^Title:.*|^Author:.*)"     red      default
                  highlight article     "(^Link:.*|^Date:.*)"                 white    default
                  highlight article     "^Podcast Download URL:.*"            cyan     default
                  highlight article     "^Links:"                             magenta  black    underline
                  highlight article     "https?://[^ ]+"                      green    default
                  highlight article     "^(Title):.*$"                        blue     default
                  highlight article     "\\[[0-9][0-9]*\\]"                   magenta  default  bold
                  highlight article     "\\[image\\ [0-9]+\\]"                green    default  bold
                  highlight article     "\\[embedded flash: [0-9][0-9]*\\]"   green    default  bold
                  highlight article     ":.*\\(link\\)$"                      cyan     default
                  highlight article     ":.*\\(image\\)$"                     blue     default
                  highlight article     ":.*\\(embedded flash\\)$"            magenta  default


      # -- navigation ----------------------------------------------------------------

                  goto-next-feed no

                  browser "xdg-open"

                  bind-key h quit articlelist
                  bind-key h quit article
                  bind-key h quit tagselection
      #bind-key h quit feedlist
                  bind-key j down feedlist
                  bind-key j down tagselection
                  bind-key j next articlelist
                  bind-key j down article
                  bind-key J next-feed articlelist
                  bind-key k up feedlist
                  bind-key k prev articlelist
                  bind-key k up tagselection
                  bind-key K prev-feed articlelist
                  bind-key k up article
                  bind-key l open articlelist
                  bind-key l open feedlist
                  bind-key l open tagselection

                  bind-key G end
                  bind-key g home

                  bind-key d pagedown
                  bind-key u pageup


      # hide articles matching: ---------------------------------------------

                  ignore-article "*" "title =~ \"Sponsor\""
                  ignore-article "*" "title =~ \"Advertisement\""
                  ignore-mode "display"
    '';

  };
}
