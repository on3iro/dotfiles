-- global_keymaps (despite the name) is what actually governs .http-buffer
-- actions, gated by ft = {"http","rest"}; kulala_keymaps only governs the
-- response-window UI opened after a request runs.
--
-- kulala's collect_global_keymaps()/get_kulala_keymaps() only prepend the
-- prefix option to its OWN default keymaps table before merging; a custom
-- table passed here is merged in verbatim via tbl_extend, unprefixed. So the
-- prefix has to be baked into each lhs by hand, or entries end up bound as
-- bare keys (e.g. plain "e", "i", "x" ...), silently shadowing normal Vim
-- motions in .http buffers.
local prefix = "<localleader>"

require("kulala").setup({
  -- Both tables share <localleader> (config/settings.lua) instead of <leader>R,
  -- so kulala's .http-buffer-local mappings can't collide with any <leader>-
  -- prefixed binding elsewhere in the config.
  global_keymaps_prefix = "<localleader>",
  global_keymaps = {
    ["Send request"]             = { prefix .. "<CR>", function() require("kulala").run() end, mode = { "n", "v" }, ft = { "http", "rest" } },
    ["Send all requests"]        = { prefix .. "<S-CR>", function() require("kulala").run_all() end, ft = { "http", "rest" } },
    ["Replay the last request"]  = { prefix .. "r", function() require("kulala").replay() end, ft = { "http", "rest" } },
    ["Inspect current request"]  = { prefix .. "i", function() require("kulala").inspect() end, ft = { "http", "rest" } },
    ["Show stats"]               = { prefix .. "S", function() require("kulala").show_stats() end, ft = { "http", "rest" } },
    ["Scratchpad"]               = { prefix .. "s", function() require("kulala").scratchpad() end, ft = { "http", "rest" } },
    ["Copy as cURL"]             = { prefix .. "c", function() require("kulala").copy() end, ft = { "http", "rest" } },
    ["Paste from curl"]          = { prefix .. "C", function() require("kulala").from_curl() end, ft = { "http", "rest" } },
    ["Jump to next request"]     = { prefix .. "n", function() require("kulala").jump_next() end, ft = { "http", "rest" } },
    ["Jump to previous request"] = { prefix .. "p", function() require("kulala").jump_prev() end, ft = { "http", "rest" } },
    ["Find request"]             = { prefix .. "f", function() require("kulala").search() end, ft = { "http", "rest" } },
    ["Toggle headers/body"]      = { prefix .. "t", function() require("kulala").toggle_view() end, ft = { "http", "rest" } },
    ["Select environment"]       = { prefix .. "e", function() require("kulala").set_selected_env() end, ft = { "http", "rest" } },
    ["Manage Auth Config"]       = { prefix .. "a", function() require("kulala.ui.auth_manager").open_auth_config() end, ft = { "http", "rest" } },
    ["Clear globals"]            = { prefix .. "x", function() require("kulala").scripts_clear_global() end, ft = { "http", "rest" } },
    ["Close window"]             = { prefix .. "q", function() require("kulala").close() end, ft = { "http", "rest" } },
  },
  kulala_keymaps_prefix = "<localleader>",
  kulala_keymaps = {
    ["Show verbose"]             = { prefix .. "v", function() require("kulala.ui").show_verbose() end },
    ["Show headers and body"]    = { prefix .. "A", function() require("kulala.ui").show_headers_body() end },
    ["Show script output"]       = { prefix .. "O", function() require("kulala.ui").show_script_output() end },
    ["Show report"]              = { prefix .. "R", function() require("kulala.ui").show_report() end },
    ["Next response"]            = { prefix .. "]", function() require("kulala.ui").show_next() end },
    ["Previous response"]        = { prefix .. "[", function() require("kulala.ui").show_previous() end },
    ["Show filter"]              = { prefix .. "F", function() require("kulala.ui").toggle_filter() end },
    ["Show help"]                = { prefix .. "?", function() require("kulala.ui").show_help() end },
  },
  lsp = { formatter = false },
})

vim.treesitter.language.register('kulala_http', 'http')

vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})
