{ pkgs, lib, config, ... }:

{

  programs.git = {

    # Allow HM to configure git
    enable = true;

    userName = "Gideon Wolfe";
    userEmail = "wolfegideon@gmail.com";

    # https://github.com/github/gitignore
    #ignores = {}
    delta = {
      enable = true;
      # https://dandavison.github.io/delta/choosing-colors-styles.html
      options = { theme = "base16-stylix"; };
    };

    extraConfig = { push = { autoSetupRemote = true; }; };

    hooks = {
      #TODO this should point to another dir
      #post-commit = $HOME/nix/user/scripts/git/post-commit-hook.sh
      #post-commit = home/gideon/nix/user/scripts/git/post-commit-hook.sh;
      #post-commit = ./post-commit-hook.sh;
      post-commit =
        "${config.home.homeDirectory}/nix/configs/users/gideon/scripts/git/post-commit-hook.sh";

    };
  };
}
