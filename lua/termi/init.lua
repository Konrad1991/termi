local M = {}

function run_build()
	local current_dir = vim.fn.expand("%:p:h")
	local build_script = vim.fn.findfile("build.sh", current_dir)
	if build_script ~= "" then
		local output = vim.fn.systemlist("cd " .. current_dir .. " && ./build.sh")
		return output
	else
		return { "build.sh not found in the current directory." }
	end
end

function M.run()
	local build_output = run_build()
	local bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, build_output)

	vim.api.nvim_win_set_option(0, "wrap", false)
	vim.api.nvim_win_set_option(0, "winfixwidth", true)

	local bufname = "Build output " .. os.time()

	vim.api.nvim_buf_set_name(bufnr, bufname)

	vim.api.nvim_set_current_buf(bufnr)

	vim.api.nvim_win_set_cursor(0, { 1, 0 })
end

return M
