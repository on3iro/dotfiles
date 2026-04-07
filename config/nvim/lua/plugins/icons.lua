-- Set up package.preload so that require("nvim-web-devicons") resolves via mini.icons.
-- This must run before any plugin that depends on nvim-web-devicons.
package.preload["nvim-web-devicons"] = function()
  package.loaded["nvim-web-devicons"] = {}
  require("mini.icons").mock_nvim_web_devicons()
  return package.loaded["nvim-web-devicons"]
end

require("mini.icons").setup()
