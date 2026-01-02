return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false,
    },
    picker = {
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["<Esc>"] = function()
                  --Do nothing
                end,
              },
            },
          },
        },
      },
    },
  },
}
