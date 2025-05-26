{
  # Main Telescope plugin
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      file-browser = {
        enable = false; # try disabling to speedup startup
        settings = {
          add_dirs = false;
          git_status = true;
        };
      };
      media-files = {
        #INFO: this kills startuptime
        enable = false;
      };
    };
  };
}
