local M = {}

function M.hello()
	print("Hello, world!")
end

function M.find_build_script()
	local current_dir = vim.fn.expand("%:p:h")
	local build_script = vim.fn.findfile("build.sh", current_dir)
	if build_script ~= "" then
		print("Found build.sh:", build_script)
	else
		print("build.sh not found in the current directory.")
	end
end

return M
