-- nvim-treesitter configuration

local treesitter = require('nvim-treesitter')
local lsp        = require('config/lsp')

treesitter.install(lsp.languages)

for _, language in ipairs(lsp.languages) do
	vim.api.nvim_create_autocmd('FileType', {
		pattern = { language },
		callback = function() vim.treesitter.start() end,
	})
end

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
