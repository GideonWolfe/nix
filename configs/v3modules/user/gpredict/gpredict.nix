{ pkgs, lib, config, ... }:

with config.lib.stylix.colors;

let
  #HACK: cursed function to convert hex into decimal colors gpredict uses in the config file
  inherit (pkgs.lib) toUpper stringToCharacters fromHexString;

  # Function to check if the hex value represents a negative signed 32-bit int
  isNegative = hex:
    let
      prefix = builtins.elemAt (stringToCharacters (toUpper hex)) 0;
      negativePrefix = [ "8" "9" "A" "B" "C" "D" "E" "F" ];
    in builtins.elem prefix negativePrefix;

  u32Max = 4294967295;

  # Ensure it's a 32-bit hex string
  is32Bit = hex: builtins.length (stringToCharacters hex) == 8;

  # The conversion function
  conversionFunc = hex:
    assert is32Bit hex;
    if isNegative hex then
      (fromHexString hex) - (u32Max + 1)
    else
      fromHexString hex;

in {
  # Example usage:
  xdg.configFile."Gpredict/gpredict.cfg".force = true; #TEST: try and force replacing the config file
  xdg.configFile."Gpredict/gpredict.cfg".text = ''

    [MODULES]
    GRID=1;0;3;0;3;0;0;3;3;4;2;3;4;0;2;4;3;4;2;3;3;3;4;3;4
    POLAR_CHART_ORIENT=0
    POLAR_QTH_INFO=true
    POLAR_NEXT_EVENT=true
    POLAR_CURSOR_TRACK=true
    POLAR_EXTRA_AZ_TICKS=true
    POLAR_BGD_COLOUR=${
      toString
      (conversionFunc "${base00-hex-r}${base00-hex-g}${base00-hex-b}FF")
    }
    POLAR_AXIS_COLOUR=${
      toString
      (conversionFunc "${base09-hex-r}${base09-hex-g}${base09-hex-b}FF")
    }
    POLAR_TICK_COLOUR=${
      toString
      (conversionFunc "${base0A-hex-r}${base0A-hex-g}${base0A-hex-b}FF")
    }
    POLAR_SAT_COLOUR=${
      toString
      (conversionFunc "${base08-hex-r}${base08-hex-g}${base08-hex-b}FF")
    }
    POLAR_SELECTED_SAT_COL=${
      toString
      (conversionFunc "${base0D-hex-r}${base0D-hex-g}${base0D-hex-b}FF")
    }
    POLAR_INFO_COLOUR=${
      toString
      (conversionFunc "${base08-hex-r}${base08-hex-g}${base08-hex-b}FF")
    }
    POLAR_TRACK_COLOUR=${
      toString
      (conversionFunc "${base0A-hex-r}${base0A-hex-g}${base0A-hex-b}FF")
    }
    POLAR_SHOW_TRACK_AUTO=true

    MAP_FILE=${config.home.homeDirectory}/.config/Gpredict/custom_map.jpg
    MAP_QTH_INFO=true
    MAP_NEXT_EVENT=true
    MAP_CURSOR_TRACK=true
    MAP_SHOW_GRID=true
    MAP_SHOW_TERMINATOR=true
    MAP_QTH_COLOUR=${
      toString
      (conversionFunc "${base09-hex-r}${base09-hex-g}${base09-hex-b}FF")
    }
    MAP_GRID_COLOUR=${
      toString
      (conversionFunc "${base09-hex-r}${base09-hex-g}${base09-hex-b}44")
    }
    MAP_TICK_COLOUR=${
      toString
      (conversionFunc "${base0A-hex-r}${base0A-hex-g}${base0A-hex-b}FF")
    }
    MAP_SAT_COLOUR=${
      toString
      (conversionFunc "${base0B-hex-r}${base0B-hex-g}${base0B-hex-b}FF")
    }
    MAP_SELECTED_SAT_COLOUR=${
      toString
      (conversionFunc "${base08-hex-r}${base08-hex-g}${base08-hex-b}FF")
    }
    MAP_TRACK_COLOUR=${
      toString
      (conversionFunc "${base0A-hex-r}${base0A-hex-g}${base0A-hex-b}FF")
    }
    MAP_COV_AREA_COLOUR=${
      toString
      (conversionFunc "${base0D-hex-r}${base0D-hex-g}${base0D-hex-b}22")
    }
    MAP_INFO_COLOUR=${
      toString
      (conversionFunc "${base08-hex-r}${base08-hex-g}${base08-hex-b}FF")
    }
    MAP_INFO_BGD_COLOUR=${
      toString
      (conversionFunc "${base01-hex-r}${base01-hex-g}${base01-hex-b}FF")
    }
    MAP_TERMINATOR_COLOUR=${
      toString
      (conversionFunc "${base0A-hex-r}${base0A-hex-g}${base0A-hex-b}55")
    }
    MAP_EARTH_SHADOW_COLOUR=${
      toString
      (conversionFunc "${base01-hex-r}${base01-hex-g}${base01-hex-b}55")
    }
    MAP_SHADOW_ALPHA=221
    MAP_TRACK_NUM=3
    MAP_CENTER=0


    [GLOBAL]
    DEFAULT_QTH=NYC.qth

    [TLE]
    AUTO_UPDATE_ACTION=2
  '';

  xdg.configFile."Gpredict/NYC.qth".text = ''
    [QTH]
    LOCATION=NEW YORK CITY CENTRAL PARK, New York
    LAT=40.78260
    LON=-73.9668
    ALT=47
    WX=KNYC
    QTH_TYPE=0
    GPSDPORT=0
  '';

  home.activation.createGPredictMap =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.imagemagick}/bin/magick ${config.home.homeDirectory}/nix/configs/modules/configs/user/gpredict/nasa-topo_2048.jpg \
                     -alpha off \
                     -fuzz 10% \
                     -fill black -opaque '#2B2C4B' \
                     -fill blue +opaque black \
                     -edge 1 \
                     ${config.home.homeDirectory}/.config/Gpredict/custom_map.jpg

      ${pkgs.imagemagick}/bin/magick ${config.home.homeDirectory}/.config/Gpredict/custom_map.jpg \
                     -fuzz 10% \
                     -fill '#${base00-hex-r}${base00-hex-g}${base00-hex-b}' -opaque black \
                     -fill '#${base0E-hex-r}${base0E-hex-g}${base0E-hex-b}' -opaque blue \
                     ${config.home.homeDirectory}/.config/Gpredict/custom_map.jpg
    '';
}
