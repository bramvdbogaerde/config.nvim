------------------------------
-- Custom commands
------------------------------

-- Easy shortcut to formatting
vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format({ async = true })
end, {})

vim.cmd("cabbrev format Format")

-- Shortcut to create directories for a file if they
-- do not exist yet.
vim.api.nvim_create_user_command("Wd", function()
  local path = vim.fn.expand("%:p:h")
  vim.fn.mkdir(path, "p")
  vim.cmd("write")
end, {})

vim.cmd("cabbrev wd Wd")
