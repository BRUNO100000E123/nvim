Buffer_view_bookmarks_list = nil
Bookmarks_in_memory = {}
Connection_of_nicknames_and_paths = {}

function Split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

vim.api.nvim_set_keymap('n', 'dsa', ':lua Open_window_bookmarks_view()<CR>', {noremap = true, silent = true})

function Open_window_bookmarks_view()

    if Buffer_view_bookmarks_list == nil then

        Buffer_view_bookmarks_list = vim.api.nvim_create_buf(false, true)

        vim.api.nvim_buf_set_name(Buffer_view_bookmarks_list, "book_marks")

        -- vim.api.nvim_buf_set_keymap(Buffer, 'n', 'll', ':q!<CR>', { noremap = true, silent = true })
        -- vim.api.nvim_buf_set_keymap(Buffer, 'n', '<C-w>', ':q!<CR>', { noremap = true, silent = true })
        -- vim.api.nvim_buf_set_keymap(Buffer, 'n', 'dd', ':lua Delete_buffer()<CR>', { noremap = true, silent = true })
        -- vim.api.nvim_buf_set_keymap(Buffer, 'n', 'hh', ':lua Open_buffer()<CR>', { noremap = true, silent = true })

    end

    Reload_bookmarks_view()

    return vim.api.nvim_open_win(Buffer_view_bookmarks_list, true, {
        relative = 'editor',
        anchor = 'NW',
        width = 50,
        height = 50,
        row = 0,
        col = 0,
        focusable = true,
        border =  { '╭', "━" ,'╮', "┃", "╯", "━", "╰", "┃" },
    })

end

function Print_the_table()

    for key, value in pairs(Connection_of_nicknames_and_paths) do

        print('Size Bigger Dict: ' .. tostring(#Connection_of_nicknames_and_paths))

        print('Size Inner Dict: ' .. #value)

        for t1, t2 in pairs(value) do

            print('|t1: ' .. t1 .. ' |')

            print('|t2: ' .. t2 .. ' |')

            for d1, d2 in pairs(value[t1]) do

                print('|d1: ' .. d1 .. '|')

            end

        end

    end

end

function Reload_bookmarks_view()

    Bookmarks_in_memory = {
        '                    BookMarks                    ',
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    }

    local files = Split(Collect_bookmarks(), '|')

    for i, info in ipairs(files) do

        if i < #files then

            local temporary_dict = {}

            local folder_name = ''

            for l, item in ipairs(Split(info, '!')) do

                if l == 1 then

                    folder_name = item

                    table.insert(Bookmarks_in_memory, folder_name)

                    temporary_dict[folder_name] = {}

                else

                    local key, value = Split(item, ':')

                    temporary_dict[folder_name][key] = value

                end

            end

            for key, value in pairs(temporary_dict[folder_name]) do

                print('|KEY: ' .. key .. ' |VALUE: ' .. value .. ' |')

            end

            table.insert(Connection_of_nicknames_and_paths, temporary_dict)

        end

    end

    vim.api.nvim_buf_set_lines(Buffer_view_bookmarks_list, 0, -1, false, Bookmarks_in_memory)

end

function Reload_window_bookmarks_view()
    vim.cmd('highlight CursorLine guibg=#171717 guifg=#ca9dd7')
    vim.cmd('setlocal nonumber norelativenumber')
    vim.cmd('highlight CustomChar guifg=#7fcbd7')
    vim.cmd('syntax match CustomChar /./')
    vim.cmd('highlight link CustomChar SpecialChar')
end

vim.api.nvim_create_autocmd('BufEnter',
    {
        pattern = 'book_marks',
        command = 'lua Reload_window_bookmarks_view()'
    }
)

function Collect_bookmarks()
    local script = 'python3 /home/bruno/.config/nvim/python/garuda_json_tool.py "1"'
    local output = vim.fn.system(script)
    return output
end

function Create_folder()
    local user_input = vim.fn.input('Folder Name: ')
    local script = 'python3 /home/bruno/.config/nvim/python/garuda_json_tool.py "5" "' .. user_input .. '"'
    local output = vim.fn.system(script)
    vim.api.nvim_out_write(output)
end

function Update_folder()
    local user_input = vim.fn.input('Choose A New Name: ')
    local folder_name = 'TEST'
    local script = 'python3 /home/bruno/.config/nvim/python/garuda_json_tool.py "7"  "' .. folder_name .. '" "' .. user_input .. '"'
    local output = vim.fn.system(script)
    vim.api.nvim_out_write(output)
end

function Insert_new_bookmark()
    local user_input = vim.fn.input('Choose A Name For The Bookmark: ')
    local folder_name = 'Kart'
    local path = '/caminho/.pathzao'
    local script = 'python3 /home/bruno/.config/nvim/python/garuda_json_tool.py "4"  "' .. folder_name .. '" "' .. user_input .. '" "' .. path .. '"'
    local output = vim.fn.system(script)
    vim.api.nvim_out_write(output)
end
--
-- vim.api.nvim_set_keymap('n', 'asd', ':lua Create_folder()<CR>', {noremap = true, silent = true})
-- 1 -> Collect Stuff To Be Shown
-- 2 -> Delete Item From Folder
-- 3 -> Move Folders
-- 6 -> Delete Folder
--
-- DONE
--
-- 4 -> Insert New BookMarks (Id, Folder, BookMark's Nickname, Path)
-- 5 -> Insert New Folders (Id, Name)
-- 7 -> Update Folder (id, Old Name, New Name)
