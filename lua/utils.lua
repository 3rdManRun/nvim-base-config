local M = {}

M.termcodes = setmetatable({}, {
  __index = function(tbl, k)
    local k_upper = k:upper()
    local v_upper = rawget(tbl, k_upper)
    local c = v_upper or vim.api.nvim_replace_termcodes(k, true, false, true)

    rawset(tbl, k, c)

    if not v_upper then rawset(tbl, k_upper, c) end

    return c
  end
})

return M
