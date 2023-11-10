local actions = require("telescope.actions")

require('telescope').setup({

    defaults = {
        mappings = {
            i = {
                ["qq"] = actions.close,
                ["ww"] = actions.preview_scrolling_up,
                ["ss"] = actions.preview_scrolling_down
            },
        }
    },
    project = {
        base_dirs = { '/home/bruno/dev/java/link-dev/microservicos/', '/home/bruno/.config/nvim/' }
    }

})
