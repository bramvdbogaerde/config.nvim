
-- Render the status of the LSP to the statusline
---@diagnostic disable-next-line: unused-function, unused-local
function lsp_status()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then return "⚫" end

    local progress = vim.lsp.status()  -- shows indexing progress if active
    if progress and progress ~= "" then
        return "⏳"
    end

    return "🟢"
end

vim.opt.statusline = "%m %f %= %l:%c %{%v:lua.lsp_status()%}"
