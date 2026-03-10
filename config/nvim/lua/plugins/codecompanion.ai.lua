return {
  "olimorris/codecompanion.nvim",
  version = "^19.2.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
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
    extensions = {
      history = {
        enabled = true, -- defaults to true
        opts = {
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
          -- Keymap to open history from chat buffer (default: gh)
          keymap = "gh",
          -- Keymap to save the current chat manually (when auto_save is disabled)
          save_chat_keymap = "sc",
          -- Save all chats by default (disable to save only manually using 'sc')
          auto_save = false,
          -- Number of days after which chats are automatically deleted (0 to disable)
          expiration_days = 4,
          -- Picker interface (auto resolved to a valid picker)
          picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
        }
      }
    },
    adapters = {
      -- http = {
      --   mistral = function()
      --     return require("codecompanion.adapters").extend("mistral", {
      --       schema = {
      --         model = {
      --           default = "mistral-large-latest", -- Replace with the correct model name
      --         },
      --       },
      --     })
      --   end,
      -- },
    },
    interactions = {
      chat = {
        adapter = "anthropic",
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
        adapter = "anthropic",
      },
      cmd = {
        adapter = "anthropic",
      }
    },
  },
}
