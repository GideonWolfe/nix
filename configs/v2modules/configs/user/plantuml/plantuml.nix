{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.plantuml = {

    enable = true;
    #onChange = manually tell darkreader to refresh somehow?
    target = "plantuml/puml-theme-stylix.puml";
    text = ''
      !$THEME = "stylix"
      !if %not(%variable_exists("$BGCOLOR"))
      !$BGCOLOR = "transparent"
      !endif

      skinparam backgroundColor $BGCOLOR

      !$BLUE = "${base0D}"
      !$INDIGO = "${base0D}"
      !$PURPLE = "${base0E}"
      !$PINK = "${base0E}"
      !$RED = "${base08}"
      !$ORANGE = "${base09}"
      !$YELLOW = "${base0A}"
      !$GREEN = "${base0B}"
      !$TEAL = "${base0B}"
      !$CYAN = "${base0C}"
      !$WHITE = "${base05}"
      !$GRAY_DARK = "${base01}"
      !$GRAY = "${base04}"
      !$PRIMARY = "${base05}"
      !$SECONDARY = "${base04}"
      !$SUCCESS = "${base0B}"
      !$INFO = "${base0D}"
      !$WARNING = "${base09}"
      !$DANGER = "${base08}"
      !$LIGHT = "${base04}"
      !$DARK = "${base01}"

      !$FGCOLOR = $DARK
      !$PRIMARY_LIGHT = "${base05}"
      !$PRIMARY_DARK = "${base01}"
      !$PRIMARY_TEXT = "${base05}"
      !$SECONDARY_LIGHT = "${base0A}"
      !$SECONDARY_DARK = "${base0A}"
      !$SECONDARY_TEXT = $DARK
      !$INFO_LIGHT = "${base0D}"
      !$INFO_DARK = "${base0D}"
      !$INFO_TEXT = $WHITE
      !$SUCCESS_LIGHT = $SUCCESS
      !$SUCCESS_DARK = $SUCCESS
      !$SUCCESS_TEXT = $SUCCESS
      !$WARNING_LIGHT = "${base09}"
      !$WARNING_DARK = $WARNING_LIGHT
      !$WARNING_TEXT = $WHITE
      !$DANGER_LIGHT = "${base08}"
      !$DANGER_DARK = $DANGER_LIGHT
      !$DANGER_TEXT = $WHITE

      !procedure $success($msg)
        <font color=$SUCCESS><b>$msg
      !endprocedure

      !procedure $failure($msg)
        <font color=$DANGER><b>$msg
      !endprocedure

      !procedure $warning($msg)
        <font color=$WARNING><b>$msg
      !endprocedure

      !procedure $primary_scheme()
      	FontColor $PRIMARY_TEXT
      	BorderColor $PRIMARY
      	BackgroundColor transparent
      !endprocedure

      skinparam defaultFontName        "Verdana"
      skinparam defaultFontSize        12
      skinparam dpi                    100
      skinparam shadowing              false
      skinparam roundcorner            0
      skinparam ParticipantPadding     40
      skinparam BoxPadding             40
      skinparam Padding                5
      skinparam stereotype {

          CBackgroundColor $LIGHT
          CBorderColor $SECONDARY_DARK
          ABackgroundColor $GREEN
          ABorderColor $SUCCESS_DARK
          IBackgroundColor $CYAN
          IBorderColor $DANGER_DARK
          EBackgroundColor $TEAL
          EBorderColor $WARNING_DARK
          NBackgroundColor transparent
          NBorderColor $INFO_DARK
      }
      skinparam title {
      	FontColor	                 $CYAN
      	BorderColor	                 $BLUE
      	FontSize	    	         20
      	BorderRoundCorner            0
      	BorderThickness 	         0
      	BackgroundColor            $BGCOLOR
      }


      skinparam legend {
      	BackgroundColor transparent
      	BorderColor $SECONDARY_DARK
        FontColor $PRIMARY_TEXT
      }

      !startsub swimlane
      skinparam swimlane {
      	BorderColor $INFO
      	BorderThickness 2
      	TitleBackgroundColor  $SECONDARY_LIGHT-$SECONDARY
      	TitleFontColor $PRIMARY
      }
      !endsub

      !startsub activity

      skinparam activity {
      	$primary_scheme()
      	BarColor $SUCCESS
      	StartColor $INFO
      	EndColor $INFO
      	DiamondBackgroundColor $BGCOLOR
        	DiamondBorderColor $SECONDARY_DARK
      	DiamondFontColor $SECONDARY_TEXT
      }
      !endsub

      !startsub participant

      skinparam participant {
      	$primary_scheme()
        Color $GREEN
      	ParticipantBorderThickness 2
      }
      !endsub

      !startsub actor

      skinparam actor {
      	$primary_scheme()
      	BorderColor $PINK
      	FontColor $BLUE
      }
      !endsub

      !startsub arrow

      skinparam arrow {
      	Thickness 3
      	Color $INDIGO
      	FontColor $PRIMARY
        LollipopColor $GREEN
      }
      !endsub

      !startsub sequence

      skinparam sequence {
      	BorderColor $PRIMARY
      	TitleFontColor $PRIMARY
      	BackgroundColor $BGCOLOR
      	StartColor $BLUE
      	EndColor $GREEN
      	BoxBackgroundColor $BGCOLOR
      	BoxBorderColor $PURPLE
      	BoxFontColor $DARK
      	LifeLineBorderColor $SECONDARY_DARK
      	LifeLineBorderThickness 2
      	LifeLineBackgroundColor $YELLOW
      	GroupBorderColor $PURPLE
      	GroupFontColor $PRIMARY
      	GroupHeaderFontColor $PRIMARY
        GroupBackgroundColor $BGCOLOR
        GroupBodyBackgroundColor $BGCOLOR
      	DividerBackgroundColor $BLUE
          DividerFontColor ${base00}
          DividerBorderColor $GRAY
          DividerBorderThickness 2
      	ReferenceBackgroundColor $BGCOLOR
      	ReferenceBorderColor $BLUE
      	ReferenceFontColor $PRIMARY
      	ReferenceHeaderFontColor $INFO
      }
      !endsub

      !startsub partition

      skinparam partition {
      	BorderColor $PRIMARY
      	FontColor $PRIMARY
      	BackgroundColor $BGCOLOR
      }
      !endsub

      !startsub collections

      skinparam collections {
      	$primary_scheme()
        BorderColor $INDIGO
      }
      !endsub

      !startsub control

      skinparam control {
      	$primary_scheme()
      	FontColor $DARK
      }
      !endsub

      !startsub entity

      skinparam entity {
      	$primary_scheme()
      	FontColor $DARK
      }
      !endsub

      !startsub boundary

      skinparam boundary {
      	$primary_scheme()
      	FontColor $DARK
      }
      !endsub

      !startsub agent

      skinparam agent {
      	BackgroundColor $BGCOLOR
      	BorderColor $BLUE
      	FontColor $PRIMARY
      }
      !endsub

      !startsub note

      skinparam note {
      	BorderThickness 1
      	BackgroundColor $BGCOLOR
      	BorderColor $INDIGO
      	FontColor $PRIMARY
      }
      !endsub

      !startsub artifact

      skinparam artifact {
      	BackgroundColor $BGCOLOR
      	BorderColor $SECONDARY_DARK
      	FontColor $SECONDARY_TEXT
      }
      !endsub

      !startsub component

      skinparam component {
      	$primary_scheme()
        FontColor $PRIMARY_LIGHT
        BorderColor $YELLOW
      }
      !endsub

      !startsub interface

      skinparam interface {
      	BackgroundColor  $DANGER_LIGHT
      	BorderColor  $DANGER
      	FontColor $DARK
      }
      !endsub

      !startsub storage

      skinparam storage {
      	BackgroundColor $BGCOLOR
        	BorderColor $WARNING
      	FontColor $WARNING_TEXT
      }
      !endsub

      !startsub node

      skinparam node {
      	BackgroundColor $BGCOLOR
      	BorderColor $CYAN
      	FontColor $PRIMARY
      }
      !endsub

      !startsub cloud

      skinparam cloud {
      	BackgroundColor $BGCOLOR
      	BorderColor $PURPLE
      	FontColor $PRIMARY
      }
      !endsub

      !startsub database

      skinparam database {
      	$primary_scheme()
      	FontColor $PRIMARY
      }
      !endsub

      !startsub class

      skinparam class {
      	$primary_scheme()
      	HeaderBackgroundColor $BGCOLOR
      	StereotypeFontColor $RED
      	BorderThickness 1
      	AttributeFontColor $LIGHT
      	AttributeFontSize 11
      }
      !endsub

      !startsub object

      skinparam object {
      	$primary_scheme()
      	StereotypeFontColor $DARK
      	BorderThickness 1
      	AttributeFontColor $SECONDARY_TEXT
      	AttributeFontSize 11
      }
      !endsub

      !startsub usecase

      skinparam usecase {
      	$primary_scheme()
      	BorderThickness 2
      	BorderColor $BLUE
      	FontColor $TEAL
      	StereotypeFontColor $PRIMARY
      }
      !endsub

      !startsub rectangle

      skinparam rectangle {
      	FontColor $PRIMARY
      	BorderColor $PRIMARY_LIGHT
      	BackgroundColor $BGCOLOR
      	BorderThickness 2
      	StereotypeFontColor $PRIMARY
      }
      !endsub

      !startsub package

      skinparam package {
      	FontColor $PRIMARY
      	BorderColor $PURPLE
      	BackgroundColor $BGCOLOR
      	BorderThickness 2
      }
      !endsub

      !startsub folder

      skinparam folder {
      	BackgroundColor $BGCOLOR
        	BorderColor $WARNING
      	FontColor $PRIMARY
      	BorderThickness 2
      }
      !endsub

      !startsub frame

      skinparam frame {
      	BackgroundColor $BGCOLOR
        	BorderColor $INFO
      	FontColor $INFO
      	BorderThickness 2
      }
      !endsub

      !startsub state

      skinparam state {
      	$primary_scheme()
      	StartColor $INFO
      	EndColor $INFO
      	AttributeFontColor $SECONDARY_TEXT
      	AttributeFontSize 11
      }
      !endsub

      !startsub queue

      skinparam queue {
      	$primary_scheme()
      }
      !endsub

      !startsub card

      skinparam card {
      	BackgroundColor $INFO_LIGHT-$INFO
      	BorderColor $INFO
      	FontColor $INFO_TEXT
      }
      !endsub

      !startsub file

      skinparam file {
      	BackgroundColor $SECONDARY_LIGHT-$SECONDARY
      	BorderColor $INFO
      	FontColor $GRAY

      }
      !endsub

      !startsub stack

      skinparam stack {
      	$primary_scheme()
      }
      !endsub

    '';
  };
}
