{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

let

  sdrppTheme = {
    name = "Stylix";
    author = "GideonWolfe";
    Border = "#6D6D7F7F";
    BorderShadow = "${base01}00";
    Button = "${base00}FF";
    ButtonActive = "${base02}FF";
    ButtonHovered = "${base02}FF";
    CheckMark = "${base0B}FF";
    ChildBg = "${base05}00";
    DragDropTarget = "#FFFF00E5";
    FrameBg = "${base00}FF";
    FrameBgActive = "${base02}FF";
    FrameBgHovered = "${base02}FF";
    Header = "#A0A0B24F";
    HeaderActive = "#A0A0B24F";
    HeaderHovered = "#A0A0B266";
    MenuBarBg = "#232323FF";
    ModalWindowDimBg = "${base01}80";
    NavHighlight = "#999999FF";
    NavWindowingDimBg = "#CCCCCC33";
    NavWindowingHighlight = "${base05}B2";
    PlotHistogram = "#BA9926FF";
    PlotHistogramHovered = "#FF9900FF";
    PlotLines = "${base0E}FF";
    PlotLinesHovered = "#FF6D59FF";
    PopupBg = "${base01}EE";
    ResizeGrip = "#E8E8E83F";
    ResizeGripActive = "#757575F2";
    ResizeGripHovered = "#CECECEAA";
    ScrollbarBg = "${base01}FF";
    ScrollbarGrab = "${base0E}FF";
    ScrollbarGrabActive = "${base09}FF";
    ScrollbarGrabHovered = "${base0E}CC";
    Separator = "#6D6D7F7F";
    SeparatorActive = "#828282FF";
    SeparatorHovered = "#B7B7B7C6";
    SliderGrab = "${base0E}FF";
    SliderGrabActive = "#FF038FFF";
    Tab = "${base0E}DB";
    TabActive = "${base0E}FF";
    TabHovered = "${base0E}CC";
    TabUnfocused = "#111A25F7";
    TabUnfocusedActive = "#DB7093FF";
    TableBorderLight = "${base0B}FF";
    TableBorderStrong = "${base01}EF";
    TableHeaderBg = "${base01}FF";
    TableRowBg = "${base01}00";
    TableRowBgAlt = "${base05}0F";
    Text = "${base05}FF";
    TextDisabled = "#7F7F7FFF";
    TextSelectedBg = "#DDDDDD59";
    TitleBg = "#0A0A0AFF";
    TitleBgActive = "#494949FF";
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

  themeFile = pkgs.writers.writeJSON "stylix.json" sdrppTheme;
  colormapFile = pkgs.writers.writeJSON "stylix.json" sdrppColormap;

  sdrpp = pkgs.sdrpp.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      cp ${themeFile} $out/share/sdrpp/themes
      cp ${colormapFile} $out/share/sdrpp/colormaps
    '';
  });

in { home.packages = [ sdrpp ]; }
