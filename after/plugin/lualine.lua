function ForceTransparency()
    vim.cmd([[
        hi StatusLine guibg=None ctermbg=None
        hi StatusLineNC guibg=None ctermbg=None
    ]])
end
ForceTransparency()

local auto = require('lualine.themes.auto')
auto.normal = {
    a = { fg = 'ffffff', bg = 'c44e43' },
    b = { fg = '000000', bg = 'd6cfc9' },
    c = { fg = 'ffffff', bg = 'None' },
}
auto.insert = {
    a = { fg = 'ffffff', bg = 'c44e43' },
    b = { fg = '000000', bg = 'd6cfc9' },
    c = { fg = 'ffffff', bg = 'None' },
}
auto.visual = {
    a = { fg = 'ffffff', bg = '5007d9' },
    b = { fg = '000000', bg = 'd6cfc9' },
    c = { fg = 'ffffff', bg = 'None' },
}
auto.replace = {
    a = { fg = 'ffffff', bg = 'bd6315' },
    b = { fg = '000000', bg = 'd6cfc9' },
    c = { fg = 'ffffff', bg = 'None' },
}
auto.command = {
    a = { fg = '000000', bg = 'd6cfc9' },
    b = { fg = '000000', bg = 'd6cfc9' },
    c = { fg = 'ffffff', bg = 'None' },
}
auto.inactive = {
    a = { fg = 'ffffff', bg = 'd6cfc9' },
    b = { fg = '000000', bg = 'd6cfc9' },
    c = { fg = 'ffffff', bg = 'None' },
}
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = auto,
        component_separators = { left = ' ', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 8, -- ~120fps
            events = {
                'WinEnter',
                'BufEnter',
                'BufWritePost',
                'SessionLoadPost',
                'FileChangedShellPost',
                'VimResized',
                'Filetype',
                'CursorMoved',
                'CursorMovedI',
                'ModeChanged',
            },
        }
    },
    sections = {
        lualine_a = {'mode', 'location'},
        lualine_b = {'branch', 'diff', 'diagnostics', 'filename', 'filetype'},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
