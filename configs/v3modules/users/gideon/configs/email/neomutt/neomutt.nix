{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.neomutt = {
    enable = true;
    sourcePrimaryAccount = true;
    unmailboxes = false;
    #vimKeys = true;
    sidebar = {
      enable = true;
      shortPath = true;
    };

    settings = {
      mail_check_stats = "yes";
      flag_chars = ''""'';
      crypt_chars = ''" "'';
      status_chars = ''"  "'';
      status_format = ''
        "[ %D ] %?r?[  %m ] ?%?n?[  %n ] ?%?d?[  %d ] ?%?t?[  %t ] ?%?F?[  %F ] ?%?p?[  %p ]?%|─"'';
      date_format = ''"%h %d %I:%M%p"'';

      sort = "threads";
      sort_aux = "reverse-last-date-received";

      edit_headers = "true";
      fast_reply = "true";
      askcc = "true";
      fcc_attach = "yes";
      #fwd_format = ''"Fwd: %s"'';
      #fcc_decode = "true";
      attribution = ''"On %d, %n wrote:"'';
      reply_to = "yes";
      reverse_name = "true";
      include = "yes";
      forward_quote = "true";
      text_flowed = "true";
      sig_dashes = "false";
      help = "false";
      confirmappend = "false";
      quit = "yes";
      mark_old = "false";
      beep_new = "true";
      pipe_decode = "true";
      thorough_search = "true";
      uncollapse_jump = "true";
      sort_re = "true";

      reply_regexp = ''"^(([Rr][Ee]?(\[[0-9]+\])?: *)?(\[[^]]+\] *)?)*"'';
      quote_regexp = ''"^( {0,4}[>|:#%]| {0,4}[a-z0-9]+[>|]+)+"'';
      charset = ''"utf-8"'';

      arrow_cursor = ''"no"'';

      #index_format = ''"%?M? ↳&%4? %Z  %-20.20n  %D  %s"'';
      index_format = ''"%?M?↳&? %Z  %-20.20n  %D  %s"'';
      to_chars = ''""'';

      # Pager settings
      pager_format = ''
        "[ %n ] [ %T %s ]%* [  %{!%d %b · %I:%M%p} ] %?X?[  %X ]? [  %P ]%|─"'';
      pager_index_lines = "10";
      pager_context = "3";
      pager_stop = "true";
      menu_scroll = "true";
      tilde = "true";
      markers = "false";

      compose_format = ''"[ %l] [ %a]%>─"'';

      #attach_format = ''"%u%D  %T%-75.75d %?T?%&   ? %5s · %m/%M"'';
      attach_format = ''"%u%D  %T%-75.75d %<T?&   > %5s · %m/%M"'';

      # Sidebar options
      #BUG: this setting ignored
      #sidebar_format = ''"%D%?F? %?N?%N/?%S"'';
      #sidebar_format = ''"%D"'';
      sidebar_folder_indent = "no";
      sidebar_width = "15";
      sidebar_indent_string = ''" - "'';
      sidebar_divider_char = ''" │ "'';
      sidebar_component_depth = "0";
      #sidebar_sort_method = "unsorted";

    };

    binds = [
      {
        map = [ "editor" ];
        key = "<space>";
        action = "noop";
      }
      ##################
      # Vim Navigation #
      ##################
      {
        map = [ "index" ];
        key = "G";
        action = "last-entry";
      }
      # To make gg register correctly
      {
        map = [ "index" ];
        key = "g";
        action = "noop";
      }
      {
        map = [ "index" ];
        key = "gg";
        action = "first-entry";
      }
      # Enter mailcap from within message
      {
        map = [ "attach" ];
        key = "<return>";
        action = "view-mailcap";
      }
      {
        map = [ "attach" ];
        key = "l";
        action = "view-mailcap";
      }
      # Exit with h
      {
        map = [ "pager" "attach" ];
        key = "h";
        action = "exit";
      }
      {
        map = [ "pager" ];
        key = "j";
        action = "next-line";
      }
      {
        map = [ "pager" ];
        key = "k";
        action = "previous-line";
      }
      {
        map = [ "pager" ];
        key = "l";
        action = "view-attachments";
      }
      {
        map = [ "index" ];
        key = "D";
        action = "delete-message";
      }
      {
        map = [ "index" ];
        key = "U";
        action = "undelete-message";
      }
      {
        map = [ "index" ];
        key = "L";
        action = "limit";
      }
      {
        map = [ "index" ];
        key = "h";
        action = "noop";
      }
      {
        map = [ "index" ];
        key = "l";
        action = "display-message";
      }
      {
        map = [ "browser" ];
        key = "h";
        action = "goto-parent";
      }
      {
        map = [ "browser" ];
        key = "l";
        action = "select-entry";
      }
      {
        map = [ "browser" ];
        key = "gg";
        action = "top-page";
      }
      {
        map = [ "browser" ];
        key = "G";
        action = "bottom-page";
      }
      # {
      #   map = [ "browser" "pager" "index" ];
      #   key = "d";
      #   action = "half-down";
      # }
      {
        map = [ "browser" "pager" "index" ];
        key = "u";
        action = "half-up";
      }
      {
        map = [ "pager" "index" ];
        key = "R";
        action = "group-reply";
      }
      {
        map = [ "index" ];
        key = "\\031";
        action = "previous-undeleted";
      }
      {
        map = [ "index" ];
        key = "\\005";
        action = "next-undeleted";
      }
      {
        map = [ "pager" ];
        key = "\\031";
        action = "previous-line";
      }
      {
        map = [ "pager" ];
        key = "\\005";
        action = "next-line";
      }
      {
        map = [ "editor" ];
        key = "<Tab>";
        action = "complete-query";
      }
      {
        map = [ "index" "pager" ];
        key = "\\Ck";
        action = "sidebar-prev";
      }
      {
        map = [ "index" "pager" ];
        key = "\\Cj";
        action = "sidebar-next";
      }
      {
        map = [ "index" "pager" ];
        key = "\\Co";
        action = "sidebar-open";
      }
      {
        map = [ "index" "pager" ];
        key = "\\Cp";
        action = "sidebar-prev-new";
      }
      {
        map = [ "index" "pager" ];
        key = "\\Cn";
        action = "sidebar-next-new";
      }
      {
        map = [ "index" "pager" ];
        key = "@";
        action = "compose-to-sender";
      }
      {
        map = [ "index" "pager" ];
        key = "D";
        action = "purge-message";
      }
      {
        map = [ "index" ];
        key = "<space>";
        action = "collapse-thread";
      }
    ];
    extraConfig = ''
      source ~/.config/neomutt/gideonwolfexyz
      source ~/.config/neomutt/gideonwolfecom

      # Search khard for contacts
      set query_command="khard email --parsable '%s'"

      #set sidebar_format = "%D%* %<N?%N>"

      # Header colors:
      color header blue default ".*"
      color header brightmagenta default "^(From)"
      color header brightcyan default "^(Subject)"
      color header brightwhite default "^(CC|BCC)"

      mono bold bold
      mono underline underline
      mono indicator reverse
      mono error bold
      color normal default default
      color indicator brightyellow default # currently selected message. default makes bar clear, disabled arrow to save space.
      #color sidebar_highlight red default
      #color sidebar_divider blue black
      #color sidebar_flagged red black
      #color sidebar_new green black
      color normal brightyellow default
      color error red default
      color tilde black default
      color message cyan default
      color markers red white
      color attachment white default
      color search brightmagenta default
      color hdrdefault brightgreen default
      color quoted green default
      color quoted1 blue default
      color quoted2 cyan default
      color quoted3 yellow default
      color quoted4 red default
      color quoted5 brightred default
      color signature brightgreen default
      color bold black default
      color underline black default
      color normal default default

      color body brightred default "[\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+" # Email addresses
      color body brightblue default "(https?|ftp)://[\-\.,/%~_:?&=\#a-zA-Z0-9]+" # URL
      color body green default "\`[^\`]*\`" # Green text between ` and `
      color body brightblue default "^# \.*" # Headings as bold blue
      color body brightcyan default "^## \.*" # Subheadings as bold cyan
      color body brightgreen default "^### \.*" # Subsubheadings as bold green
      color body yellow default "^(\t| )*(-|\\*) \.*" # List items as yellow
      color body brightcyan default "[;:][-o][)/(|]" # emoticons
      color body brightcyan default "[;:][)(|]" # emoticons
      color body brightcyan default "[ ][*][^*]*[*][ ]?" # more emoticon?
      color body brightcyan default "[ ]?[*][^*]*[*][ ]" # more emoticon?
      color body red default "(BAD signature)"
      color body cyan default "(Good signature)"
      color body brightblack default "^gpg: Good signature .*"
      color body brightyellow default "^gpg: "
      color body brightyellow red "^gpg: BAD signature from.*"
      mono body bold "^gpg: Good signature"
      mono body bold "^gpg: BAD signature from.*"
      color body red default "([a-z][a-z0-9+-]*://(((([a-z0-9_.!~*'();:&=+$,-]|%[0-9a-f][0-9a-f])*@)?((([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(:[0-9]+)?)|([a-z0-9_.!~*'()$,;:@&=+-]|%[0-9a-f][0-9a-f])+)(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?(#([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?|(www|ftp)\\.(([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?(:[0-9]+)?(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?(#([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?)[^].,:;!)? \t\r\n<>\"]"

      # Patch/diff highlights1
      # Patch syntax highlighting
      #color   normal  white           default                                         
      color   body    brightwhite     default         ^[[:space:]].*                  
      color   body    yellow          default         ^(diff).*                       
      #color   body    white           default         "^[\-\-\-].*"                     
      #color   body    white           default         "^[\+\+\+].*"                     
      #color   body    green           default         "^[\+].*"                         
      #color   body    red             default         "^[\-].*"                         
      #color   body    brightblue      default         "[@@].* "                         
      color   body    brightwhite     default         "^(\s).*"                         
      color   body    cyan            default         "^(Signed-off-by).*"
      color   body    cyan            default         "^(Docker-DCO-1.1-Signed-off-by).*"
      color   body    brightwhite     default         "^(Cc)"
      color   body    yellow          default         "^diff \-.*"
      color   body    brightwhite     default         "^index [a-f0-9].*"
      color   body    brightblue      default         "^---$"
      color   body    white           default         "^\-\-\- .*"
      color   body    white           default         "^[\+]{3} .*"
      color   body    green           default         "^[\+][^\+]+.*"
      color   body    red             default         "^\-[^\-]+.*"
      color   body    brightblue      default         "^@@ .*"
      color   body    green           default         "LGTM"
      color   body    brightmagenta   default         "-- Commit Summary --"
      color   body    brightmagenta   default         "-- File Changes --"
      color   body    brightmagenta   default         "-- Patch Links --"
      color   body    green           default         "^Merged #.*"
      color   body    red             default         "^Closed #.*"
      color   body    brightblue      default         "^Reply to this email.*"




      # Default index colors:
      color tree   yellow default
      color index yellow default '.*'
      color index_author cyan default '.*'
      color index_number blue default
      color index_subject red default '.*'
      # Special flag coloring
      color index_flags blue default '.*'

      # For new mail:
      #color index brightyellow default "~N"
      #color index_author brightcyan black "~N"
      #color index_subject brightred black "~N"

      color progress black cyan

      # Status bar colors
      color status brightyellow black
      color status blue default '(\[|\])'
      color status magenta default '( )'
      color status green default ''
      color status brightblue default ''
      color status magenta default ''
      color status red default ''
      color status blue default ''
      color status magenta default ''
      color status brightcyan default ''

      # Sidebar colors
      # Sidebar-specific color of the selected item
      color sidebar_indicator yellow default
      # Color of the highlighted, but not open, mailbox.
      color sidebar_highlight magenta default
      # Color of the divider separating the Sidebar from NeoMutt panels
      color sidebar_divider brightmagenta black
      # Color to give mailboxes containing flagged mail
      # color sidebar_flagged red black
      # Color to give mailboxes containing new mail
      color sidebar_new green default
      # Color to give mailboxes containing no new/flagged mail, etc.
      # color sidebar_ordinary color8 default
      # Color to give the spoolfile mailbox
      # color sidebar_spoolfile color207 default
      # Color to give mailboxes containing unread mail
      # color sidebar_unread color7 default
    '';
  };
}
