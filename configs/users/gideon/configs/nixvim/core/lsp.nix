{
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
      nil-ls = { enable = true; };
      #nixd = { enable = true; };

      # Bash
      bashls = { enable = true; };

      # Clojure
      clojure-lsp = { enable = true; };

      # Cmake
      cmake = { enable = true; };

      # C#
      csharp-ls = { enable = true; };

      # CSS
      cssls = { enable = true; };

      # JS
      eslint = { enable = true; };

      # Godot Script
      gdscript = { enable = true; };

      # Go
      gopls = { enable = true; };

      # Haskell
      hls = { enable = true; };

      # html
      html = { enable = true; };

      # JSON
      jsonls = { enable = true; };

      # Julia
      julials = { enable = true; };

      # Kotlin
      kotlin-language-server = { enable = true; };

      # Lua
      lua-ls = { enable = true; };

      # PHP
      phpactor = { enable = true; };

      # Python
      pyright = { enable = true; };

      # Rust
      rust-analyzer = {
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
      tsserver = { enable = true; };

      # Vue JS
      vuels = { enable = true; };

      # YAML
      yamlls = { enable = true; };
    };
  };
}
