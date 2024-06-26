local M = {}
M.border = {
   preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
   prompt = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
   results = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
}
M.layout_config = {
	preview_cutoff = 10,
	height = 0.8,
	-- anchor = "N",
	mirror = false,
	prompt_position = "top",
	width = 0.8,
}

return M
