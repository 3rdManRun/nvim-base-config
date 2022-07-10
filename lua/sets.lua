vim.o.guicursor = ""
vim.o.termguicolors = true

vim.o.nu = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.breakindent = true
vim.o.scrolloff = 8
vim.o.colorcolumn = "80"

if vim.fn.has("nvim-0.5.0") then
  vim.o.signcolumn = "number"
else
  vim.o.signcolumn = "yes"
end

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.isfname:append("@-@")
vim.opt.clipboard:append("unnamedplus")
vim.opt.shortmess:append("c")

-- vim.o.cmdheight = 2
vim.o.updatetime = 250
