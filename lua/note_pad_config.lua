require('functions')

vim.api.nvim_set_keymap('n', 'asd', '<Esc>:lua Open_window_note_pad()<CR>i', {noremap = true, silent = true})

Buffer_view_note_pad = nil
local path = '/home/bruno/.config/nvim/note_pad.txt'

function Open_window_note_pad()

    Buffer_view_note_pad = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(Buffer_view_note_pad, "note_pad")

    vim.api.nvim_buf_set_keymap(Buffer_view_note_pad, 'i', 'qq', '<Esc>:lua Write_to_file()<CR>', { noremap = true, silent = true })

    vim.api.nvim_buf_set_lines(Buffer_view_note_pad, 0, -1, false, Load_file())

    local window_width, window_height = 150, 50

    local screen_width, screen_height = vim.fn.winwidth(0), vim.fn.winheight(0)

    print('Window: ' .. tostring(window_width) .. ', ' .. tostring(window_height))
    print('Screen: ' .. tostring(screen_width) .. ', ' .. tostring(screen_height))

    vim.api.nvim_open_win(Buffer_view_note_pad, true, {
        relative = 'editor',
       -- anchor = 'NE',
        width = 150,
        height = 50,
        row = 14,
        col = 81,
        focusable = true,
        border =  { '╭', "━" ,'╮', "┃", "╯", "━", "╰", "┃" },
    })

end

function Test()

    local window_width, window_height = 150, 50

    local screen_width, screen_height = vim.fn.winwidth(0), vim.fn.winheight(0)

  
    print('Window: ' .. tostring(window_width) .. ', ' .. tostring(window_height))
    print('Screen: ' .. tostring(screen_width) .. ', ' .. tostring(screen_height))


end

function Write_to_file()

    local file = io.open(path, 'w')

    if file ~= nil then

        local lines = vim.api.nvim_buf_get_lines(Buffer_view_note_pad, 0, -1, true)

        vim.fn.writefile(lines, path)

    end

    vim.cmd('q!')

end

function Load_file()

    local file = io.open(path, 'r')

    local data = ''

    if file ~= nil then

        data = file:read('*a')

        file:close()

    end

    return Split(data, '\n')

end

function Modify_notepad_buffer()
    vim.wo.relativenumber = false
    vim.wo.number = true
    vim.wo.numberwidth = 3
end

vim.api.nvim_create_autocmd('BufEnter',{pattern = 'note_pad', command = 'lua Modify_notepad_buffer()'})
