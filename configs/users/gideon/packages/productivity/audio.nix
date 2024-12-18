{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.audacity
    #pkgs.spotify # disabled because stylix/spicetify install the binary
    pkgs.swaglyrics # TUI spotify lyrics
    pkgs.asunder # CD ripper GUI
    pkgs.brasero # GNOME CD/DVD burner
    #pkgs.easytag # GUI for editing audio metadata
    pkgs.friture # real-time audio analyzer
    pkgs.cmus # TUI music player
    pkgs.termsonic # TUI subsonic client
    #pkgs.sublime-music #GUI Subsonic music server client #BUG: this one slow as fuck
    #pkgs.feishin # GUI Subsonic music server client
    #pkgs.amarok # KDE GUI music player
    #pkgs.cava # TUI music visualizer
    pkgs.cavalier # cava based visualizers
    pkgs.catnip # more visualizers
    pkgs.cli-visualizer # another visualizer
    pkgs.projectm # more visualizers
    pkgs.glava
    pkgs.blanket # ambient noise player
    pkgs.piper-tts # Advanced text to speech
    #pkgs.shaq # CLI for Shazam (Song identifier)
    pkgs.spotdl # Download spotify playlists/metadata
    pkgs.pyradio # TUI internet radio

    # Music Production
    #pkgs.reaper # DAW
    #pkgs.yabridge # Yabridge for using Windows VSTs
    #pkgs.yabridgectl
    #pkgs.rakarrack # multi-effects processor emulating pedalboard
    #pkgs.guitarix # Guitar amp engine
    #pkgs.gxpluginx-lv2 # Guitarix plugins
    #pkgs.tonelib-metal # metal guitar tones
    #pkgs.tonelib-gfx
    #pkgs.tonelib-jam
    #pkgs.kapitonov-plugins-pack # More LV2 Plugins
    #pkgs.proteus # Capure guitar sound and train ML model on it
    #pkgs.tuxguitar # GUI for writing tabs
    #pkgs.helm # virtual synthesizer
    #pkgs.calf # music plugins (effects, tools, etc)
  ];
}
