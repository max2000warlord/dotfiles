-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.neovide_opacity = 0.5
vim.g.markdown_fenced_languages = {
  "ts=typescript",
  "typescript",
  "javascript",
  "js=javascript",
  -- add other languages you use
}
