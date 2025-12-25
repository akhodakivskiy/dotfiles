return {
  "folke/snacks.nvim",
  opts = {
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
