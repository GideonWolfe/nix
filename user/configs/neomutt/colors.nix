{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	xdg.configFile = {
		neomutt_colors = {
			enable = true;
			target = "neomutt/colors";
			text = ''

# vim: filetype=muttrc

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
color sidebar_highlight red default
color sidebar_divider brightblack black
color sidebar_flagged red black
color sidebar_new green black
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
color index brightyellow default "~N"
color index_author brightcyan black "~N"
color index_subject brightred black "~N"

color progress black cyan

# Status bar colors
color status brightyellow black
color status blue default '(\[|\])'
color status magenta default '( )'
color status magenta default ''
color status magenta default ''
color status magenta default ''
color status magenta default ''
color status magenta default ''
color status magenta default ''
color status magenta default ''

# Sidebar colors
# Sidebar-specific color of the selected item
color sidebar_indicator yellow default
# Color of the highlighted, but not open, mailbox.
color sidebar_highlight magenta default
# Color of the divider separating the Sidebar from NeoMutt panels
# color sidebar_divider color8 black
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
	};
}
