return {
  -- init.lua:
  {
    'nvim-telescope/telescope.nvim',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
    },

    config = function()
      require('telescope').setup {
        extensions = {
          ["ui-select"] = {
            --require("telescope.themes").get_dropdown {
            ---- even more opts
            --}
          },
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        },

      }
      require("telescope").load_extension("ui-select")
      require('telescope').load_extension('fzf')
    end,
    keys = {
      { "<leader>ff", function() require('telescope.builtin').find_files() end },
      { "<leader>fh", function() require('telescope.builtin').help_tags() end },
      { "<leader>fg", function() require('telescope.builtin').live_grep() end },
      { "<leader>fb", function() require('telescope.builtin').buffers() end },
    }
  }
}
