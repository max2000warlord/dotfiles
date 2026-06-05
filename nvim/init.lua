-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.clipboard = "osc52"
vim.opt.clipboard = "unnamedplus"
require("config.lazy")
require("neo-tree").setup({
  window = {
    position = "right",
  },
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },

    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        -- "node_modules",
      },
      always_show = {
        ".gitignore",
        ".env",
      },
      never_show = {
        -- ".DS_Store",
        -- "thumbs.db",
      },
      never_show_by_pattern = {
        -- ".null-ls_*",
      },
    },
  },
  git_status = { enable = false },
})
-- Temporarily disable all formatting on save for Zig files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zig",
  callback = function()
    vim.bo.formatprg = ""
    vim.bo.formatexpr = ""
    -- Disable format on save if you have it enabled
    vim.g.zig_fmt_autosave = 0
  end,
})

require("colorizer").setup()
