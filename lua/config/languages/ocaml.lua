-- Change the color of delimiters in the Nordic theme to be more visible

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ocaml",
  callback = function(_)
    local ns = vim.api.nvim_create_namespace("ocaml_highlights")
    vim.api.nvim_set_hl(ns, "Delimiter", { fg = "#7a8a9a" })
    vim.api.nvim_win_set_hl_ns(0, ns)
  end,
})
