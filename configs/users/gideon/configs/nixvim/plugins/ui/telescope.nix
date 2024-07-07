{
    # Main Telescope plugin
    programs.nixvim.plugins.telescope= {
        enable = true;
        extensions = {
            file-browser = {
                enable = true;
                settings  = {
                    add_dirs = false;
                    git_status = true;
                };
            };
            media-files = {
                enable = true;
            };
        };
    };
}
