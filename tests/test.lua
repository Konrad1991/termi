-- https://teukka.tech/vimloop.html
local loop = vim.loop
local api = vim.api

function asyncBuild()
	local stdout = loop.new_pipe(false)
	local stderr = loop.new_pipe(false)

	local stdio = nil
	handle = loop.spawn(
		"./build.sh",
		{
			stdio = { nil, stdout, stderr },
		},
		vim.schedule_wrap(function()
			stdout:read_stop()
			stderr:read_stop()
			stdout:close()
			stderr:close()
			handle:close()
		end)
	)

	local function callback(data)
		vim.print(data)
	end

	local outputTable = {}

	local function displayOutput(err, data)
		if err then
			print("Error:", err)
			return
		end
		if data then
			local lines = vim.split(data, "\n")

			for _, line in ipairs(lines) do
				table.insert(outputTable, line)
			end

			print("Current output:")
			for _, line in ipairs(outputTable) do
				print(line)
			end
			--vim.append(0, "test")
		end
	end
	loop.read_start(stdout, displayOutput)
	loop.read_start(stderr, displayOutput)
end

asyncBuild()
-- vim.cmd("vertical copen")
