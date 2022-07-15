local nest = require("nest")

nest.applyKeymaps {
  {
    mode = "v",
    {
      "<Leader>", {
        "rf", [[<Esc><Cmd>lua require("refactoring").refactor("Extract Function")<CR>]],
        "rv", [[<Esc><Cmd>lua require("refactoring").refactor("Extract Variable")<CR>]]
      }
    }
  },
  {
    "<Leader>", {
      "rb", [[<Esc><Cmd>lua require("refactoring").refactor("Extract Block")<CR>]]
    }
  }
}
