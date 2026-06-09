require("kulala").setup({
  global_keymaps = true,
  global_keymaps_prefix = "<leader>R",
  kulala_keymaps_prefix = "<localleader>",
  kulala_keymaps = {
    ["Send request"]             = { "<CR>", function() require("kulala").run() end, mode = { "n", "v" } },
    ["Send all requests"]        = { "<S-CR>", function() require("kulala").run_all() end },
    ["Replay the last request"]  = { "r", function() require("kulala").replay() end },
    ["Inspect current request"]  = { "i", function() require("kulala").inspect() end },
    ["Show stats"]               = { "S", function() require("kulala").show_stats() end },
    ["Scratchpad"]               = { "s", function() require("kulala").scratchpad() end },
    ["Copy as cURL"]             = { "c", function() require("kulala").copy() end },
    ["Paste from curl"]          = { "C", function() require("kulala").from_curl() end },
    ["Jump to next request"]     = { "]", function() require("kulala").jump_next() end },
    ["Jump to previous request"] = { "[", function() require("kulala").jump_prev() end },
    ["Find request"]             = { "f", function() require("kulala").search() end },
    ["Toggle headers/body"]      = { "t", function() require("kulala").toggle_view() end },
    ["Select environment"]       = { "e", function() require("kulala").set_selected_env() end },
    ["Manage Auth Config"]       = { "u", function() require("kulala.ui.auth_manager").open_auth_config() end },
    ["Clear globals"]            = { "x", function() require("kulala").scripts_clear_global() end },
    ["Close window"]             = { "q", function() require("kulala").close() end },
    ["Show verbose"]             = { "VE", function() require("kulala.ui").show_verbose() end, },
    ["Show headers and body"]    = { "A", function() require("kulala.ui").show_headers_body() end, },
    ["Show script output"]       = { "O", function() require("kulala.ui").show_script_output() end, },
    ["Show report"]              = { "R", function() require("kulala.ui").show_report() end, },
    ["Show filter"]              = { "F", function() require("kulala.ui").toggle_filter() end },
    ["Show help"]                = { "?", function() require("kulala.ui").show_help() end, },
  },
  lsp = { formatter = false },
})

vim.treesitter.language.register('kulala_http', 'http')

vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})
