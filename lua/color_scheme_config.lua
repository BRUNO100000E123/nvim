require("tokyonight").setup({
    style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day", -- The theme is used when the background is set to light
    transparent = 'true', -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = { 
        comments = { fg = '#adadad', italic = true, bold=true },
        keywords = { italic = true, bold=true },
        functions = { bold=true },
        variables = { fg = '#ff8c00', bold=true },
	background = 'transparent',
        sidebars = "dark", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
    },
    sidebars = { "terminal", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false,
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) 
		-- highlights.TelescopeNormal = {
		-- 	bg = colors.bg_dark,
		-- 	fg = colors.fg_dark,
		-- }
		-- highlights.TelescopeBorder = {
		-- 	bg = colors.bg_dark,
		-- 	fg = colors.bg_dark,
		-- }
		-- highlights.TelescopePromptNormal = {
		-- 	bg = prompt,
		-- }
		-- highlights.TelescopePromptBorder = {
		-- 	bg = prompt,
		-- 	fg = prompt,
		-- }
		-- highlights.TelescopePromptTitle = {
		-- 	bg = prompt,
		-- 	fg = prompt,
		-- }
		-- highlights.TelescopePreviewTitle = {
		-- 	bg = colors.bg_dark,
		-- 	fg = colors.bg_dark,
		-- }
		-- highlights.TelescopeResultsTitle = {
		-- 	bg = colors.bg_dark,
		-- 	fg = colors.bg_dark,
		-- }
    end,
})

vim.cmd('colorscheme tokyonight')
