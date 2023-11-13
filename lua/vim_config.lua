local icons = require('nvim-web-devicons')
require('functions')

vim.g.mapleader = ' '
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.mouse = ""
vim.o.showmode = false
vim.wo.cursorline = true

vim.cmd("set relativenumber")
vim.cmd('highlight CursorLine guifg=#e3ff00 guibg=#f0f0f080')
vim.cmd('set laststatus=3')
vim.cmd('highlight StatusLine guifg=#7fcbd7 guibg=#f0f0f080')

vim.api.nvim_set_hl(0, 'LineNrAbove', {fg='#7fcbd7', bold = true})
vim.api.nvim_set_hl(0, 'LineNr', {fg='#857ebb', bold = true})
vim.api.nvim_set_hl(0, 'LineNrBelow', {fg='#ca9dd7', bold = true})

vim.opt.statusline = '%-5{v:lua.string.upper(v:lua.vim.fn.mode())} [%l/%L] [%p%%] %M %= %-10{v:lua.Diagnostics_status_bar()} %= %-5{v:lua.File_status_line()}'

vim.cmd('highlight CustomErrorIconHighlight guifg=#ff0000')
vim.cmd('syntax match CustomErrorIconMatcher //')
vim.cmd('highlight link CustomErrorIconMatcher CustomErrorIconHighlight')


function File_status_line()

    local type = vim.api.nvim_buf_get_option(0, 'filetype')
    local name = vim.fn.expand('%:t')

    if type ~= nil then

        local icon = icons.get_icon('a', type)

        if icon ~= nil then

            type = string.upper(type) .. ' ' .. icon

        end


    end

    if name ~= nil then

        local clean_name = Split(name, '.')[1]

        if clean_name ~= nil then

            name = clean_name

        end

    end

    if name ~= nil and type ~= nil then

        return (type .. ' | ' .. name)

    elseif name ~= nil then

        return name

    elseif type ~= nil then

        return type

    else 

        return ''

    end


end

function Change_to_tree_color()

    vim.cmd('highlight CursorLine guifg=#e3ff00 guibg=#1C00FF')

end

function Change_status_line_color()

    local mode = vim.fn.mode()

    if mode == 'n' then
        vim.cmd('highlight statusline guibg=#f0f0f010 guifg=#7fcbd7')
        vim.cmd('highlight CursorLine guibg=#171717 guifg=#7fcbd7')
    elseif mode == 'i' then
        vim.cmd('highlight statusline guibg=#f0f0f010 guifg=#ca9dd7')
        vim.cmd('highlight CursorLine guibg=#171717 guifg=#ca9dd7')
    elseif mode == 'v' or mode == 'V' or mode == '^V' then
        vim.cmd('highlight statusline guibg=#f0f0f080 guifg=#ca9dd7')
    else
        vim.cmd('highlight statusline guibg=#f0f0f080 guifg=#CE313A')
    end

end

vim.api.nvim_create_autocmd('ModeChanged', {command = 'lua Change_status_line_color()'})
vim.api.nvim_create_autocmd('BufEnter',
    {
        pattern = 'NvimTree_1',
        command = 'highlight CursorLine guifg=#e3ff00 guibg=#1C00FF'
    }
)

vim.cmd('highlight Number guifg=#90ee90')
vim.cmd('highlight Boolean guifg=#90ee90')
vim.cmd('highlight Float guifg=#90ee90')
vim.cmd('highlight Constant guifg=#90ee90')
vim.cmd('highlight String guifg=#90ee90')
vim.cmd('highlight Type guifg=#48d1cc')

vim.cmd('sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=')
vim.cmd('sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=')
vim.cmd('sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=')
vim.cmd('sign define DiagnosticSignHint text=󰌵 texthl=DiagnosticSignHint linehl= numhl=')
