-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set("n", "<Esc>", function()
  local win = vim.api.nvim_get_current_win()
  local config = vim.api.nvim_win_get_config(win)
  if config.relative ~= "" then -- Check if it's a floating window
    vim.api.nvim_win_close(win, false)
  end
end, { noremap = true, silent = true })
