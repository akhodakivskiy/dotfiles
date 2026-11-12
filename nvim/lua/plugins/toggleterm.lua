return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      direction = 'float',
      float_opts = {
        width = function() return math.ceil(vim.o.columns * 0.95) end,
        height = function() return math.ceil(vim.o.lines * 0.95) end,
      }
    },
  }
}
