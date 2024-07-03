return {
  'kdheepak/lazygit.nvim',
  config = function()
    vim.api.nvim_set_keymap(
      "n",
      "<leader>G",
      ":LazyGit<CR>",
      { noremap = true }
     )
  end
}
