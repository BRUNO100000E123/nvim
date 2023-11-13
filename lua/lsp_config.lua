require('mason').setup({})
require('mason-lspconfig').setup({})

local lsp_config = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp_config.bashls.setup({capabilities = capabilities,})
lsp_config.lemminx.setup({capabilities = capabilities,})
lsp_config.biome.setup({capabilities = capabilities,})
lsp_config.pyright.setup({capabilities = capabilities,})
lsp_config.volar.setup({capabilities = capabilities,})
lsp_config.clangd.setup({capabilities = capabilities,})

lsp_config.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = {"vim"},  -- Set globals to make vim variable available to LSP
            },
        }
    },
})

local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
os.execute("mkdir " .. workspace_dir)

lsp_config.jdtls.setup({
    capabilities = capabilities,
    cmd = {
        '/usr/lib/jvm/java-21-openjdk-amd64/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:/home/bruno/.local/share/java/lombok.jar',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', '/home/bruno/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
        '-configuration', '/home/bruno/.local/share/nvim/mason/packages/jdtls/config_linux',
        '-data', workspace_dir,
    },
    setting = {
        java = {
            home = '/usr/lib/jvm/java-21-openjdk-amd64/bin/',
            eclipse = {
                downloadSources = true,
              },
              maven = {
                downloadSources = true,
             },
              implementationsCodeLens = {
                enabled = true,
              },
              referencesCodeLens = {
                enabled = true,
              },
              references = {
                includeDecompiledSources = true,
              },
              format = {
                enabled = true,
                settings = {
                  url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
                  profile = "GoogleStyle",
                },
              },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
            importOrder = {
                "java",
                "javax",
                "com",
                "org"
            },
        },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            package = {
                template = 'Hi there'
            },
            useBlocks = true,
            },
        },
    flags = {
        allow_incremental_sync = true,
    },
    init_options = {
        bundles = {
            vim.fn.glob('/home/bruno/Downloads/java-debug-main/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.50.0.jar')
        },
    },
})
