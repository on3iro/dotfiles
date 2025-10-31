return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    -- Toggle the CodeCompanion Chat interface
    { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
    -- Open the CodeCompanion Actions menu
    { "<leader>ac", "<cmd>CodeCompanionActions<cr>",     desc = "CodeCompanion Actions" },
    -- Add the visually selected text to CodeCompanion Chat (visual mode only)
    { "ga",         "<cmd>CodeCompanionChat Add<cr>",    mode = "v",                    desc = "CodeCompanion Add Selection" },
  },
  opts = {
    strategies = {
      chat = {
        adapter = "anthropic",
        slash_commands = {
          ["file"] = {
            callback = "strategies.chat.slash_commands.file",
            description = "Select a file using snacks.picker",
            opts = {
              provider = "snacks", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
              contains_code = true,
            },
          },
          ["buffer"] = {
            callback = "strategies.chat.slash_commands.buffer",
            description = "Select a buffer using snacks.picker",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
          ["help"] = {
            callback = "strategies.chat.slash_commands.help",
            description = "Search help using snacks.picker",
            opts = {
              provider = "snacks",
            },
          },
          ["symbols"] = {
            callback = "strategies.chat.slash_commands.symbols",
            description = "Select symbols using snacks.picker",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
        }
      },
      inline = {
        adapter = "anthropic",
      },
    },
  },
}
