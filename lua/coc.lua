local nest = require("nest")
local utils = require("utils")

local function esc(str)
  return utils.termcodes[str]
end

local function checkBackSpace()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local linetext = vim.api.nvim_get_current_line()
  return col == 0 or string.match(linetext:sub(col, col), '%s') ~= nil
end

function ShowDocumention()
  if vim.bo.filetype == "help" then
    vim.api.nvim_feedkeys(esc("<C-]>"), "n", false)
  elseif vim.fn["coc#rpc#ready"]() then
    vim.fn.CocActionAsync("doHover")
  else
    vim.fn.execute("! " .. vim.go.keywordprg .. " " .. vim.fn.expand("<cword>", false, false))
  end
end

function ShiftSmartTab()
  return vim.fn.pumvisible() == 1 and esc("<C-p>") or esc("<C-h>")
end

function SmartTab()
  if vim.fn.pumvisible() == 1 then return esc("<C-n>")
  elseif vim.fn["coc#expandableOrJumpable"]() then
    return vim.fn["coc#rpc#request"]("doKeymap", { "snippets-expand-jump", "" })
  elseif checkBackSpace() then return esc("<Tab>")
  else return vim.fn["coc#refresh"]()
  end
end

nest.applyKeymaps {
  {
    mode = "i",
    options = { expr = true },

    { "<Tab>", SmartTab },
    { "<S-Tab>", ShiftSmartTab },

    -- TODO move coc#_select_confirm into a lua fn(currently doesn't work as expected on Termux)
    { "<CR>", "pumvisible()?coc#_select_confirm():'<C-g>u<CR><C-r>=coc#on_enter()<CR>'" },
    {
      options = { nowait = true },

      { "<C-f>", "coc#float#has_scroll()?'<C-r>=coc#float#scroll(1)<CR>':'<Right>'" },
      { "<C-b>", "coc#float#has_scroll()?'<C-r>=coc#float#scroll(0)<CR>':'<Left>'" },
    },
  },
  {
    mode = "nv",
    options = { nowait = true, expr = true },

    { "<C-f>", "coc#float#has_scroll()?coc#float#scroll(1):'<C-f>'" },
    { "<C-b>", "coc#float#has_scroll()?coc#float#scroll(0):'<C-b>'" },
  },

  { "rn", "<Plug>(coc-rename)" },
  { "gd", "<Plug>(coc-definition)" },
  { "gt", "<Plug>(coc-type-definition)" },
  { "gi", "<Plug>(coc-implementation)" },
  { "gr", "<Plug>(coc-references)" },
  { "]d", "<Plug>(coc-diagnostic-next)" },
  { "[d", "<Plug>(coc-diagnostic-prev)" },

  { "K", "<Cmd>call v:lua.ShowDocumention()<CR>" },
}

require("legendary").bind_autocmds {
  name = "CocAuGroup",

  { "Filetype", function() vim.bo.formatexpr = "CocAction('formatSelected')" end, opts = { pattern = { "typescript", "json" } } },
  { "User", function() vim.fn.CocActionAsync("showSignatureHelp") end, opts = { pattern = { "CocJumpPlaceholder" } } },
  { "CursorHold", function() vim.fn.CocActionAsync("highlight") end, },
}

vim.g.coc_snippet_next = "<Tab>"

vim.g.coc_global_extensions = {
  "coc-json",
  "coc-html",
  "coc-tsserver",
  "coc-eslint",
  "coc-prettier",
  "coc-emmet",
  "coc-vimlsp",
  "coc-sumneko-lua",
  "coc-yaml",
  "coc-markdownlint",
  "coc-lists",
  "coc-snippets",
  -- "coc-pairs",
}

-- TODO Handle pcall (Exception) supportfor better error handling
if vim.env.TERMUX_APP_PID then
  vim.fn["coc#config"]("sumneko-lua.serverDir", vim.env.SUMNEKO_LUA_ROOT)
end
