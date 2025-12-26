vim.g.netrw_banner = 0
vim.g.netrw_list_hide = [[^\(../\|./\)]] -- hide dotted folders
-- vim.g.netrw_list_hide=""
-- vim.g.netrw_hide=1
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true


vim.o.rnu = true
vim.o.nu = true


vim.o.undofile = true
vim.o.wrap = true

vim.o.smartindent = true

--
--vim.diagnostic.config({
--signs = {
--text = {
--[vim.diagnostic.severity.ERROR] = "",
--[vim.diagnostic.severity.WARN] = "",
--[vim.diagnostic.severity.HINT] = "",
--[vim.diagnostic.severity.INFO] = "",
--},
--numhl = {
--[vim.diagnostic.severity.ERROR] = "ErrorMsg",
--[vim.diagnostic.severity.WARN] = "WarningMsg",
--[vim.diagnostic.severity.HINT] = "DiagnosticHint",
--[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
--},
--},
--})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,      -- show inline messages
  signs = true,             -- show signs in the gutter
  underline = true,         -- underline problematic text
  update_in_insert = false, -- don't update diagnostics while typing
  severity_sort = true,     -- sort diagnostics by severity
})
