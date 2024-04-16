local M = {}

function M.run_build()
	local current_dir = vim.fn.expand("%:p:h")
	local build_script = vim.fn.findfile("build.sh", current_dir)
	if build_script ~= "" then
		vim.cmd("terminal cd " .. current_dir .. " && ./build.sh")
	else
		print("build.sh not found in the current directory.")
	end
end

return M
