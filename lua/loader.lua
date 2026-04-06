-- Custom file loading functions
local M = {}

-- Enumerate all files in 'dir' and load 
-- them in lexographical order
local function from_dir(dir)
	-- already sorted lexicographically
	local files = vim.fn.readdir(dir)

	for _, filename in ipairs(files) do
		local path = dir .. "/" .. filename
		if vim.fn.isdirectory(path) == 0 then  -- skip directories
			local chunk, err = loadfile(path)
			if chunk then
				chunk()
			else
				vim.notify("Error loading " .. filename .. ": " .. err, vim.log.levels.ERROR)
			end
		end
	end
end

-- Same as 'fromDir' but prefixes the path to Neovim's
-- config directory
local function from_config_dir(dir) 
	from_dir(vim.fn.stdpath("config") .. "/lua/" .. dir)
end

-- The project' directory is found as follows:
-- * The current directory if it contains a ".helix" file.
-- * The root directory according to the currently
-- used LSP, selects the first if multiple LSPs are active.
-- * The closest ".git" directory as returned by 
-- `git $PWD rev-parse --show-toplevel`.
-- * The current working directory.
local function find_root(cwd)
	cwd = cwd or vim.fn.getcwd()

	if vim.fn.filereadable(cwd .. "/.helix") == 1 then
		return cwd
	end

	local clients = vim.lsp.get_clients({ bufnr = 0 })
	for _, client in ipairs(clients) do
		if client.config.root_dir then
			return client.config.root_dir
		end
	end

	local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(cwd) .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error == 0 and git_root then
		return vim.trim(git_root)
	end

	return cwd
end


M.from_dir = from_dir
M.from_config_dir = from_config_dir
M.find_root = find_root
return M
