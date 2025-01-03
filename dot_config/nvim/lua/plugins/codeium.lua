return {
  "Exafunction/codeium.nvim",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  commit = "937667b2cadc7905e6b9ba18ecf84694cf227567",
  config = function()
    require("codeium").setup({
      enable_chat = true,
    })

    local Source = require("codeium.source")

    local function is_codeium_enabled()
      local enabled = vim.b["codeium_enabled"]
      if enabled == nil then
        enabled = vim.g["codeium_enabled"]
        if enabled == nil then
          enabled = true -- enable by default
        end
      end
      return enabled
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    function Source:is_available()
      local enabled = is_codeium_enabled()
      ---@diagnostic disable-next-line: undefined-field
      return enabled and self.server.is_healthy()
    end

    vim.api.nvim_set_keymap("n", "<leader>tc", "", {
      desc = "toggle codeium",
      callback = function()
        local new_enabled = not is_codeium_enabled()
        vim.b["codeium_enabled"] = new_enabled
        if new_enabled then
          vim.notify("Codeium enabled in buffer")
        else
          vim.notify("Codeium disabled in buffer")
        end
      end,
      noremap = true,
    })
  end,
}
