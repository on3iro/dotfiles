local c = vim.cmd
local a = vim.api

-- Notes
c("command! Note edit ~/Nextcloud/Notes/todo.md")
c("command! NoteToday edit `touty -t ~/Nextcloud/Notes/inbox -n note`")
c("command! NoteYesterday edit `touty -t ~/Nextcloud/Notes/inbox -n note -a -1d`")
c("command! NoteTomorrow edit `touty -t ~/Nextcloud/Notes/inbox -n note -a +1d`")
c("command! Diary edit `touty -t ~/Nextcloud/Notes/diary -n diary`")

a.nvim_set_keymap("n", "<leader>no", ":Note<CR>", { noremap = true })
a.nvim_set_keymap("n", "<leader>nt", ":NoteToday<CR>", { noremap = true })
a.nvim_set_keymap("n", "<leader>ye", ":NoteYesterday<CR>", { noremap = true })
a.nvim_set_keymap("n", "<leader>mo", ":NoteTomorrow<CR>", { noremap = true })

-- tmp files
-- c("command! TmpFile edit ~/tmp-theo/scratchpad")
-- a.nvim_set_keymap("n", "<leader>tm", ":TmpFile<CR>", { noremap = true })

-- Markdown checklists

function _G.markdown_list_to_checklist()
	local current_mode = vim.api.nvim_get_mode().mode
	-- TODO
end

function _G.markdown_checklist_to_list()
	-- TODO
end

function _G.toggle_checklist_item()
	-- Get current mode
	local current_mode = vim.api.nvim_get_mode().mode
	local unchecked_pattern_with_whitespace = "^%s*%- %[ %] "
	local unchecked_pattern = "- %[ %] "
	local checked_pattern_with_whitespace = "^%s*%- %[x%] "
	local checked_pattern = "- %[x%] "
	local unchecked_string = "- [ ] "
	local checked_string = "- [x] "

	-- Get visual start and end positions using buffer marks
	local start_pos = vim.fn.getpos("v")[2]
	local end_pos = vim.fn.getpos(".")[2]

	-- Check if current mode is visual
	if (current_mode == "v" or current_mode == "V") and start_pos ~= end_pos then
		-- make sure end is higher than start_pos :
		if start_pos > end_pos then
			start_pos, end_pos = end_pos, start_pos
		end

		local lines = vim.fn.getline(start_pos, end_pos)

		local line_number = start_pos
		for i, line in ipairs(lines) do
			if line:match(unchecked_pattern_with_whitespace) then
				lines[i] = line:gsub(unchecked_pattern, checked_string)
				vim.fn.setline(line_number, lines[i])
			elseif line:match(checked_pattern_with_whitespace) then
				lines[i] = line:gsub(checked_pattern, unchecked_string)
				vim.fn.setline(line_number, lines[i])
			end

			line_number = line_number + 1
		end

		-- exit visual mode
		-- vim.cmd("normal! <Esc>")
	else
		-- "." gets the line under the cursor
		local line = vim.fn.getline(".")

		-- Match "- [ ] "
		if line:match(unchecked_pattern) then
			-- replace line part with checked line part
			line = line:gsub(unchecked_pattern, checked_string)
		elseif line:match(checked_pattern) then
			line = line:gsub(checked_pattern, unchecked_string)
		end

		-- update line
		line = vim.fn.setline(".", line)
	end
end

-- Create a user command to make the function available
vim.api.nvim_create_user_command("ToggleChecklistItem", function()
	_G.toggle_checklist_item()
end, {})

-- Key mappings for the toggle function using <cmd>
vim.api.nvim_set_keymap("v", "<leader>-", "<cmd>ToggleChecklistItem<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>-", "<cmd>ToggleChecklistItem<CR>", { noremap = true, silent = true })
