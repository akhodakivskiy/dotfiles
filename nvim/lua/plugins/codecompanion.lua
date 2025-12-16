local wk = require("which-key")

wk.add({
  { '<leader>a',  group = "codecompanion" },
  { '<leader>ao', '<cmd>CodeCompanion<cr>',        mode = { 'n', 'v' }, desc = 'C[o]deCompanion Prompt' },
  { '<leader>ac', '<cmd>CodeCompanionChat<cr>',    mode = { 'n', 'v' }, desc = 'CodeCompanion [C]hat' },
  { '<leader>aa', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion [A]ction' },
})

return
{
  {
    'olimorris/codecompanion.nvim',
    config = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      log_level = 'debug',
      strategies = {
        inline = {
          adapter = 'anthropic',
        },
        chat = {
          adapter = 'anthropic',
        },
        agent = {
          adapter = 'anthropic',
        },
      },
      adapters = {
        http = {
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = os.getenv 'ANTHROPIC_KEY',
              },
              schema = {
                model = {
                  default = 'claude-sonnet-4-5-20250929',
                },
              },
            })
          end,
          openai = function()
            return require('codecompanion.adapters').extend('openai', {
              env = {
                api_key = os.getenv 'OPENAI_KEY',
              },
              schema = {
                model = {
                  default = 'gpt-5',
                },
              },
            })
          end,
        },
      },
    },
  },
}
