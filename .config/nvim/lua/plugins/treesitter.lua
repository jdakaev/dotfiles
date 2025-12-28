return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ensure_installed = {
      "go"
    }
    -- https://github.com/SylvanFranklin/.config/commit/5684cf6dd5d39dc6aa07c45daa77590bfc93c2d3
    require("nvim-treesitter").install(ensure_installed)
    local filetypes = vim.iter(ensure_installed):map(vim.treesitter.language.get_filetypes):flatten():totable()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function(args) vim.treesitter.start(args.buf) end,
    })
  end,
}
