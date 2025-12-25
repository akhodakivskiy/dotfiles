-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

wk.add({
  {
    "\\",
    function()
      Snacks.explorer()
    end,
    desc = "Explorer Snacks (cwd)",
  },
})

wk.add({ "go", ":ClangdSwitchSourceHeader<CR>", desc = "Switch Source/Header" })
