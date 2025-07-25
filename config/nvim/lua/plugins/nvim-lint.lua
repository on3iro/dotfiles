return {
  {
    "mfussenegger/nvim-lint",

    config = function()
      local lint = require("lint")

      -- Function to get the correct working directory for linting
      local function get_lint_cwd(bufname)
        local cwd = vim.fn.getcwd()

        -- If we're in a PHP file and backend exists, use backend directory
        if bufname:match("%.php$") and vim.fn.isdirectory(cwd .. "/backend") == 1 then
          return cwd .. "/backend"
        end

        -- If we're in a Dart file and app exists, use app directory
        if bufname:match("%.dart$") and vim.fn.isdirectory(cwd .. "/app") == 1 then
          return cwd .. "/app"
        end

        return cwd
      end

      lint.linters_by_ft = {
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        markdown = {},
        php = { "phpstan" },
        go = { "revive" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          -- Change to appropriate directory for linting
          local bufname = vim.api.nvim_buf_get_name(0)
          local original_cwd = vim.fn.getcwd()
          local lint_cwd = get_lint_cwd(bufname)

          if lint_cwd ~= original_cwd then
            vim.cmd("cd " .. lint_cwd)
            lint.try_lint()
            vim.cmd("cd " .. original_cwd)
          else
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
