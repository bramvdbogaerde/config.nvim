Minimalistic Neovim Configuration
=================================

The aim of this repository is to provide a minimal Neovim configuration that is still suitable for daily development.
The configuration is minimal in that: 

- It uses as much built-in Neovim features as possible, for instance, we use the built-in package manager (i.e., vim.pack) and
the built-in autocompletion (no `nvim-cmp`).
- If Neovim does not provide the required functionality, use as few plugins as possible. In practice, this results in using plugins that offer a rich set of features.

The structure of this repository is straightforward:

- `lua/config/plugins.lua` contains the list of plugins, **without** their configuration
- `lua/config/plugins/` contains the configuration for each plugin as a seperate Lua file. All files in this directory get loaded automatically in lexographical order.
- `lua/lsp.lua` contains LSP configuration. It explicitly enables a set of programming languages that I personally use. It also sets up the LSP for autocompletion and contains some useful keybinds.
- `lua/keymap.lua` specifies alternative keybinds.

Features/what is included:

- Telescope support for fuzzy finding files in: opened buffers, the current workspace (as detected by an LSP or the closest Git repository), LSP symbols in the current workspace, and LSP symbols in the current buffer
- Support for showing diagnostics inline, as well as listing them in a Telescope picker. Default keybinds for navigating through diagnostics apply.
- Autocompletion triggered on any printable character.
- Code actions are displayed at the cursor's position using Telescope's 'cursor' theme.
- Arrow keys disabled in normal mode.
- Tree-sitter support for the languages enabled in the LSP.

Some keybinds are inherited from Helix:

- Enter visual line mode using 'x'
- Comment a line of code using "ctrl+c"

## Requirements

Neovim 0.12+
