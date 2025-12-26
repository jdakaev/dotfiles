return
-- init.lua:
{
  'nvim-telescope/telescope.nvim',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim'
  },

  opts = {
    extensions = {
      ["ui-select"] = {
        --require("telescope.themes").get_dropdown {
        ---- even more opts
        --}
      },
    }
  },
  keys = {
    { "<leader>ff", function() require('telescope.builtin').find_files() end },
    { "<leader>fh", function() require('telescope.builtin').help_tags() end },
    { "<leader>fg", function() require('telescope.builtin').live_grep() end },
    { "<leader>fb", function() require('telescope.builtin').buffers() end },
  }
}
