{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.xyosc = {

    enable = true;
    target = "ontake/xyosc/config.yml";
    text = pkgs.lib.generators.toYAML { } {
      disabletransparency = true;
      bgcolor = "${base00}";
      fpscounter = false;
      showfilterinfo = true;
      showmpris = false;
      mpristextopacity = 255;
      targetfps = 120;
      windowwidth = 1000;
      windowheight = 1000;
      capturedeviceindex = 1;
      samplerate = 192000;
      ringbuffersize = 4096;
      readbuffersize = 4096;
      gain = 1;
      lineopacity = 200;
      linebrightness = 1;
      linethickness = 3;
      lineinvsqrtopacitycontrol = false;
      particles = true;
      particlegenperframeeveryxsamples = 4000;
      particlemaxcount = 100;
      particleminsize = 1.0;
      particlemaxsize = 3.0;
      particleacceleration = 0.2;
      particledrag = 5.0;
      defaulttosinglechannel = true;
      peakdetectseparator = 200;
      singlechannelwindow = 1200;
      periodcrop = true;
      periodcropcount = 2;
      periodcroploopovercount = 1;
      fftbufferoffset = 2000;
      forcecolors = false;
      accentcolor = "${base0D}";
      firstcolor = "${base0E}";
      thirdcolor = "${base0B}";
      particlecolor = "${base0E}";
      copypreviousframe = true;
      copypreviousframealpha = 0.1;
    };
  };
}
