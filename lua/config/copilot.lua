-- Copilot support 
-- requires running ":LspCopilotSignIn" before use

----------------------------------------
-- Static configuration
----------------------------------------

-- List of files that have copilot enabled automatically
local auto_copilot = { "python" }

----------------------------------------------------------------
-- Dynamic loading for buffers of the `auto_copilot` type 
-- and command to manually enable the LSP for that buffer
----------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        local filetype = ev.match
        if vim.tbl_contains(auto_copilot, filetype) then
            vim.lsp.start({ name = "copilot" })
        end
    end
})

vim.api.nvim_create_user_command("Copilot", function()
    vim.lsp.start(vim.lsp.config.copilot)
end, {})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "copilot" then
        vim.lsp.inline_completion.enable()
        vim.keymap.set("i", "<C-y>", vim.lsp.inline_completion.get, { buffer = ev.buf })
    end
  end
})

