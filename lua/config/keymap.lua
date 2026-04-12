-- Global keymap configuration 
-- 
-- Plugin-specific configuration can be found 
-- in the specific plugin configuration directory
-- in 'config/plugins'.
--
-- This file is loaded after plugins have been setup
-- so plugin specific functionality can also be used here.

-- Disable arrow keys in normal mode
for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
    vim.keymap.set("n", key, "<Nop>")
end

-- Helix-inspired: make the 'x' key in normal mode select the entire line
-- and if already selected, moves onto the proceeding line.
vim.keymap.set("n", "x", "V", { desc = "Select line and activate visual line mode." })
vim.keymap.set("x", "x", "j", { desc = "Extend selection to next line" })
vim.keymap.set("x", "X", "k", { desc = "Reduce selection to previous line" })

-- Comment lines using "ctrl+c" both in visual and normal mode
vim.keymap.set("n", "<C-c>", "gcc", { remap = true })
vim.keymap.set("v", "<C-c>", "gc", { remap = true })

-- Redo using Shift+u
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo previous undo" })
