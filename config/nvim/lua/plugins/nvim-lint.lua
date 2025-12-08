return {
  {
    "mfussenegger/nvim-lint",

    config = function()
      local lint = require("lint")

      -- Function to get the correct working directory for linting
      local function get_lint_cwd(bufname)
        local cwd = vim.fn.getcwd()

        -- Enhanced PHP project detection for Flow/Neos and Laravel
        if bufname:match("%.php$") then
          -- Helper function to find Flow/Neos project root
          local function find_flow_root(start_path)
            local current = start_path
            local potential_roots = {}

            while current and current ~= "/" do
              local flow_yaml = current .. "/Configuration/Settings.yaml"
              local flow_routes = current .. "/Configuration/Routes.yaml" 
              local packages_dir = current .. "/Packages"
              local dist_packages_dir = current .. "/DistributionPackages"
              local main_composer = current .. "/composer.json"
              local phpstan_config = current .. "/phpstan.neon"

              local has_flow_config = vim.fn.filereadable(flow_yaml) == 1 or vim.fn.filereadable(flow_routes) == 1
              local has_packages = vim.fn.isdirectory(packages_dir) == 1 or vim.fn.isdirectory(dist_packages_dir) == 1
              local has_composer = vim.fn.filereadable(main_composer) == 1
              local has_phpstan = vim.fn.filereadable(phpstan_config) == 1

              if (has_flow_config or has_packages) and has_composer then
                local priority = 0

                -- Higher priority for directories with phpstan config
                if has_phpstan then
                  priority = priority + 1
                end

                -- Higher priority for main application root
                if vim.fn.isdirectory(dist_packages_dir) == 1 or vim.fn.isdirectory(packages_dir) == 1 then
                  priority = priority + 2
                elseif has_flow_config then
                  priority = priority + 1
                end

                table.insert(potential_roots, { path = current, priority = priority })
              end

              current = vim.fn.fnamemodify(current, ":h")
            end

            table.sort(potential_roots, function(a, b) return a.priority > b.priority end)
            return #potential_roots > 0 and potential_roots[1].path or nil
          end

          -- Start from the file's directory and work upwards
          local file_dir = vim.fn.fnamemodify(bufname, ":h")
          local flow_root = find_flow_root(file_dir)

          if flow_root then
            return flow_root
          end

          -- Fallback to backend directory for Laravel projects
          if vim.fn.isdirectory(cwd .. "/backend") == 1 then
            return cwd .. "/backend"
          end
        end

        -- If we're in a Dart file and app exists, use app directory
        if bufname:match("%.dart$") and vim.fn.isdirectory(cwd .. "/app") == 1 then
          return cwd .. "/app"
        end

        return cwd
      end

      -- Make function available for testing
      _G.debug_get_lint_cwd = get_lint_cwd

      lint.linters_by_ft = {
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        markdown = {},
        php = { "phpstan" },
        go = { "revive" },
      }

      -- Configure PHPStan with higher memory limit
      lint.linters.phpstan = vim.tbl_extend("force", lint.linters.phpstan, {
        args = { "analyze", "--error-format=json", "--no-progress", "--memory-limit=2G" }
      })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          -- Change to appropriate directory for linting
          local bufname = vim.api.nvim_buf_get_name(0)
          local original_cwd = vim.fn.getcwd()
          local lint_cwd = get_lint_cwd(bufname)

          if lint_cwd ~= original_cwd then
            vim.cmd("cd " .. lint_cwd)
            
            -- Debug: Show if we find phpstan.neon in the new directory
            if bufname:match("%.php$") then
              local phpstan_config = lint_cwd .. "/phpstan.neon"
              print(string.format("[DEBUG] PHPStan config exists: %s", vim.fn.filereadable(phpstan_config) == 1))
              if vim.fn.filereadable(phpstan_config) == 1 then
                print("[DEBUG] Running PHPStan from:" .. lint_cwd)
              end
            end
            
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
