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

vim.opt.statusline = '%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}%5([%l/%L%)]%5p%% %-m %= 0‼️  0⚠️  0ⓘ  0💡 %y %-.30t'

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

vim.api.nvim_create_autocmd('BufWrite', {command = 'lua Diagnostics_status_bar()'})
vim.api.nvim_create_autocmd('ModeChanged', {command = 'lua Change_status_line_color()'})
vim.api.nvim_create_autocmd('BufEnter',
    {
        pattern = 'NvimTree_1',
        command = 'highlight CursorLine guifg=#e3ff00 guibg=#1C00FF'
    }
)
