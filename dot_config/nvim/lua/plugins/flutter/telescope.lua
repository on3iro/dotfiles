local M = {}

function M.setup()
    local a = vim.api
    require("telescope").load_extension("flutter")
    a.nvim_set_keymap("n", "<leader>;", "<cmd>Telescope flutter commands<cr>", { noremap = false })
end

return M
