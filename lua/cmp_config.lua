local kind_icons = {
    Text = "♈",
    Method = "♉",
    Function = "♊",
    Constructor = "♋",
    Field = "♌",
    Variable = "♍",
    Class = "♍",
    Interface = "♍",
    Module = "♎",
    Property = "♏",
    Unit = "⦾",
    Value = "♑",
    Enum = "♒",
    Keyword = "♓",
    Snippet = "♐",
    Color = "⦿",
    File = "📰",
    Reference = "",
    Folder = "📁",
    EnumMember = "🍆",
    Constant = "∞",
    Struct = "🏗",
    Event = "🎉",
    Operator = "👨",
    TypeParameter = "🚀",
}

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['w'] = cmp.mapping.scroll_docs(-4),
        ['s'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['qq'] = cmp.mapping.abort(),
        ['ee'] = cmp.mapping.confirm({ select = true }),
        ['<S-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<S-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'jdtls'},
        { name = 'buffer' },
        { name = 'vsnip' },
    }),
    formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) 
        vim_item.menu = ({
        nvim_lsp = "[Lsp]",
        vimsnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        })[entry.source.name]
        return vim_item
    end,
    },
    confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
    experimental = {
        ghost_text = false,
        native_menu = false,
    },
})
