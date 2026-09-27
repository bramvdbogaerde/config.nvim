-- Some utilities for Neovim's Multicursor support, packaged as our own multicursor 'plugin'.
local M = {}
local ns = vim.api.nvim_create_namespace("nvim.multicursor")

-- Constants 
LIMIT = 5

-- Returns all the multicursor marks associated with the current buffer
local function get_marks()
    local buf = vim.api.nvim_get_current_buf()
    return vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, {})
end

-- Get the position of the start of the current word
local function start_of_word()
    local pos = vim.fn.searchpos([[\<]], 'bcnW')
    pos[2] = pos[2] - 1
    return pos
end

-- Set the cursor in the current window to the given position
local function set_cursor(pos)
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, pos)
end

local function find_next_word(buf, word, row, col, limit)
    -- \V = literal match, \C = case-sensitive, \< \> = word boundaries
    local pat = [[\V\C\<]] .. vim.fn.escape(word, [[\]]) .. [[\>]]
    local line_count = vim.api.nvim_buf_line_count(buf)

    for r = row-1, math.min(row + limit, line_count - 1) do
        local line = vim.api.nvim_buf_get_lines(buf, r, r + 1, true)[1]
        local start = (r == row-1) and col + 1 or 0
        -- the 4th arg (count = 1) keeps \< aware of the chars before `start`
        local c = vim.fn.match(line, pat, start, 1)
        if c ~= -1 then
            return {r+1, c}
        end
    end
    return nil -- not found
end

-- Creates a multicursor on the current word (already active with the main cursor)
-- and the next matching word, at a next invocation the next word after the last
-- multicursor is selected.
function M.word_under_cursor()
    local buf = vim.api.nvim_get_current_buf()
    -- first compute all multicursor marks in the current buffer,
    -- they should be in file-order ...
    local all_marks = get_marks()
    -- ... so retrieving the last one is always valid, unless there
    -- are no marks yet.
    local last_pos = nil
    if #all_marks == 0 then
        -- if there are no marks, place the cursor at the start of the current word and 
        -- mark that as the first position
        last_pos = start_of_word()
        set_cursor(last_pos)
    else
        -- the last interesting position corresponds to the position of the 
        -- last mark.
        local last_mark = all_marks[#all_marks]
        last_pos = {last_mark[2]+1, last_mark[3]}
    end

    -- row and columns extraction
    local row = last_pos[1]
    local column = last_pos[2]
    -- we are interested in occurences of the word under cursor
    local word = vim.fn.expand("<cword>")
    -- skip the current word
    local next_column = column + #word
    local next_pos = find_next_word(buf, word, row, next_column, LIMIT)
    if next_pos ~= nil then
        vim.api.nvim_mcursor(buf, next_pos)
    end
end

-- Use CTRL+d to activate the feature both in insert and in normal mode
vim.keymap.set("i", "<C-d>", M.word_under_cursor)
vim.keymap.set("n", "<C-d>", M.word_under_cursor)

return M



