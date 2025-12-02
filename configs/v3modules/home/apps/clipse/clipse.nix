{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{

  # Defines the Clipse Theme
  xdg.configFile.clipse-config = {
    enable = true;
    target = "clipse/config.json";
    text = builtins.toJSON {
      allowDuplicates = false;
      historyFile = "clipboard_history.json";
      maxHistory = 100;
      logFile = "clipse.log";
      themeFile = "custom_theme.json";
      tempDir = "tmp_files";
      keyBindings = {
        choose = "enter";
        clearSelected = "S";
        down = "down";
        end = "end";
        filter = "/";
        home = "home";
        more = "?";
        nextPage = "right";
        prevPage = "left";
        preview = " ";
        quit = "q";
        remove = "x";
        selectDown = "ctrl+down";
        selectSingle = "s";
        selectUp = "ctrl+up";
        togglePin = "p";
        togglePinned = "tab";
        up = "up";
        yankFilter = "ctrl+s";
      };
      imageDisplay = {
        # this is really the only thing i'm changing
        type = "kitty";
        scaleX = 9;
        scaleY = 9;
        heightCut = 2;
      };
    };
  };

  # Defines the Clipse Theme
  xdg.configFile.clipse-theme = {
    enable = true;
    target = "clipse/custom_theme.json";
    text = builtins.toJSON {
      useCustomTheme = true;
      TitleFore = "${base0E}";
      TitleBack = "${base00}";
      TitleInfo = "${base0D}";
      NormalTitle = "${base05}";
      DimmedTitle = "${base04}";
      SelectedTitle = "${base08}";
      NormalDesc = "${base04}";
      DimmedDesc = "${base04}";
      SelectedDesc = "${base09}";
      StatusMsg = "${base0B}";
      PinIndicatorColor = "${base0A}";
      SelectedBorder = "${base0D}";
      SelectedDescBorder = "${base0D}";
      FilteredMatch = "${base05}";
      FilterPrompt = "${base0B}";
      FilterInfo = "${base0D}";
      FilterText = "${base05}";
      FilterCursor = "${base09}";
      HelpKey = "${base04}";
      HelpDesc = "${base03}";
      PageActiveDot = "${base0D}";
      PageInactiveDot = "${base04}";
      DividerDot = "${base0D}";
      PreviewedText = "${base05}";
      PreviewBorder = "${base0E}";
    };
  };
}
