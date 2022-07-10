local function autoMkdir(dir, force)
  if not vim.fn.isdirectory(dir) and (force or vim.fn.input("'" .. dir .. "' does not exist. Create? [y/N]")) then
    vim.fn.mkdir(dir)
  end
end

require("legendary").bind_autocmds {
  name = "EditCmds",

  { "TextYankPost", function() vim.highlight.on_yank() end },
  { "BufWritePre", function() autoMkdir(vim.fn.expand("<afile>:p:h", vim.v.cmdbang, false)) end },
  { "BufWritePost", "source %", opts = { pattern = { vim.env.MYVIMRC, vim.env.MYGVIMRC } } },
}
