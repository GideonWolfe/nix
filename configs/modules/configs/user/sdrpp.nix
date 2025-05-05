{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

let

  sdrppTheme = {
    name = "Deep Pink";
    author = "GayCookie";
    Border = "#6D6D7F7F";
    BorderShadow = "#00000000";
    Button = "#670039FF";
    ButtonActive = "#840049FF";
    ButtonHovered = "#840049FF";
    CheckMark = "#FF69B4FF";
    ChildBg = "#FFFFFF00";
    DragDropTarget = "#FFFF00E5";
    FrameBg = "#670039FF";
    FrameBgActive = "#840049FF";
    FrameBgHovered = "#840049FF";
    Header = "#A0A0B24F";
    HeaderActive = "#A0A0B24F";
    HeaderHovered = "#A0A0B266";
    MenuBarBg = "#232323FF";
    ModalWindowDimBg = "#00000080";
    NavHighlight = "#999999FF";
    NavWindowingDimBg = "#CCCCCC33";
    NavWindowingHighlight = "#FFFFFFB2";
    PlotHistogram = "#BA9926FF";
    PlotHistogramHovered = "#FF9900FF";
    PlotLines = "#FF69B4FF";
    PlotLinesHovered = "#FF6D59FF";
    PopupBg = "#2B0018EE";
    ResizeGrip = "#E8E8E83F";
    ResizeGripActive = "#757575F2";
    ResizeGripHovered = "#CECECEAA";
    ScrollbarBg = "#4B0029FF";
    ScrollbarGrab = "#FF69B4FF";
    ScrollbarGrabActive = "#FF038FFF";
    ScrollbarGrabHovered = "#FF69B4CC";
    Separator = "#6D6D7F7F";
    SeparatorActive = "#828282FF";
    SeparatorHovered = "#B7B7B7C6";
    SliderGrab = "#FF69B4FF";
    SliderGrabActive = "#FF038FFF";
    Tab = "#FF69B4DB";
    TabActive = "#FF69B4FF";
    TabHovered = "#FF69B4CC";
    TabUnfocused = "#111A25F7";
    TabUnfocusedActive = "#DB7093FF";
    TableBorderLight = "#5E0034FF";
    TableBorderStrong = "#2B0018EF";
    TableHeaderBg = "#2B0018FF";
    TableRowBg = "#00000000";
    TableRowBgAlt = "#FFFFFF0F";
    Text = "#FFFFFFFF";
    TextDisabled = "#7F7F7FFF";
    TextSelectedBg = "#DDDDDD59";
    TitleBg = "#0A0A0AFF";
    TitleBgActive = "#494949FF";
    TitleBgCollapsed = "#00000082";
    WindowBg = "#2B0018EF";
    ClearColor = "#4B0029FF";
    WaterfallBackground = "#2B0018FF";
  };

  jsonFile = pkgs.writeJSON "stylix.json" sdrppTheme;

  sdrpp = prev.sdrpp.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      cp ${jsonFile} ${out}/share/sdrpp/themes
    '';
  });

in { home.packages = [ sdrpp ]; }
