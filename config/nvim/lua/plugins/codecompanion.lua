require("codecompanion").setup({
  extensions = {
    history = {
      enabled = true,
      opts = {
        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
        keymap = "gh",
        save_chat_keymap = "sc",
        auto_save = false,
        expiration_days = 4,
        picker = "snacks",
      }
    }
  },
  adapters = {},
  interactions = {
    chat = {
      adapter = "anthropic",
      slash_commands = {
        ["file"] = {
          callback = "interactions.chat.slash_commands.builtin.file",
          description = "Select a file using snacks.picker",
          opts = {
            provider = "snacks",
            contains_code = true,
          },
        },
        ["fetch"] = {
          callback = "interactions.chat.slash_commands.builtin.fetch",
          description = "Fetch a file using snacks.picker",
          opts = {
            provider = "snacks",
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
})

vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "CodeCompanion Chat" })
vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "CodeCompanion Add Selection" })
