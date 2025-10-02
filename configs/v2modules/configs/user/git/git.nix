{ pkgs, lib, config, ... }:

{

  programs.git = {

    # Allow HM to configure git
    enable = true;

    # userName = "Gideon Wolfe";
    # userEmail = "wolfegideon@gmail.com";

    # https://github.com/github/gitignore
    #ignores = {}
    delta = {
      enable = true;
      # https://dandavison.github.io/delta/choosing-colors-styles.html
      options = { theme = "base16-stylix"; };
    };

    extraConfig = {
      push = { autoSetupRemote = true; };
      merge = { tool = "nvim"; };
      mergetool = { prompt = false; };
      "mergetool \"nvim\"" = { cmd = "nvim -f -c 'DiffviewOpen'"; };
    };

    aliases = {
      lg =
        "log --graph --abbrev-commit --decorate --format=format:'%C(bold cyan)%h%C(reset) ->%C(bold yellow)%d%C(reset) %C(white)%s%C(reset) %C(green)(%ar)%C(reset) %C(dim white)- %an%C(reset)'";
    };

    hooks = {
      #TODO this should point to another dir
      #post-commit = $HOME/nix/user/scripts/git/post-commit-hook.sh
      #post-commit = home/gideon/nix/user/scripts/git/post-commit-hook.sh;
      #post-commit = ./post-commit-hook.sh;
      #post-commit = "post-commit-hook";
      post-commit = "${lib.getExe (pkgs.writeShellScriptBin "post-commit-hook" (builtins.readFile ../../../scripts/git/post-commit-hook.sh))}";

    };
  };
}
