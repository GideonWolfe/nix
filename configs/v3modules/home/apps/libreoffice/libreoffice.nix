{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.libreoffice-theme = {
    enable = true;
    target = "libreoffice/4/user/config/stylix.soc";
    #BUG: theme not picked up by libreoffice
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <office:color-table xmlns:office="http://openoffice.org/2000/office" xmlns:style="http://openoffice.org/2000/style" xmlns:text="http://openoffice.org/2000/text" xmlns:table="http://openoffice.org/2000/table" xmlns:draw="http://openoffice.org/2000/drawing" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="http://openoffice.org/2000/meta" xmlns:number="http://openoffice.org/2000/datastyle" xmlns:svg="http://www.w3.org/2000/svg" xmlns:chart="http://openoffice.org/2000/chart" xmlns:dr3d="http://openoffice.org/2000/dr3d" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="http://openoffice.org/2000/form" xmlns:script="http://openoffice.org/2000/script">

      <draw:color draw:name="Background"    draw:color="${base00}"/>
      <draw:color draw:name="Current Line"  draw:color="${base0E}"/>
      <draw:color draw:name="Comment"       draw:color="${base02}"/>
      <draw:color draw:name="Foreground"    draw:color="${base0A}"/>
      <draw:color draw:name="Green"         draw:color="${base0B}"/>
      <draw:color draw:name="Cyan"          draw:color="${base0C}"/>
      <draw:color draw:name="Purple"        draw:color="${base0E}"/>
      <draw:color draw:name="Pink"          draw:color="${base06}"/>
      <draw:color draw:name="Red"           draw:color="${base08}"/>
      <draw:color draw:name="Orange"        draw:color="${base09}"/>
      <draw:color draw:name="Yellow "       draw:color="${base0A}"/>

      </office:color-table>
    '';
  };
}
