return {
  {

    "neovim/nvim-lspconfig",

    config = function()
      -- vim.o.complete = ".,o" -- use buffer and omnifunc

      -- vim.o.completeopt = "fuzzy,menuone,noselect" -- add 'popup' for docs (sometimes)
      -- vim.o.autocomplete = true
      vim.o.pumheight = 5

      vim.lsp.enable({ "lua_ls", "clangd", "gopls", "nil_ls", "rust_analyzer" })
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          --
          --          if client:supports_method('textDocument/implementation') then
          --            -- Create a keymap for vim.lsp.buf.implementation ...
          --          end
          --
          --          -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
          --          -- if client:supports_method('textDocument/completion') then
          --          -- Optional: trigger autocompletion on EVERY keypress. May be slow!
          --          -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
          --          -- client.server_capabilities.completionProvider.triggerCharacters = chars
          --
          --          -- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
          --          -- end
          --
          -- Auto-format ("lint") on save.
          -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
      --    end,
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require 'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          --          completion = cmp.config.window.bordered(),
          --          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.complete(),
          ['<C-return>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- vim.lsp.conifg(servers, {capabilities = capabilities})
      vim.lsp.config('*', {
        capabilities = capabilities
      })
    end,
  },

  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  }
}
