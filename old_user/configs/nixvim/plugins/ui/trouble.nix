{
  programs.nixvim.plugins.trouble = {
    enable = true;
    settings = {
        icons = true;
        indent_lines = true;
        use_diagnostic_signs = true;
    };
  };
}
