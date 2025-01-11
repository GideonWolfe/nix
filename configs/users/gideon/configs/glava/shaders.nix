{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  # Circle Visualizer
  xdg.configFile.glava-circle = {
    enable = true;
    target = "glava/circle.glsl";
    text = ''
      /* center radius (pixels) */
      #define C_RADIUS 150
      /* center line thickness (pixels) */
      #define C_LINE 1.5
      /* outline color */
      #define OUTLINE ${base09}
      /* Amplify magnitude of the results each bar displays */
      #define AMPLIFY 180
      /* Angle (in radians) for how much to rotate the visualizer */
      #define ROTATE (PI / 2)
      /* Whether to switch left/right audio buffers */
      #define INVERT 0
      /* Whether to fill in the space between the line and inner circle */
      #define C_FILL 0
      /* Whether to apply a post-processing image smoothing effect
         1 to enable, 0 to disable. Only works with `xroot` transparency,
         and improves performance if disabled. */
      #define C_SMOOTH 1

      /* Gravity step, overrude frin `smooth_parameters.glsl` */
      #request setgravitystep 6.0

      /* Smoothing factor, override from `smooth_parameters.glsl` */
      #request setsmoothfactor 0.01
    '';
  };
  # Bars Visualizer
  xdg.configFile.glava-bars = {
    enable = true;
    target = "glava/bars.glsl";
    text = ''
      /* Center line thickness (pixels) */
      #define C_LINE 1
      /* Width (in pixels) of each bar */
      #define BAR_WIDTH 4
      /* Width (in pixels) of each bar gap */
      #define BAR_GAP 2
      /* Outline color */
      #define BAR_OUTLINE ${base05}
      /* Outline width (in pixels, set to 0 to disable outline drawing) */
      #define BAR_OUTLINE_WIDTH 0
      /* Amplify magnitude of the results each bar displays */
      #define AMPLIFY 300
      /* Whether the current settings use the alpha channel;
         enabling this is required for alpha to function
         correctly on X11 with `"native"` transparency. */
      #define USE_ALPHA 0
      /* How strong the gradient changes */
      #define GRADIENT_POWER 60
      /* Bar color changes with height */
      #define GRADIENT (d / GRADIENT_POWER + 1)
      /* Bar color */
      #define COLOR (${base0E} * GRADIENT)
      /* Direction that the bars are facing, 0 for inward, 1 for outward */
      #define DIRECTION 0
      /* Whether to switch left/right audio buffers */
      #define INVERT 0
      /* Whether to flip the output vertically */
      #define FLIP 0
      /* Whether to mirror output along `Y = X`, causing output to render on the left side of the window */
      /* Use with `FLIP 1` to render on the right side */
      #define MIRROR_YX 0
    '';
  };

  # Radial Visualizer
  xdg.configFile.glava-radial = {
    enable = true;
    target = "glava/radial.glsl";
    text = ''

      /* center radius (pixels) */
      #define C_RADIUS 128
      /* center line thickness (pixels) */
      #define C_LINE 2
      /* outline color */
      #define OUTLINE ${base0F}
      /* number of bars (use even values for best results) */
      #define NBARS 180
      /* width (in pixels) of each bar*/
      #define BAR_WIDTH 3.5
      /* outline color */
      #define BAR_OUTLINE OUTLINE
      /* outline width (in pixels, set to 0 to disable outline drawing) */
      #define BAR_OUTLINE_WIDTH 0
      /* Amplify magnitude of the results each bar displays */
      #define AMPLIFY 300
      /* Bar color */ 
      #define COLOR (${base08} * ((d / 40) + 1))
      /* Angle (in radians) for how much to rotate the visualizer */
      #define ROTATE (PI / 2)
      /* Whether to switch left/right audio buffers */
      #define INVERT 0
      /* Aliasing factors. Higher values mean more defined and jagged lines.
         Note: aliasing does not have a notable impact on performance, but requires
         `xroot` transparency to be enabled since it relies on alpha blending with
         the background. */
      #define BAR_ALIAS_FACTOR 1.2
      #define C_ALIAS_FACTOR 1.8
      /* Offset (Y) of the visualization */
      #define CENTER_OFFSET_Y 0
      /* Offset (X) of the visualization */
      #define CENTER_OFFSET_X 0

      /* Gravity step, override from `smooth_parameters.glsl` */
      #request setgravitystep 5.0

      /* Smoothing factor, override from `smooth_parameters.glsl` */
      #request setsmoothfactor 0.02
    '';
  };

  # Graph Visualizer
  xdg.configFile.glava-graph = {
    enable = true;
    target = "glava/graph.glsl";
    text = ''


      /* Vertical scale, larger values will amplify output */
      #define VSCALE 300
      /* Rendering direction, either -1 (outwards) or 1 (inwards). */
      #define DIRECTION 1

      /* Color gradient scale, (optionally) used in `COLOR` macro */
      #define GRADIENT_SCALE 75
      /* Color definition. By default this is a gradient formed by mixing two colors.
         `pos` represents the pixel position relative to the visualizer baseline. */
      #define COLOR mix(${base0E}, ${base0C}, clamp(pos / GRADIENT_SCALE, 0, 1))
      /* 1 to draw outline, 0 to disable */
      #define DRAW_OUTLINE 0
      /* 1 to draw edge highlight, 0 to disable */
      #define DRAW_HIGHLIGHT 1
      /* Whether to anti-alias the border of the graph, creating a smoother curve.
         This may have a small impact on performance.
         Note: requires `xroot` or `none` opacity to be set */
      #define ANTI_ALIAS 0
      /* outline color */
      #define OUTLINE ${base05}
      /* 1 to join the two channels together in the middle, 0 to clamp both down to zero */
      #define JOIN_CHANNELS 0
      /* 1 to invert (vertically), 0 otherwise */
      #define INVERT 0

      /* Gravity step, overrude from `smooth_parameters.glsl` */
      #request setgravitystep 2.4

      /* Smoothing factor, override from `smooth_parameters.glsl` */
      #request setsmoothfactor 0.015
    '';
  };
}
