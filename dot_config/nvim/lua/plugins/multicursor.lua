return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      -- Add cursors above/below the main cursor.
      vim.keymap.set({ "n", "v" }, "<leader>ck", function() mc.addCursor("k") end,
        { desc = "Add cursor above main cursor" })
      vim.keymap.set({ "n", "v" }, "<leader>cj", function() mc.addCursor("j") end,
        { desc = "Add cursor below main cursor" })

      -- Add a cursor and jump to the next word under cursor.
      vim.keymap.set({ "n", "v" }, "<c-n>", function() mc.addCursor("*") end, {
        desc = "Add cursor and jump to next word under cursor",
      })

      -- Jump to the next word under cursor but do not add a cursor.
      vim.keymap.set({ "n", "v" }, "<leader>cs", function() mc.skipCursor("*") end, { desc = "skip to next word" })

      -- Rotate the main cursor.
      vim.keymap.set({ "n", "v" }, "<leader>h", mc.nextCursor, { desc = "rotate previous cursor" })
      vim.keymap.set({ "n", "v" }, "<leader>l", mc.prevCursor, { desc = "rotate next cursor" })

      -- Delete the main cursor.
      vim.keymap.set({ "n", "v" }, "<leader>cx", mc.deleteCursor, {
        desc = "delete main cursor"
      })

      -- Add and remove cursors with control + left click.
      vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

      vim.keymap.set({ "n", "v" }, "<leader>cn", function()
        if mc.cursorsEnabled() then
          -- Stop other cursors from moving.
          -- This allows you to reposition the main cursor.
          mc.disableCursors()
        else
          mc.addCursor()
        end
      end, { desc = "add new cursor" })

      vim.keymap.set("n", "<leader>cc", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end, { desc = "clear cursors" })

      -- Align cursor columns.
      vim.keymap.set("n", "<leader>ca", mc.alignCursors, { desc = "align cursors" })

      -- Split visual selections by regex.
      vim.keymap.set("v", "<leader>cs", mc.splitCursors, { desc = "split visual selection regex" })

      -- Append/insert for each line of visual selections.
      vim.keymap.set("v", "I", mc.insertVisual)
      vim.keymap.set("v", "A", mc.appendVisual)

      -- match new cursors within visual selections by regex.
      vim.keymap.set("v", "M", mc.matchCursors)

      -- Rotate visual selection contents.
      vim.keymap.set("v", "<leader>t", function() mc.transposeCursors(1) end)
      vim.keymap.set("v", "<leader>T", function() mc.transposeCursors(-1) end)

      -- Customize how cursors look.
      vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
      vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    end,
  }
}
