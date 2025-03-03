{

  programs.nixvim.plugins.cmp_luasnip = { enable = true; };
  #programs.nixvim.plugins.cmp-path = { enable = true; };
  programs.nixvim.plugins.cmp-async-path = { enable = true; };
  programs.nixvim.plugins.cmp-buffer = { enable = true; };
  programs.nixvim.plugins.cmp-calc = { enable = true; };
  programs.nixvim.plugins.cmp-cmdline = { enable = true; };
  programs.nixvim.plugins.cmp-dictionary = { enable = true; };
  programs.nixvim.plugins.cmp-digraphs = { enable = true; };
  programs.nixvim.plugins.cmp-emoji = { enable = true; };
  programs.nixvim.plugins.cmp-fish = { enable = true; };
  programs.nixvim.plugins.cmp-git = { enable = true; };
  programs.nixvim.plugins.cmp-latex-symbols = { enable = true; };
  programs.nixvim.plugins.cmp-nvim-lsp-document-symbol = { enable = true; };
  programs.nixvim.plugins.cmp-nvim-lsp-signature-help = { enable = true; };
  programs.nixvim.plugins.cmp-nvim-lsp = { enable = true; };
  programs.nixvim.plugins.cmp-nvim-lua = { enable = true; };
  programs.nixvim.plugins.cmp-spell = { enable = true; };
  programs.nixvim.plugins.cmp-dap = { enable = true; };

  # Main cmp
  programs.nixvim.plugins.cmp = {

    enable = true;
    #TODO: test to see if its better true
    autoEnableSources = false;

    settings = {
      window = {
        documentation = { border = [ "┌" "─" "┐" "│" "┘" "─" "└" "│" ]; };
        completion = { border = [ "┌" "─" "┐" "│" "┘" "─" "└" "│" ]; };
      };
      mapping = {
        __raw = ''

              cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              --['<CR>'] = cmp.mapping.confirm({ select = true }),

              -- Move forward in pmenu
              ["<Tab>"] = cmp.mapping(function(fallback)
                  local luasnip = require('luasnip')
                  local cmp = require('cmp')
                  if cmp.visible() then
                      cmp.select_next_item()
                  elseif luasnip.locally_jumpable(1) then
                      luasnip.jump(1)
                  else
                      fallback()
                  end
              end, { "i", "s" }),

              -- Move backwards
              ["<S-Tab>"] = cmp.mapping(function(fallback)
                  local luasnip = require('luasnip')
                  local cmp = require('cmp')
                  if cmp.visible() then
                      cmp.select_prev_item()
                  elseif luasnip.locally_jumpable(-1) then
                      luasnip.jump(-1)
                  else
                      fallback()
                  end
              end, { "i", "s" }),


              -- Make selection
              ['<CR>'] = cmp.mapping(function(fallback)
                  local luasnip = require('luasnip')
                  local cmp = require('cmp')
                  if cmp.visible() then
                      if luasnip.expandable() then
                          luasnip.expand()
                      else
                          cmp.confirm({
                              select = true,
                          })
                      end
                  else
                      fallback()
                  end
              end),


          })
        '';
      };
      snippet = {
        expand = "function(args) require('luasnip').lsp_expand(args.body) end";
      };
      sources = {
        __raw = ''
          cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'nvim_lsp_document_symbols' },
              { name = 'nvim_lsp_signature_help' },
              { name = 'nvim_lua' },
              { name = 'luasnip' },
              { name = 'buffer' },
              { name = 'async_path' },
              { name = 'emoji' },
              { name = 'git' },
              { name = 'latex_symbols' },
              { name = 'crates' },
              { name = 'dictionary' },
              { name = 'calc' },
              { name = 'fish' },
              { name = 'digraphs' },
              { name = 'spell' },
          })
        '';
      };
    };
  };
}
