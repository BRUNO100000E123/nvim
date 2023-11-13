require('functions')

Buffer_view_buffer_list = nil
Buffers_in_memory = {}

vim.api.nvim_set_keymap('n', '<C-w>', ':lua Open_window_buffers_view()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-a>', ':lua Cycle_behind()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-d>', ':lua Cycle_ahead()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-w>', '<Esc>:lua Open_window_buffers_view()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-a>', '<Esc>:lua Cycle_behind()<CR>i', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-d>', '<Esc>:lua Cycle_ahead()<CR>i', {noremap = true, silent = true})

function Cycle_behind()

    local buffer_name = ''

    Reload_window_buffers_view()

    for index, buffer in ipairs(Buffers_in_memory) do

        if tonumber(string.match(buffer, '(%d*) :')) == tonumber(vim.fn.bufnr('%')) and index == 3 then

            buffer_name = string.match(Buffers_in_memory[#Buffers_in_memory], '(%d*) :')

        elseif tonumber(string.match(buffer, '(%d*) :')) == tonumber(vim.fn.bufnr('%')) then

            buffer_name = string.match(Buffers_in_memory[(index - 1)], '(%d*) :')

        end

    end

    vim.cmd('b' .. buffer_name)

end

function Cycle_ahead()

    local buffer_name = ''

    Reload_window_buffers_view()

    for index, buffer in ipairs(Buffers_in_memory) do

        if tonumber(string.match(buffer, '(%d*) :')) == tonumber(vim.fn.bufnr('%')) and index == #Buffers_in_memory then

            buffer_name = string.match(Buffers_in_memory[3], '(%d*) :')

        elseif tonumber(string.match(buffer, '(%d*) :')) == tonumber(vim.fn.bufnr('%')) then

            buffer_name = string.match(Buffers_in_memory[(index + 1)], '(%d*) :')

        end

    end

    vim.cmd('b' .. buffer_name)

end

function Chosen_buffer()

    local line_number = vim.fn.line(".")

    return string.match(vim.api.nvim_buf_get_lines(vim.fn.bufnr('%'), line_number - 1, line_number, false)[1], '(%d*) :')

end

function Open_buffer()

    local buffer_number = Chosen_buffer()

    vim.cmd('q!')

    vim.cmd('b ' .. buffer_number)

end

function Delete_buffer()

    vim.cmd(':bdelete! ' .. Chosen_buffer())

    Reload_window_buffers_view()

end

function Open_window_buffers_view()

    if Buffer_view_buffer_list == nil then

        Buffer_view_buffer_list = vim.api.nvim_create_buf(false, true)

        vim.api.nvim_buf_set_name(Buffer_view_buffer_list, "buffers_view")

        vim.api.nvim_buf_set_keymap(Buffer_view_buffer_list, 'n', 'll', ':q!<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_buffer_list, 'n', '<C-w>', ':q!<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_buffer_list, 'n', 'dd', ':lua Delete_buffer()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_buffer_list, 'n', 'hh', ':lua Open_buffer()<CR>', { noremap = true, silent = true })

    end

    Reload_window_buffers_view()

    return vim.api.nvim_open_win(Buffer_view_buffer_list, true, {
        relative = 'editor',
        anchor = 'NW',
        width = 50,
        height = math.floor((vim.fn.winheight(0) * 0.6)),
        row = 0,
        col = 0,
        focusable = true,
        border =  { '╭', "━" ,'╮', "┃", "╯", "━", "╰", "┃" },
    })

end

function Diagnostics_buffer(buffer)

    local errossera = vim.diagnostic.get(buffer, { severity = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN
    } })

    local errors = 0
    local warnings = 0

    for _, diagnostic in ipairs(errossera) do

        if diagnostic.severity == 1 then
            errors = errors + 1
        elseif diagnostic.severity == 2 then
            warnings = warnings + 1
        end

    end

    if errors == 0 and warnings == 0 then

        return '⭐'

    else

        return tostring(errors) .. '‼️  ' .. tostring(warnings) .. '⚠️'

    end

end

function Reload_window_buffers_view()

    Buffers_in_memory = {
        '                      Buffers                     ',
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    }

    local buffers_info = vim.fn.getbufinfo({ buflisted = 1 })

    for _, info in ipairs(buffers_info) do

        local path = vim.fn.bufname(info.name)

        if path ~= nil and path ~= '' then

            local nome = Split(path, '/')

            if path ~= nil then
                table.insert(Buffers_in_memory, (' ' .. info.bufnr .. ' : ' .. nome[#nome] .. ' : ' .. Diagnostics_buffer(info.bufnr)))
            end

        end

    end

    vim.api.nvim_buf_set_lines(Buffer_view_buffer_list, 0, -1, false, Buffers_in_memory)

end

function Recolor_window_buffers_view()
    vim.cmd('highlight CursorLine guibg=#171717 guifg=#ca9dd7')
    vim.cmd('setlocal nonumber norelativenumber')
    vim.cmd('highlight CustomChar guifg=#7fcbd7')
    vim.cmd('syntax match CustomChar /./')
    vim.cmd('highlight link CustomChar SpecialChar')
    vim.cmd('hi FloatBorder guifg=#7fcbd7 ctermbg=235')
end

vim.api.nvim_create_autocmd('BufEnter',{pattern = 'buffers_view', command = 'lua Recolor_window_buffers_view()'})
