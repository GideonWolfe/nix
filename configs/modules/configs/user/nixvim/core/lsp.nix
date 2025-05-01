{ pkgs, ... }: {
  # Main Telescope plugin
  programs.nixvim.plugins.lsp = {

    # Enable LSPs to be configured
    enable = true;

    # onAttach = ''
    #   require "lsp_signature".on_attach(client, bufnr)
    # '';
    onAttach = ''
            require "lsp_signature".on_attach({
                bind = true,
                handler_opts = {
                  border = "rounded"
                },
                hint_enable = true,
      		  hint_prefix = " ",
            }, bufnr)
    '';

    # Configs for all LSP servers
    servers = {

      # Nix 
      #nil-ls = { enable = true; };
      nil_ls = { enable = true; };
      #nixd = { enable = true; };

      # Bash
      bashls = { enable = true; };

      # Fish
      fish_lsp = {
        enable = true;
        #BUG: wouldn't build without this set
        package = pkgs.fish-lsp;
      };

      # Clojure
      #clojure-lsp = { enable = true; };
      clojure_lsp = { enable = true; };

      # Cmake
      cmake = { enable = true; };

      # C#
      #csharp-ls = { enable = true; };
      csharp_ls = { enable = true; };

      # CSS
      cssls = { enable = true; };

      # JS
      eslint = { enable = true; };

      # Godot Script
      #gdscript = { enable = true; };

      # Go
      gopls = { enable = true; };

      # Haskell
      hls = {
        enable = true;
        installGhc = true;
      };

      # html
      html = { enable = true; };

      # JSON
      jsonls = { enable = true; };

      # Julia
      #julials = { enable = true; };

      # Kotlin
      #kotlin-language-server = { enable = true; };
      kotlin_language_server = { enable = true; };

      # Lua
      #lua-ls = { enable = true; };
      lua_ls = { enable = true; };

      # PHP
      phpactor = { enable = true; };

      # Python
      pyright = { enable = true; };

      # Rust
      #rust-analyzer = {
      rust_analyzer = {
        enable = true;
        # automatically install deps if not already
        installCargo = true;
        installRustc = true;
      };

      # Tailwind CSS
      tailwindcss = { enable = true; };

      # LaTeX
      texlab = { enable = true; };

      # Typescript
      #tsserver = { enable = true; };
      ts_ls = { enable = true; };

      # Vue JS
      #vuels = { enable = true; };

      # YAML
      yamlls = { enable = true; };
    };
  };
}
