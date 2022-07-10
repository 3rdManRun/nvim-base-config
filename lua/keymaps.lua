local nest = require("nest")

if vim.fn.has("win32") then
  nest.applyKeymaps { { "<Leader>", { "sh", "<Cmd>edit term://bash<CR>" } } }
end

nest.applyKeymaps {
  {
    mode = "i",
    { ",", ",<C-g>u" },
    { ".", ".<C-g>u" },
    { "?", "?<C-g>u" },
    { "!", "!<C-g>u" },
  },

  { "Y", "y$" },
  { "n", "nzzzv" },
  { "N", "Nzzzv" },
  { "J", "mzJ`z" },

  {
    "<Leader>",
    {
      { "h", ":wincmd h<CR>" },
      { "j", ":wincmd j<CR>" },
      { "k", ":wincmd k<CR>" },
      { "l", ":wincmd l<CR>" },

      { "so", ":so %<CR>" },

      { "uu", ":UndotreeShow<CR>" },

      { "fg", ":GFiles<CR>" },
      { "ff", ":FZF<CR>" },
      { "fh", ":History<CR>" },
      { "fb", ":Buffers<CR>" },

      { "pv", ":wincmd v <Bar> :Ex <Bar> :vertical resize 30<CR>" }
    }
  },
  {
    options = { expr = true },
    { "j", "v:count ? 'j' : 'gj'", },
    { "k", "v:count ? 'k' : 'gk'", },
  },

  { "C-s", ":w<CR>" },

  {
    mode = "i",
    { "C-s", "<C-o>:w<CR>" },
    { "jk", "<Esc>l" },
  },

  {
    mode = "t",
    { "jk", "<C-\\><C-n>" }
  },
}
