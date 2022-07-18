local packer_install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  packer_bootstrap = vim.fn.system({
    "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_install_path
  })
end

require("packer").startup(function(use)
  use { "wbthomason/packer.nvim" }

  use { "milisims/nvim-luaref" }

  use { "LionC/nest.nvim" }
  use {
    "mrjones2014/legendary.nvim",

    config = function()
      require("legendary").setup {}
    end
  }

  use { "sainnhe/sonokai" }

  use { "jiangmiao/auto-pairs" }

  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "nvim-treesitter/nvim-treesitter-textobjects" }

  use { "neoclide/coc.nvim", branch = "release" }
  use { "neoclide/jsonc.vim" }

  use { "antonk52/vim-browserslist" }

  use { "honza/vim-snippets" }
  use {
    "ThePrimeagen/refactoring.nvim",

    config = function()
      require("refactoring").setup {}
    end,

    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    }
  }

  use { "kana/vim-textobj-user" }
  use { "kana/vim-textobj-indent" }
  use { "kana/vim-textobj-line" }
  use { "kana/vim-textobj-fold" }

  use { "tpope/vim-unimpaired" }
  use { "tpope/vim-surround" }
  use { "tpope/vim-repeat" }

  use {
    "numToStr/Comment.nvim",

    config = function()
      require('Comment').setup()
    end
  }

  use { "mbbill/undotree" }

  use { "junegunn/fzf" }
  use { "junegunn/fzf.vim" }

  use { "jremmen/vim-ripgrep" }

  if packer_bootstrap then
    require("packer").sync()
  end
end)

vim.cmd [[colorscheme sonokai]]

local nest = require 'nest'

nest.applyKeymaps { { "<Space>", "<Nop>" } }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.vimsyn_embed = "l"

vim.g.AutoPairsShortcutJump = "<C-e>"
vim.g.AutoPairsMapCR = 0
vim.g.AutoPairs = {
  ['"'] = '"',
  ["'"] = "'",
  ["`"] = "`",
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
  ["<"] = ">",
}

require "edits"
require "refactor"
require "sets"
require "keymaps"
require "treesitter"
require "netrw"
require "rg"
require "coc"
