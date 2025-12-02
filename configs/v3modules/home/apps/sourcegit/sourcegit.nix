{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  # Defines hackernews_tui theme
  xdg.configFile.sourcegit-theme = {
    enable = true;
    target = "SourceGit/themes/stylix.json";
    text = builtins.toJSON {
	  BasicColors = {
	    Window = "${base00}";
	    WindowBorder = "${base00}";
	    TitleBar = "${base02}";
	    ToolBar = "${base00}";
	    Popup = "${base00}";
	    Contents = "${base00}";
	    Badge = "${base03}";
	    BadgeFG = "${base06}";
	    Conflict = "${base08}";
	    ConflictForeground = "${base00}";
	    Border0 = "${base01}";
	    Border1 = "${base01}";
	    Border2 = "${base01}";
	    "FlatButton.Background" = "${base00}";
	    "FlatButton.BackgroundHovered" = "${base01}";
	    FG1 = "${base05}";
	    FG2 = "${base04}";
	    "Diff.EmptyBG" = "${base01}";
	    "Diff.AddedBG" = "${base0B}";
	    "Diff.DeletedBG" = "${base08}";
	    "Diff.AddedHighlight" = "${base0B}";
	    "Diff.DeletedHighlight" = "${base08}";
	    SystemAccentColor = "${base0E}";
	    Link = "${base0D}";
	  };
	  OpacityForNotMergedCommits = 0.4;
	  GraphColors = [
	    "${base08}"
	    "${base09}"
	    "${base0A}"
	    "${base06}"
	    "${base07}"
	    "${base0E}"
	  ];

	};

  };
}
