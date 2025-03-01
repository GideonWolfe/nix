{
  programs.nixvim.plugins.dashboard = {
      
    #TODO: testing dashboard from snacks.nvim
    enable = false;



    settings = {

        theme = "hyper";
        
        change_to_vcs_root = true;

        config = {

            # Most recently used
            mru = {
                icon_hl = "RainbowDelimiterBlue";
            };

            # TODO: i don't think this works with nix right
            packages.enable = false;

            project = {
                enable = true;
                icon = "";
            };

            header = [
                "⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⢀⣠⣾⣷⣿⣿⣿⣶⣤⣿⣠⣶⡶⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⠀⠀⠀⢀⣤⡶⣿⢺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣂⡶⣶⡐⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⠀⢀⣀⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣽⣿⣿⣿⣿⣿⣿⣇⣤⣄⠀⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⣰⣶⣿⣏⢿⡿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⢿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⠀⠀⠀⠀⠀"
                "⠀⠀⠀⣰⣿⣯⠉⠉⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣾⣷⣾⣿⣿⣿⣿⣽⣿⡇⠀⠀⠉⠉⣹⣧⡀⠀⠀⠀"
                "⠀⠀⢀⣍⣿⡁⢀⡀⠀⠀⣿⠏⠀⠀⠉⠁⠀⠙⣿⣧⡋⡀⠀⠀⠀⠀⢉⣿⡀⠀⢀⠀⢹⣧⣅⠀⠀⠀"
                "⢠⡄⠘⠻⢿⣷⣶⣤⣴⣿⣿⡀⣀⢠⣀⠀⣀⣬⣡⣄⡬⣀⢀⡀⠀⠀⢀⣿⢿⣦⣼⣶⣿⡿⠞⠀⣀⠀"
                "⢸⡇⠀⣠⣼⣿⡟⠉⠛⣿⣾⣿⣮⣯⣥⡶⢿⣯⢛⡟⣴⡿⢶⣥⣤⣶⣿⣵⣿⠛⠛⠿⢿⣤⡀⠂⣉⠀"
                "⠀⠁⣼⢟⡿⠋⠀⠀⠀⣠⣤⠀⠀⠀⠙⠛⢢⣧⠊⠉⣜⡔⠛⠃⠀⠀⠠⣤⡀⠀⠀⠀⠻⣿⠹⡆⠃⠀"
                "⠀⠀⠈⡜⣧⠠⠤⢀⡴⣻⠄⢀⠠⡀⢀⣠⣷⠋⠀⠀⠘⢶⣄⡀⡄⠀⠀⢠⡝⣄⠀⡤⢀⡼⠀⠀⠀⠀"
                "⠀⠀⢀⣿⣿⣿⣿⣿⣷⣿⣷⣼⣠⣜⣿⣾⠁⠀⠀⠀⠀⠀⣿⣯⣓⣛⣁⣼⣿⣾⣿⣿⣿⣤⣧⠀⠀⠀"
                "⠀⢀⠘⡿⣿⣿⢿⣾⣿⣿⣏⠙⠻⣿⣿⣯⣀⢀⣠⢄⡀⢂⣿⣿⡿⠋⠉⢙⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀"
                "⠀⠀⠀⠀⠈⢁⠈⠙⠉⠉⠉⢹⡆⡾⢸⣿⣿⠿⣿⣿⣿⣯⣍⠀⣡⢰⡏⠉⠉⠛⠉⠀⠉⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⠀⠘⣄⠀⠀⠀⠀⡾⡰⣿⣿⢿⡿⣦⣿⣽⢿⢻⡟⢳⣽⣎⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⠀⠀⠈⠀⣸⡆⠀⠀⠉⢠⣦⣾⣀⣾⡇⠑⠀⠀⣤⡀⠉⣾⠀⠀⣸⡀⠀⠀⠀⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⠀⠀⠀⠂⢸⣇⠀⠈⠲⠸⠏⣛⣫⣙⣃⣀⣀⣴⠋⣥⡔⠞⠁⠀⣿⠇⢪⠀⠀⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⠀⠀⠀⢃⠘⠿⣴⠄⣤⡀⢃⠉⡝⣈⠛⠻⣉⢋⠀⣁⣰⢤⢰⣶⠟⠀⡏⠀⠀⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⠀⠀⠀⠘⠆⠀⢹⣦⢠⡇⠙⣹⣧⡻⢼⠧⠟⣼⡿⠉⢹⢈⣼⡇⠀⠂⠁⠀⠀⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠳⣷⣷⣁⣺⣿⣿⣿⣤⣌⣻⣆⣾⡯⠿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠛⠿⠿⠛⠛⠻⠿⠿⠟⠃⠀⠀⠀⠀          "
            ];

            footer = [
                "you can't kill me in any way that matters"
            ];
        };
    };
  };
}
