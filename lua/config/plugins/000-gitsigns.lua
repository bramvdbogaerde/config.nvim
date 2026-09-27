local gs = require('gitsigns')

-- Navigate to the next changed chunk
vim.keymap.set('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    gs.nav_hunk('next')
  end
end, { desc = 'Next git hunk' })

-- Navigate to the previous changed chunk
vim.keymap.set('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal({ '[c', bang = true })
  else
    gs.nav_hunk('prev')
  end
end, { desc = 'Previous git hunk' })
