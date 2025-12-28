{ config, lib, pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.blanket # ambient noise player
    #pkgs.piper-tts # Advanced text to speech
    pkgs.audio-sharing # Automatically share the current audio playback in the form of an RTSP stream

    ##################
    # Audio Controls #
    ##################
    pkgs.qpwgraph # QT patchbay for pipewire
    pkgs.helvum # GTK patchbay for pipewire
    pkgs.coppwr # Low level control GUI for pipewire
    pkgs.pwvucontrol # volume control gui (pipewire)
    pkgs.pavucontrol # PulseAudio control GUI (pulse)
    pkgs.playerctl # MPRIS control CLI

    #######################
    # System Audio Utils  #
    #######################
    pkgs.pipewire
    pkgs.pulseaudio # included to get pactl, not actually running via hardware.pulseaudio
    pkgs.alsa-utils # amixer and other utilities

    ###########
    # Effects #
    ###########
    pkgs.easyeffects # Sound effects for pipewire apps

    ##############
    # Converters #
    ##############
    pkgs.ffmpeg
    pkgs.soundconverter # sound conversion GUI

    #############
    # Recorders #
    #############
    pkgs.asak # TUI audio player/recorder
    pkgs.audacity
    pkgs.gnome-sound-recorder # simple sound recorder

    ############
    # Analysis #
    ############
    pkgs.sonic-visualiser # sonic analysis tool
    pkgs.friture # real-time audio analyzer

    ##########
    # CD/DVD #
    ##########
    pkgs.asunder # CD ripper GUI
    pkgs.brasero # GNOME CD/DVD burner
    pkgs.flacon # Extracts audio tracks from an audio CD image to separate tracks

    #########
    # Radio #
    #########
    pkgs.shortwave # GNOME internet radio
    pkgs.pyradio # TUI internet radio: run with --no-themes to disable color themes and use system

    ##############
    # Audiobooks #
    ##############
    pkgs.cozy # GNOME audiobook player
    
    ###############
    # Downloaders #
    ###############
    pkgs.spotdl # Download spotify playlists/metadata
    #pkgs.onthespot # download spotify music # unmaintained

    ##################
    # Song ID/Lyrics #
    ##################
    pkgs.mousai # GTK song identifier
    #pkgs.shaq # CLI for Shazam (Song identifier)
    pkgs.swaglyrics # TUI spotify lyrics

    ###############
    # Visualizers #
    ###############
    pkgs.spek # acoustic audio spectrum visualizer
    pkgs.glava
    #pkgs.cava # TUI music visualizer
    pkgs.catnip # more visualizers
    pkgs.cli-visualizer # another visualizer
    pkgs.projectm-sdl-cpp # more visualizers
    pkgs.cavalier # cava based visualizers
    pkgs.scope-tui # TUI oscilloscope/vectorscope.spectroscope also a music visualizer
    inputs.xyosc.packages.${pkgs.system}.default # another visualizer

    ##################
    # Music Taggers  #
    ##################
    pkgs.eartag # GNOME GUI for editing audio metadata
    pkgs.easytag # GUI for editing audio metadata
    pkgs.picard # musicbrainz tagger

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
    pkgs.decibels # GNOME simple audio player GUI






  ];
}
