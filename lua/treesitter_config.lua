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
    },
    ensure_installed = {'java', 'lua', 'bash', 'python', 'javascript', 'vue'},
    context_commentstring = {
        enable = true,
        enable_autocmd = false
    }

})
