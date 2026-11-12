-- pyright and rust-analyzer come from the LazyVim lang.python / lang.rust extras (see lazyvim.json)
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        keys = {
          { "go", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
      },
    },
  },
}
