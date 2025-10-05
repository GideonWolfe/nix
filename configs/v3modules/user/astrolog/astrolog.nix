{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.astrolog-config = {
    enable = true;
    target = "astrolog/astrolog.as";
    text = ''
      @AD750  ; Astrolog Config
      -YXK Orange ${base09}
      -YXK Red ${base08}
      -YXK Blue ${base0D}
      -YXK DkBlue ${base0D}
      -YXK Yellow ${base0A}
      -YXK Green ${base0B}
      -YXK DkGreen ${base0B}
      -YXK Magenta ${base0F}
      -YXK Purple ${base0E}
      -YXK Maroon ${base0E}
      -YXK Cyan ${base0C}
      -YXK DkCyan ${base0C}
      -YXK Black ${base01}
      -YXK White ${base05}
      -YXK Gray ${base03}
      -YXK LtGray ${base04}
    '';
  };

}
