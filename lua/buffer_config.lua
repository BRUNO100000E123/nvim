local opts = {noremap = true}
local map = vim.keymap.set
require("buffer_manager").setup({
  select_menu_item_commands = {
    v = {
      key = "<C-v>",
      command = "vsplit"
    },
    h = {
      key = "<C-h>",
      command = "split"
    },
    edit = {
        key = 'ee',
        command = 'edit'
    }
  },
  focus_alternate_buffer = false,
  short_file_names = true,
  short_term_names = true,
  loop_nav = false,
})

local bmui = require("buffer_manager.ui")

map({ 't', 'n' }, '<C-Space>', bmui.toggle_quick_menu, opts)
map('i', '<C-d>', bmui.nav_next, opts)
map('i', '<C-a>', bmui.nav_prev, opts)
