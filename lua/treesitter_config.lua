local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

vim.cmd('highlight MyJavaClass guifg=#00ff00')

parser_config.markdown = {
  -- your markdown parser configuration here
  -- ...
  highlight = {
    enable = true,
    disable = {},
  },
}

require('nvim-treesitter.configs').setup({
    sync_install = false,
    ignore_install = {''},
    highlight = {
        enable = true,
        disable = {''},
        additional_vim_regex_highlighting = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    refactor = {
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "def",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = '<a-*>',
                goto_previous_usage = '<a-#>'
            }
        },
        highlight_definitions = {
            enable = true
        },
    },    -- ensure_installed = {'java', 'lua', 'bash', 'python', 'javascript', 'vue'},
})
