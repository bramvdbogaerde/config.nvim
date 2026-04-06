-- Prelude

-- Prefix a plugin definition with a particular source
local function prefix(the_prefix, plugin)
	if type(plugin) == 'string' then 
		-- If the dependency is given as string
		-- use that string as its name
		return the_prefix .. plugin
	elseif type(plugin) == 'table' then
		-- Otherwise it is a table with a 'src' 
		-- field and we only update that field and
		-- return the other fields unmodified.
		plugin.src = the_prefix .. plugin.src
		return plugin
	else
		error("String or table expected got " .. type(plugin))
	end
end

-- Fetch a plugin from Github
local function gh(plugin)
	return prefix("https://github.com/", plugin)
end

-- Loading and activating plugins

vim.pack.add({
	-- 'Standard library' for Neovim Lua
	gh({ src = 'nvim-lua/plenary.nvim' }),
	-- Table-like interface for navigating the project (LSP, fuzzy file browsing, ..)
	gh({ src = 'nvim-telescope/telescope.nvim' }),
	-- Drop-down code actions (i.e., for vim.ui.select)
	gh({ src = 'nvim-telescope/telescope-ui-select.nvim' }),
	-- Frequently used LSP configurations
	gh({ src = 'neovim/nvim-lspconfig' }),
	-- Tree-sitter, still required as it provides easy installation of grammars
	-- as well as queries. Hopefully these queries get upstreamed
	-- at some point to or get a similar treatment as the nvim-lspconfig.
	gh({ src = "nvim-treesitter/nvim-treesitter" }),
	-- Theme
	gh({ src = "AlexvZyl/nordic.nvim" })
})

