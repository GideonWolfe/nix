{ config, ... }: {
  programs.nixvim.plugins.markdown-preview = {
    enable = true;
    settings = {
      markdown_css =
        "${config.home.homeDirectory}/.config/markdown-preview/style.css";
      preview_options = { uml = [ "'server': 'http://localhost:4928'" ]; };
    };
  };
}
