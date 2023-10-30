function Python()
    local user_input = vim.fn.input('Folder Name: ')
    local script = 'python3 /home/bruno/.config/nvim/python/garuda_json_tool.py "' .. user_input .. '"'
    local output = vim.fn.system(script)
    vim.api.nvim_out_write(output)
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

vim.api.nvim_set_keymap('n', 'asd', ':lua Create_folder()<CR>', {noremap = true, silent = true})
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
