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
      },
      inline = {
        adapter = "anthropic",
      },
    },
  },
}
