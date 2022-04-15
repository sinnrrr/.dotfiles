require "options.alpha"
require "options.lualine"
require "options.notify"
require "options.nvimtree"
require "options.terminal"
require "options.treesitter"

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "tokyonight"

lvim.leader = ","
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.builtin.which_key.mappings["e"] = { "<cmd>Lf<cr>", "Explorer" }

lvim.lsp.diagnostics.float.focusable = true
lvim.lsp.float.focusable = true

vim.g.NERDTreeHijackNetrw = 0
vim.g.lf_replace_netrw = 1
vim.g.lf_map_keys = 0

vim.g.floaterm_title = ""
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 5,
            severity_limit = 'Warning',
        },
        update_in_insert = true,
    }
)