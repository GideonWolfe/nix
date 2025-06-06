{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        enableUpdateCheck = true;
        enableExtensionUpdateCheck = true;
        extensions = with pkgs.vscode-extensions; [
          golang.go # Golang
          vue.volar # Golang
          mattn.lisp # Lisp
          twxs.cmake # Cmake
          sumneko.lua # Lua
          bbenoist.nix # Nix
          zainchen.json # Json
          vscodevim.vim # Vim
          shopify.ruby-lsp # Ruby
          tomoki1207.pdf # PDF Preview
          redhat.ansible # Ansible
          redhat.vscode-xml # XML
          redhat.vscode-yaml # YAML
          ms-python.debugpy # Python debugger
          ms-pyright.pyright # Python Linter
          ms-toolsai.jupyter # Juptyter
          ms-vscode.hexeditor # Hex editor
          ms-vscode.powershell # Powershell
          ms-dotnettools.csharp # C#
          eugleo.magic-racket # Racket
          tamasfe.even-better-toml # TOML
        ];
      };
    };
    # userSettings = {};
  };
}
