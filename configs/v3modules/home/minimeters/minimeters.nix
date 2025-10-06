{ lib, config, pkgs, ... }:

with config.lib.stylix.colors;

{

  home.file = let
    base0 = "${base00-rgb-r},${base00-rgb-g},${base00-rgb-b})";
    base1 = "${base01-rgb-r},${base01-rgb-g},${base01-rgb-b})";
    base2 = "${base02-rgb-r},${base02-rgb-g},${base02-rgb-b})";
    base3 = "${base03-rgb-r},${base03-rgb-g},${base03-rgb-b})";
    base4 = "${base04-rgb-r},${base04-rgb-g},${base04-rgb-b})";
    base5 = "${base05-rgb-r},${base05-rgb-g},${base05-rgb-b})";
    base6 = "${base06-rgb-r},${base06-rgb-g},${base06-rgb-b})";
    base7 = "${base07-rgb-r},${base07-rgb-g},${base07-rgb-b})";
    base8 = "${base08-rgb-r},${base08-rgb-g},${base08-rgb-b})";
    base9 = "${base09-rgb-r},${base09-rgb-g},${base09-rgb-b})";
    baseA = "${base0A-rgb-r},${base0A-rgb-g},${base0A-rgb-b})";
    baseB = "${base0B-rgb-r},${base0B-rgb-g},${base0B-rgb-b})";
    baseC = "${base0C-rgb-r},${base0C-rgb-g},${base0C-rgb-b})";
    baseD = "${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b})";
    baseE = "${base0E-rgb-r},${base0E-rgb-g},${base0E-rgb-b})";
    baseF = "${base0F-rgb-r},${base0F-rgb-g},${base0F-rgb-b})";
  in {

    # Creating the theme file for MiniMeters
    ".MiniMeters/themes/stylix.txt" = {

      text = ''
        color: ${baseD}
        selection: ${baseD}
        text: ${base5}
        accent: ${baseE}
        bg: ${base0}
        bgaccent: ${base1}

        ## Optional Colors:
        ## Omitting these colors defaults them to the values above.

        waveform: ${base9}
        rgb_waveform_opacity_with_history:170
        history_low: ${base8},255
        history_mid: ${baseB},255
        history_high: ${baseD},255

        ## the RGB Mode in the Waveform has a low (0-200hz) band, a mid (200-2000hz) band, and a high (2000-22050hz) band.
        waveform_low: ${base8}
        waveform_mid: ${baseB}
        waveform_high: ${baseD}

        oscilloscope_main: ${base9}
        oscilloscope_bg: ${base0}

        stereometer: ${base9}
        stereometer_low: ${base8}
        stereometer_mid: ${baseB}
        stereometer_high: ${baseD}

        # spectrum_analyzer_main: 255,127,255
        # spectrum_analyzer_secondary: 127,255,127
        # spectrum_analyzer_frequency_lines: 127,255,127
        # spectrum_analyzer_reference_line: 127,255,127
        # spectrum_analyzer_threshold_line: 255,255,0

        ## Spectrogram and Color Bars (Spectrum Analyzer) both have a low volume and high volume value. The colors are chosen in a clockwise direction around the HSB/HSV color wheel.
        ## Note: This loops around the color wheel. Any value you put here will be (I % 360). This will be replaced in a future version.

        # spectrogram_low: 260
        # spectrogram_high: 420
        # color_bars_low: 186
        # color_bars_high: 385
        # color_bars_opacity: 255

        ## If spectrogram_main or color_bars_main is given a color value the spectrogram becomes monotone and the hue values are ignored.
        # spectrogram_main: 255,255,255
        # color_bars_main: 255,255,255

        ## Set the color of the RMS meter
        loudness_main: ${base5}
        loudness_text: ${base0}

        ## This shows up when connecting to an audio device fails.
        error_bar: ${base8}

        ## These are the values for the Loudness Meter (currently named Peak/LUFS)
        loudness_main: ${baseA}
        loudness_text: ${base0}

      '';
    };

  };

}
