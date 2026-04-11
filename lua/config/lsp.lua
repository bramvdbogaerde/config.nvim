--------------------------------------------------
-- General LSP options
--------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		-- Auto completion options if the server supports it
		if client:supports_method('textDocument/completion') then
			-- Enable auto completions on every printable character (i.e., range 32-126)
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars

			vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
				autotrigger = true,
			})

			-- Use <Tab> for confirming the first autocomplete option
			vim.keymap.set("i", "<Tab>", function()
				-- Only accept the <Tab> for confirming if the autocompletion
				-- menu was triggered and an option was selected.
				if vim.fn.complete_info().pum_visible == 1 then
					-- Only select the first one if none was selected
					if vim.fn.complete_info().selected ~= -1 then
						return "<C-y>"
					else
						return "<C-n><C-y>"
					end
				end
				return "<Tab>"
			end, { expr = true })
		end

		-- Disable comitting to the first item by default
		vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

	end,
})

--------------------------------------------------
-- List of supported LSP with their configuration
--------------------------------------------------

-- Lua
vim.lsp.enable('lua_ls')
vim.lsp.config("lua_ls", {
	on_attach = function(client)
		-- The token provider in the Lua Language Server is **very slow** compared
		-- to the builtin Lua plugin, so disable it.
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

-- Go
vim.lsp.enable('gopls')

-- Rust 
vim.lsp.enable('rust_analyzer')

-- Haskell
vim.lsp.enable('hls')

-- Typescript
vim.lsp.enable('ts_ls')

-- Jsonnet
vim.lsp.enable('jsonnet_ls')

-- Zig 
vim.lsp.enable('zls')

------------------------------
-- Diagnostics
------------------------------

vim.diagnostic.config({ virtual_text = true })

------------------------------
-- Lsp specific keymaps
------------------------------

-- Go-to tools
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
-- Show type hint (i.e., hover)
vim.keymap.set("n", "<Space>k",  vim.lsp.buf.hover, { desc = "Hover docs" })
-- Execute code action
vim.keymap.set("n", "<Space>a", vim.lsp.buf.code_action)
-- Rename identifier under the cursor
vim.keymap.set("n", "<Space>r", vim.lsp.buf.rename);

------------------------------
-- Usage as a module
------------------------------

return {
	-- List of languages an LSP is enabled for
	languages = { "rust", "lua", "haskell", "typescript", "jsonnet", "zig" }
}
