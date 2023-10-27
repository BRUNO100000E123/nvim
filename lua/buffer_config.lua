Buffer = nil
Buffers_in_memory = {}

vim.api.nvim_set_keymap('i', '<C-w>', '<Esc>:lua Open_window()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-w>', ':lua Open_window()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-a>', ':lua Cycle_behind()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-d>', ':lua Cycle_ahead()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-a>', '<Esc>:lua Cycle_behind()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-d>', '<Esc>:lua Cycle_ahead()<CR>', {noremap = true, silent = true})

function Cycle_behind()
    
    Reload()

    vim.cmd('b ' .. (function ()

        for index, buffer in ipairs(Buffers_in_memory) do

            if tonumber(string.match(buffer, '(%d*) :')) == tonumber(vim.fn.bufnr('%')) and index == 1 then
                
                return string.match(Buffers_in_memory[#Buffers_in_memory], '(%d*) :')

            elseif tonumber(string.match(buffer, '(%d*) :')) == tonumber(vim.fn.bufnr('%')) then
        
                return string.match(Buffers_in_memory[(index - 1)], '(%d*) :')

            end

        end
        
    end))
    
end

function Cycle_ahead()

    Reload()

    vim.cmd('b ' .. function ()
        
        for index, buffer in ipairs(Buffers_in_memory) do
        
            if tonumber(string.match(buffer, '(%d*) :')) == tonumber(vim.fn.bufnr('%')) and index == #Buffers_in_memory then
                
                return '1'
    
            elseif tonumber(string.match(buffer, '(%d*) :')) == tonumber(vim.fn.bufnr('%')) then
        
                return string.match(Buffers_in_memory[(index + 1)], '(%d*) :')
    
            end
    
        end

    end)
    
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

    vim.cmd(':bdelete ' .. Chosen_buffer())

    Reload()

end

function Open_window()

    if Buffer == nil then

        Buffer = vim.api.nvim_create_buf(false, true)

        vim.api.nvim_buf_set_name(Buffer, "buffers_view")

        vim.api.nvim_buf_set_keymap(Buffer, 'n', 'll', ':q!<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer, 'n', '<C-w>', ':q!<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer, 'n', 'dd', ':lua Delete_buffer()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer, 'n', 'hh', ':lua Open_buffer()<CR>', { noremap = true, silent = true })

    end

    Reload()

    return vim.api.nvim_open_win(Buffer, true, {
        relative = 'editor',
        width = 50,
        height = 50,
        row = 1,
        col = vim.fn.winwidth(0) - 40,
        focusable = true,
        style = 'minimal',
        border = 'double',
    })

end

function Diagnostics_buffer(buffer)

    local errossera = vim.diagnostic.get(buffer, { severity = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
        vim.diagnostic.severity.INFO,
        vim.diagnostic.severity.HINT
    } })

    local errors = 0
    local warnings = 0
    local informations = 0
    local hints = 0

    for _, diagnostic in ipairs(errossera) do

        if diagnostic.severity == 1 then
            errors = errors + 1
        elseif diagnostic.severity == 2 then
            warnings = warnings + 1
        elseif diagnostic.severity == 3 then
            informations = informations + 1
        elseif diagnostic.severity == 4 then
            hints = hints + 1
        end

    end

    if errors == 0 and warnings == 0 and informations == 0 and hints == 0 then

        return '⭐'

    else

        return tostring(errors) .. '‼️  ' .. tostring(warnings) .. '⚠️  ' .. tostring(informations) .. 'ⓘ  ' .. tostring(hints) .. '💡'

    end

end

function Reload()

    Buffers_in_memory = {}

    local buffers_info = vim.fn.getbufinfo({ buflisted = 1 })

    for _, info in ipairs(buffers_info) do

        local buffer_name = string.match(vim.fn.bufname(info.name), '/(%w*)([_]*)(%w*)%.')

        if buffer_name ~= nil then
            table.insert(Buffers_in_memory, (' ' .. info.bufnr .. ' : ' .. buffer_name .. ' : ' .. Diagnostics_buffer(info.bufnr)))
        end

    end

    vim.api.nvim_buf_set_lines(Buffer, 0, -1, false, Buffers_in_memory)
    
end