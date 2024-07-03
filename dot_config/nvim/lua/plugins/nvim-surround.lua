return {
  -- Vim-Surround (eg. with "", {} etc.)
  "kylechui/nvim-surround",
  config = function()
    require('nvim-surround').setup({
      keymaps = {
        normal          = 'gz',
        normal_cur      = 'gZ',
        normal_line     = 'gzgz',
        normal_cur_line = 'gZgZ',
        visual          = 'gz',
        visual_line     = 'gZ',
        delete          = 'gzd',
        change          = 'gzc',
      }
    })
  end
}
