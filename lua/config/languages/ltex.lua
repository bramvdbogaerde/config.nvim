-- Functionality to persists words per language
local dict_dir = vim.fn.stdpath("data") .. "/ltex"
vim.fn.mkdir(dict_dir, "p")

local function dict_file(lang)
  return dict_dir .. "/dictionary." .. lang .. ".txt"
end

local function load_dict(lang)
  local f = dict_file(lang)
  return vim.fn.filereadable(f) == 1 and vim.fn.readfile(f) or {}
end

vim.lsp.commands["_ltex.addToDictionary"] = function(command, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local s = client.settings or client.config.settings
  s.ltex = s.ltex or {}
  s.ltex.dictionary = s.ltex.dictionary or {}
  for lang, words in pairs(command.arguments[1].words) do
    s.ltex.dictionary[lang] = s.ltex.dictionary[lang] or {}
    vim.list_extend(s.ltex.dictionary[lang], words)
    vim.fn.writefile(words, dict_file(lang), "a") -- append to file
  end
  client:notify("workspace/didChangeConfiguration", { settings = s })
end

vim.lsp.config("ltex_plus", {
  settings = {
    ltex = {
      language = "en-US",
      dictionary = { ["en-US"] = load_dict("en-US") },
    },
  },
})
vim.lsp.enable("ltex_plus")
