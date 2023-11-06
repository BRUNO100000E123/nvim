Path_global = '/home/bruno/dev/java/link-dev/microservicos/'

function Diagnostics_status_bar()

    local errossera = vim.diagnostic.get(0, { severity = {
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

    vim.opt.statusline = '%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}%5([%l/%L%)]%5p%%%=%y ' .. tostring(errors) .. '‼️  ' .. tostring(warnings) .. '⚠️  ' .. tostring(informations) .. 'ⓘ  ' .. tostring(hints) .. '💡  '  .. '  %-.30t'

end

function Find_name(microservice_name)

    local file = io.open('/home/bruno/dev/java/link-dev/microservicos/' .. microservice_name .. '/' .. microservice_name .. '-server/src/main/resources/application.yml', 'r')

    if file == nil then

       file = io.open('/home/bruno/dev/java/link-dev/microservicos/' .. microservice_name .. '/' .. microservice_name .. '-server/src/main/resources/application.properties', 'r')

    end

    if file ~= nil then

        for line in file:lines() do
 
            if string.match(line, '[^zqwsxcdrfvbgtyhjuiklop]name: ') then 

                return string.match(line, 'name: (.*)')
                
            end

        end

    else

        return nil

    end

end

function Push()
    
    local path = vim.api.nvim_buf_get_name(0)

    if string.find(path, 'microservicos') then

        local microservice_name = string.match(path, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*))')
        local application_name = Find_name(microservice_name)

        if(application_name ~= nil) then

            vim.cmd('cd /home/bruno/dev/java/link-dev/microservicos/' .. microservice_name .. '/')
            vim.cmd('vsplit')
            vim.cmd('vertical resize -60')
            vim.cmd(
                'term ./mvnw clean install -DskipTests ' ..
                '&& cd ' .. microservice_name .. '-server ' ..
                '&& ./mvnw spring-boot:build-image -DskipTests -Pnative -Dspring-boot.build-image.imageName=10.210.7.18:5000/' .. application_name .. ' ' ..
                '&& docker push 10.210.7.18:5000/' .. application_name .. ' ' .. 
                '&& docker rmi $(docker images -q 10.210.7.18:5000/' .. application_name .. ') --force ' ..
                '&& exit'
            )
        end

    end

end

function Build()

    local path = vim.api.nvim_buf_get_name(0)

    if string.find(path, 'microservicos') then

        local microservice_name = string.match(path, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*))')
        local application_name = Find_name(microservice_name)

        if(application_name ~= nil) then

            vim.cmd('cd /home/bruno/dev/java/link-dev/microservicos/' .. microservice_name .. '/')
            vim.cmd('vsplit')
            vim.cmd('vertical resize -60')
            vim.cmd(
                'term if [ -n "$(docker images -q ' .. application_name .. ')" ]; then ' ..
                'docker rmi $(docker images -q ' .. application_name .. ') --force; ' ..
                'fi ' ..
                '&& ./mvnw clean install -DskipTests ' ..
                '&& cd ' .. microservice_name .. '-server ' ..
                '&& ./mvnw spring-boot:build-image -DskipTests -Pnative -Dspring-boot.build-image.imageName=' .. application_name .. ' ' ..
                '&& docker run ' .. application_name
            )

        end

    end

end

function Run_dev()

    local path = vim.api.nvim_buf_get_name(0)

    if string.find(path, 'microservicos') and string.find(path, 'server') then

        vim.cmd('vsplit')
        vim.cmd('vertical resize -60')

        local name = string.match(path, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*))')

        local finalPath = 'term java -jar /home/bruno/dev/java/link-dev/microservicos/' .. name .. '/' .. name .. '-server/target/'

        for _, file in ipairs(vim.fn.readdir('/home/bruno/dev/java/link-dev/microservicos/' .. name .. '/' .. name .. '-server/target/')) do
            
            if(string.match(file, '.jar') and not(string.match(file, '.original'))) then

                finalPath = finalPath .. string.match(file, '(.*)')

            end

        end

        vim.cmd(finalPath)

    end

end

function Mvnw()
    
    local name = vim.api.nvim_buf_get_name(0)

    if string.find(name, 'microservicos') then
        
        vim.cmd('cd /home/bruno/dev/java/link-dev/microservicos/' .. string.match(name, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?))') .. '/')
        vim.cmd('vsplit')
        vim.cmd('vertical resize -60')
        vim.cmd('term ./mvnw clean install -DskipTests && exit')

    end

end

function LocalCommit()
    local commitMessage = vim.fn.input("Commit Message: ")
    print' '
    print'Are You Sure ?' 
    print'(1) Yes | (2) No'
    local commitVerification = vim.fn.input("Answer: ") == '1' and true or false
    if commitVerification then
        local path = vim.api.nvim_buf_get_name(0)    
        if path ~= nil then      
            -- vim.fn.termopen('svn commit -m ' .. ' "' .. commitMessage .. '" '  .. path)
        end
        print'Success'
    else 
        print' '
        print'Failure'
    end
end

function MicroservicesTree()

    local name = vim.api.nvim_buf_get_name(0)

    if string.find(name, 'microservicos') then

        Path_global = '/home/bruno/dev/java/link-dev/microservicos/' .. string.match(name, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?))') .. '/'

    else

        Path_global = '/home/bruno/dev/java/link-dev/microservicos/'

    end

    LocalTree()

end

function ConfigTree()

    Path_global = '/home/bruno/.config/nvim/'

    vim.cmd(':NvimTreeToggle ' .. Path_global)

end

function LocalTree()

    local name = vim.api.nvim_buf_get_name(0)

    if string.find(name, 'microservicos') then

        Path_global = '/home/bruno/dev/java/link-dev/microservicos/' .. string.match(name, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?))') .. '/'

    end

    vim.cmd(':NvimTreeToggle ' .. Path_global)

end
