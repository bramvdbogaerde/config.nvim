-- This file sets up the Telescope plugin
local telescope = require('telescope')
local builtin   = require('telescope.builtin')
local loader    = require('loader')

telescope.setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = 'top'
		}
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_cursor()
		}
	}
})

------------------------------
-- Picker setup
------------------------------

-- Search in currently opened buffers
local function buffer_search()
	builtin.buffers( { sort_mru  = true } )
end

-- Find files in the project directory
--
-- See 'loader.find_root' for how the root directory is determined.
local function root_find_files()
	builtin.find_files( { cwd = loader.root } )
end

-- Search for symbols found by the LSP in the current buffer
local function lsp_symbols_current()
	builtin.lsp_document_symbols()
end

-- Search for symbols found by the LSP in the whole workspace
local function lsp_symbols_all()
	builtin.lsp_workspace_symbols()
end

-- Search for diagnostics reported by the LSP
local function lsp_diagnostic()
	builtin.diagnostics({ sort_by = "severity" })
end

-- Show all references to the code under cursor
local function lsp_references()
	builtin.lsp_references()
end

------------------------------
-- Setup keybinds
------------------------------

vim.keymap.set("n", "<Space>b", buffer_search)
vim.keymap.set("n", "<Space>f", root_find_files)
vim.keymap.set("n", "<Space>s", lsp_symbols_current)
vim.keymap.set("n", "<Space>S", lsp_symbols_all)
vim.keymap.set("n", "<Space>d", lsp_diagnostic)
vim.keymap.set("n", "gr", lsp_references)

------------------------------
-- Setup vim.ui.select integration
------------------------------

-- This replaces the default vim.ui.select with a Telescope interface
-- especially useful for rendering code actions
telescope.load_extension("ui-select")
