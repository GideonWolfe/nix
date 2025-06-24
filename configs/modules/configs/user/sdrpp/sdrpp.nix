{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

let

  sdrppTheme = {
    name = "Stylix";
    author = "GideonWolfe";
    Border = "${base04}7F";
    BorderShadow = "${base01}00";
    Button = "${base00}FF";
    ButtonActive = "${base02}FF";
    ButtonHovered = "${base02}FF";
    CheckMark = "${base0B}FF";
    ChildBg = "${base05}00";
    DragDropTarget = "${base0A}E5";
    FrameBg = "${base00}FF";
    FrameBgActive = "${base02}FF";
    FrameBgHovered = "${base02}FF";
    Header = "${base04}4F";
    HeaderActive = "${base04}4F";
    HeaderHovered = "${base04}66";
    MenuBarBg = "${base00}FF";
    ModalWindowDimBg = "${base01}80";
    NavHighlight = "${base04}FF";
    NavWindowingDimBg = "${base04}33";
    NavWindowingHighlight = "${base05}B2";
    PlotHistogram = "${base09}FF";
    PlotHistogramHovered = "${base0A}FF";
    PlotLines = "${base0E}FF";
    PlotLinesHovered = "${base08}FF";
    PopupBg = "${base01}EE";
    ResizeGrip = "${base0B}3F";
    ResizeGripActive = "${base03}F2";
    ResizeGripHovered = "${base0B}AA";
    ScrollbarBg = "${base01}FF";
    ScrollbarGrab = "${base0E}FF";
    ScrollbarGrabActive = "${base09}FF";
    ScrollbarGrabHovered = "${base0E}CC";
    Separator = "${base03}7F";
    SeparatorActive = "${base0D}FF";
    SeparatorHovered = "${base04}C6";
    SliderGrab = "${base0E}FF";
    SliderGrabActive = "${base09}FF";
    Tab = "${base0E}DB";
    TabActive = "${base0E}FF";
    TabHovered = "${base0E}CC";
    TabUnfocused = "${base00}F7";
    TabUnfocusedActive = "${base08}FF";
    TableBorderLight = "${base0B}FF";
    TableBorderStrong = "${base01}EF";
    TableHeaderBg = "${base01}FF";
    TableRowBg = "${base01}00";
    TableRowBgAlt = "${base05}0F";
    Text = "${base05}FF";
    TextDisabled = "${base04}FF";
    TextSelectedBg = "${base0D}59";
    TitleBg = "${base01}FF";
    TitleBgActive = "${base02}FF";
    TitleBgCollapsed = "${base01}82";
    WindowBg = "${base01}EF";
    ClearColor = "${base01}FF";
    WaterfallBackground = "${base01}FF";
  };

  sdrppColormap = {
    name = "Stylix Colors";
    author = "Gideon Wolfe";
    map = [
      "${base01}" # background
      "${base00}" # light background
      "${base02}"
      "${base0E}" # purple
      "${base0D}" # blue
      "${base0A}" # yellow
      "${base09}" # orange
      "${base08}" # red
    ];
  };

  sdrppBandColors = {
    bandColors = {
      amateur = "${base08}FF";
      aviation = "${base0C}FF";
      broadcast = "${base09}FF";
      marine = "${base0D}FF";
      military = "${base0A}FF";
    };
  };

  themeFile = pkgs.writers.writeJSON "stylix.json" sdrppTheme;
  colormapFile = pkgs.writers.writeJSON "stylix.json" sdrppColormap;
  bandColorsFile = pkgs.writers.writeJSON "config.json" sdrppBandColors;
  USAbandplan = pkgs.fetchurl {
    url =
      "https://raw.githubusercontent.com/Arrin-KN1E/SDR-Band-Plans/refs/heads/master/US/SDR%2B%2B/usa-kn1e.json";
    hash = "sha256-vICSR9hP4wiq3uRtdXlpCRYdO5guV/3IszV7zRLdYM4=";
  };

  sdrpp = pkgs.sdrpp.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      cp ${themeFile} $out/share/sdrpp/themes
      cp ${colormapFile} $out/share/sdrpp/colormaps
      cp ${USAbandplan} $out/share/sdrpp/bandplans
    '';
  });

in {
  home.packages = [ sdrpp ];
  #services.avahi.enable = true;

  # xdg.configFile.sdrpp-config = {
  #   enable = true;
  #   target = "sdrpp/config.json";
  #   text = builtins.toJSON ;
  # };

  # BUG: this will fail on a new install because config.json doesn't exist
  home.activation.changeSdrppColors =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      cat ${config.home.homeDirectory}/.config/sdrpp/config.json | jq ' .bandColors.amateur = "${base0A}FF" | .bandColors.aviation = "${base0C}FF" | .bandColors.broadcast = "${base09}FF" | .bandColors.marine = "${base0D}FF" | .bandColors.military = "${base08}FF" | .bandColors.voice = "${base07}FF" | .colorMap = "Stylix Colors" | .theme = "Stylix" | .vfoColors.Radio = "${base0B}" ' | ${pkgs.moreutils}/bin/sponge ${config.home.homeDirectory}/.config/sdrpp/config.json
    '';

}
