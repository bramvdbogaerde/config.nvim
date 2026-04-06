local loader = require('loader')

require 'config/plugins'
loader.from_config_dir('config/plugins/')
require 'config/lsp'
require 'config/keymap'
require 'config/statusline'
require 'config/opts'
require 'config/commands'
loader.from_config_dir('config/languages/')
