{ pkgs, lib, config, ... }:

with config.lib.stylix.colors;

{
  xdg.configFile.godot-theme = {
    enable = true;
    target = "godot/text_editor_themes/stylix.tet";
    text = ''
      [color_theme]

      symbol_color="${base0D}ff"
      keyword_color="${base0E}ff"
      control_flow_keyword_color="${base0E}ff"
      base_type_color="${base0A}ff"
      engine_type_color="${base0A}ff"
      user_type_color="${base0A}ff"
      comment_color="6c7086ff"
      string_color="${base0B}ff"
      background_color="${base00}ff"
      completion_background_color="${base01}ff"
      completion_selected_color="${base02}ff"
      completion_existing_color="${base0E}21"
      completion_scroll_color="${base02}ff"
      completion_scroll_hovered_color="${base03}ff"
      completion_font_color="${base05}ff"
      text_color="${base05}ff"
      line_number_color="${base03}ff"
      safe_line_number_color="${base0B}ff"
      caret_color="${base06}ff"
      caret_background_color="${base01}ff"
      text_selected_color="${base05}ff"
      selection_color="${base04}ff"
      brace_mismatch_color="${base08}ff"
      current_line_color="${base05}10"
      line_length_guideline_color="${base02}ff"
      word_highlighted_color="${base04}ff"
      number_color="${base09}ff"
      function_color="${base0D}ff"
      member_variable_color="${base07}ff"
      mark_color="${base08}38"
      bookmark_color="${base0D}ff"
      breakpoint_color="${base08}ff"
      executing_line_color="${base0A}ff"
      code_folding_color="7f849cff"
      search_result_color="${base04}ff"
      search_result_border_color="${base01}00"
      gdscript/function_definition_color="${base0D}ff"
      gdscript/global_function_color="${base08}ff"
      gdscript/node_path_color="${base0C}ff"
      gdscript/node_reference_color="${base0C}ff"
      gdscript/annotation_color="${base09}ff"
      gdscript/string_name_color="${base05}ff"
    '';
  };
}
