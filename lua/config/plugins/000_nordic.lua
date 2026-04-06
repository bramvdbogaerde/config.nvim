local nordic = require("nordic")
nordic.setup({
    visual = {
        theme = "light"
    }
})

require('nordic').load()

-- Make the comments brighter so that they are easier to read
vim.api.nvim_set_hl(0, "Comment", { fg = "#7a8a9a", italic = true })
