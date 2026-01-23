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
    adapters = {
      http = {
        mistral = function()
          return require("codecompanion.adapters").extend("mistral", {
            schema = {
              model = {
                default = "mistral-large-latest", -- Replace with the correct model name
              },
            },
          })
        end,
      },
    },
    interactions = {
      chat = {
        adapter = "mistral",
        slash_commands = {
          ["file"] = {
            callback = "interactions.chat.slash_commands.builtin.file",
            description = "Select a file using snacks.picker",
            opts = {
              provider = "snacks", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
              contains_code = true,
            },
          },
          ["fetch"] = {
            callback = "interactions.chat.slash_commands.builtin.fetch",
            description = "Fetch a file using snacks.picker",
            opts = {
              provider = "snacks", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
              contains_code = true,
            },
          },
          ["buffer"] = {
            callback = "interactions.chat.slash_commands.builtin.buffer",
            description = "Select a buffer using snacks.picker",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
          ["help"] = {
            callback = "interactions.chat.slash_commands.builtin.help",
            description = "Search help using snacks.picker",
            opts = {
              provider = "snacks",
            },
          },
          ["symbols"] = {
            callback = "interactions.chat.slash_commands.builtin.symbols",
            description = "Select symbols using snacks.picker",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
        }
      },
      inline = {
        adapter = "mistral",
      },
      cmd = {
        adapter = "mistral",
      }
    },
  },
}
