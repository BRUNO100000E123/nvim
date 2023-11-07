vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.cmd('highlight NvimTreeNormal guibg=#f0f0f080')

local function keymap_config(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', 'l', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
  vim.keymap.set('n', 'h', api.node.open.edit, opts('Open'))

  api.config.mappings.default_on_attach(bufnr)
end

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  on_attach = keymap_config,
  actions = {
    open_file = {
      quit_on_open = true,
      eject = true,
      resize_window = true,
      window_picker = {
        enable = true,
        picker = "default",
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    }
  },
  renderer = {
    root_folder_modifier = ":t",
    group_empty = true,
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      web_devicons = {
        file = {
          enable = true,
          color = true,
        },
        folder = {
          enable = true,
          color = true,
        },
      },
      glyphs = {
        default = "📄",
        symlink = "B",
        folder = {
          arrow_open = "🗃",
          arrow_closed = "🗄",
          default = "🗂",
          open = "📂",
          empty = "📁",
          empty_open = "📂",
          symlink = "I",
          symlink_open = "J",
        }
      }
    --     git = {
    --       unstaged = "🔴",
    --       staged = "🟡",
    --       unmerged = "🟢",
    --       renamed = "R",
    --       untracked = "N",
    --       deleted = "O",
    --       ignored = "I",
    --     },
    --   },
    },
  },
  -- diagnostics = {
  --   enable = true,
  --   show_on_dirs = true,
  --   icons = {
  --     hint = "🔵",
  --     info = "🟣",
  --     warning = "🟡",
  --     error = "🔴",
  --   },
  -- }, 
  view = {
    width = 40,
    side = "left",
  },
  filters = {
    dotfiles = true,
  },
})
