{ config, lib, pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.audacity
    pkgs.gnome-sound-recorder # simple sound recorder
    pkgs.sonic-visualiser # sonic analysis tool
    pkgs.friture # real-time audio analyzer
    pkgs.onthespot # download spotify music
    pkgs.swaglyrics # TUI spotify lyrics
    pkgs.asunder # CD ripper GUI
    pkgs.brasero # GNOME CD/DVD burner
    #pkgs.easytag # GUI for editing audio metadata
    pkgs.eartag # GNOME GUI for editing audio metadata
    #pkgs.cava # TUI music visualizer
    pkgs.cavalier # cava based visualizers
    pkgs.scope-tui # TUI oscilloscope/vectorscope.spectroscope also a music visualizer
    inputs.xyosc.packages.${pkgs.system}.default # another visualizer
    pkgs.catnip # more visualizers
    pkgs.cli-visualizer # another visualizer
    pkgs.projectm-sdl-cpp # more visualizers
    #pkgs.libprojectm might not be needed
    pkgs.glava
    pkgs.blanket # ambient noise player
    pkgs.piper-tts # Advanced text to speech
    #pkgs.shaq # CLI for Shazam (Song identifier)
    pkgs.mousai # GTK song identifier
    pkgs.spotdl # Download spotify playlists/metadata
    pkgs.pyradio # TUI internet radio: run with --no-themes to disable color themes and use system
    pkgs.shortwave # GNOME internet radio
    pkgs.easyeffects # Sound effects for pipewire apps
    pkgs.cozy # GNOME audiobook player
    pkgs.flacon # Extracts audio tracks from an audio CD image to separate tracks
    pkgs.audio-sharing # Automatically share the current audio playback in the form of an RTSP stream
    pkgs.asak # TUI audio player/recorder
    pkgs.spek # acoustic audio spectrum visualizer

    ##################
    # Music Players  #
    ##################
    #pkgs.spotify # disabled because stylix/spicetify install the binary
    pkgs.cmus # TUI music player
    pkgs.termusic # TUI music player
    pkgs.termsonic # TUI subsonic client
    pkgs.fum # MPRIS TUI client
    #pkgs.sublime-music #GUI Subsonic music server client #BUG: this one slow as fuck
    #pkgs.feishin # GUI Subsonic music server client #TODO: rewritten into audioling, not a package yet
    #pkgs.finamp # Jellyfin music player
    #pkgs.supersonic # subsonic client https://github.com/dweymouth/supersonic/blob/main/res/themes/default.toml
    #pkgs.amarok # KDE GUI music player
    #pkgs.deadbeef-with-plugins # GUI music player unmaintained, might need to just use deadbeef

    ####################
    # Music Production #
    ####################
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
    #pkgs.infamousPlugins # more LV2 plugins
    #pkgs.mixxx # DJ software
    #pkgs.zrythm # DAW
    pkgs.piano-rs # TUI piano
    pkgs.vmpk # Virtual MIDI Piano Keyboard
    pkgs.drum-machine # GTK drum machine
  ];
}
