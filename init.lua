vim.g.have_nerd_font = true

vim.o.mouse = ""

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "\\.vim\\undodir"
vim.o.undofile = true

vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = '·', nbsp = '␣' }

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.number = true
vim.o.relativenumber = true

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.signcolumn = 'auto:1-4'

vim.o.updatetime = 50

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.cursorline = false

vim.o.scrolloff = 10

-- Vertical line 90 characters to the right
-- vim.opt.cc = {90}

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.inccommand = 'split'

vim.o.modeline = false
vim.o.winborder = 'rounded'
vim.o.laststatus = 3

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.o.ww = 'h,l,<,>,[,]'

vim.opt.shadafile="NONE"

--[[
--  SECT: Plugins
--]]

vim.pack.add({
    {
        src = 'https://github.com/seblyng/roslyn.nvim',
        name = 'roslyn',
    },
    {
        src = 'https://github.com/nvim-flutter/flutter-tools.nvim',
        name = 'flutter-tools',
    },
    {
        src = 'https://github.com/navarasu/onedark.nvim',
        name = 'onedark',
    },
    {
        src = 'https://github.com/neovim/nvim-lspconfig',
        name = 'nvim-lspconfig',
    },
    {
        src = 'https://github.com/hrsh7th/nvim-cmp',
        name = 'nvim-cmp',
    },
    {
        src = 'https://github.com/hrsh7th/cmp-buffer',
        name = 'cmp-bufffer',
    },
    {
        src = 'https://github.com/hrsh7th/cmp-nvim-lsp',
        name = 'cmp-nvim-lsp',
    },
    {
        src = 'https://github.com/VonHeikemen/lsp-zero.nvim',
        name = 'lsp-zero',
    },
    {
        src = 'https://github.com/L3MON4D3/LuaSnip',
        name = 'luasnip',
    },
    {
        src = 'https://github.com/williamboman/mason.nvim',
        name = 'mason',
    },
    {
        src = 'https://github.com/williamboman/mason-lspconfig.nvim',
        name = 'mason-lspconfig',
    },
    {
        src = 'https://github.com/theprimeagen/harpoon',
        name = 'harpoon',
    },
    {
        src = 'https://github.com/lewis6991/gitsigns.nvim',
        name = 'gitsigns',
    },
    {
        src = 'https://github.com/echasnovski/mini.nvim',
        name = 'mini',
    },
    {
        src = 'https://github.com/nvim-tree/nvim-web-devicons',
        name = 'nvim-web-devicons',
    },
    {
        src = "https://github.com/folke/which-key.nvim",
        name = 'which-key',
        lazy = false
    },
    {
        src = "https://github.com/folke/todo-comments.nvim",
        name = 'todo-comments',
        opts = {},
    },
    {
        src = 'https://github.com/nvim-telescope/telescope.nvim',
        name = 'telescope',
        tag = '0.1.8',
    },
    {
        src = 'https://github.com/nvim-lua/plenary.nvim',
        name = 'plenary',
    },
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        name = 'nvim-treesitter',
    },
    {
        src = 'https://github.com/nvim-lualine/lualine.nvim', dependencies = { 'https://github.com/nvim-tree/nvim-web-devicons' }
    },
    {
        src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim',
        name = 'render-markdown'
    },
    {
        src = 'https://github.com/sudo-tee/opencode.nvim',
        name = 'opencode'
    },
})

local ts_parsers = {
    'c', 'cpp',
    'lua', 'vim',
    'markdown',
    'json', 'toml', 'yaml',
}
local nts = require('nvim-treesitter')
nts.install(ts_parsers)
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function()
        nts.update()
    end
})

vim.api.nvim_create_autocmd("FileType", { -- enable treesitter highlighting and indents
    callback = function(args)
        local filetype = args.match
        local lang = vim.treesitter.language.get_lang(filetype)
        if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start()
        end
    end
})

require('mason').setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    }
})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here 
    -- with the ones you want to install
    ensure_installed = {
        'clangd', --dependency: unzip       -- C, C++, Fortran, etc.
        --'cmake',                            -- Cmake
        'zls',                              -- Zig LSP
        --'rust_analyzer',                    -- Rust LSP
        'mesonlsp',                         -- Meson LSP
        --'pylsp',                            -- Python LSP
        'ts_ls',                            -- Typescript LSP (Requires NPM)
        'lua_ls',                           -- Lua LSP
        'html',                             -- HTML LSP
        'cssls',                            -- CSS LSP
        'bashls',                           -- Bash LSP
        --'java_language_server',             -- Java LSP (requires jlink and i don't feel like figuring out where that resides)
    },

    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
    automatic_installation = true,
})

require('lsp-zero').extend_lspconfig({
  sign_text = true,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

local cmp = require('cmp')
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
  mapping = cmp.mapping.preset.insert({}),
})

require('todo-comments').setup ({
    keywords = {
        SECTION = {
            icon =  "§ ",
            color = "#93E9BE",
            alt = {"SECT", "BREAK"}
        }
    }
})

require('onedark').setup  {
    -- Main options --
    style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true,  -- Show/hide background
    term_colors = false, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'italic',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = true, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {
        -- Override default colors
        --[[
        yellow_orange = '#d9b816',
        orange = '#d49633',
        dank_orange = '#d972223',
        danker_orange = '#a74825',
        shiny_green = '#81e3a2',
        green = '#05b03e',
        cyan = '#22bdad',
        shlue = '#2fcfdf',
        purple = '#8143ba',
        eggshell_white = '#e8e5d8',
        light_gray = '#dedede',
        lightish_gray = '#94908a',
        gray = '#e8e5d8', -- Same as eggshell_white
        black = '#000000',
        ]]
    },
    highlights = {
        --[[
        -- Override highlight groups
        -- Language Keyword
        ['@lsp.type.keyword'] = {fg = '$purple'},
        ['@lsp.type.operator'] = { fg = '$eggshell_white' },

        -- Type and Type-likes
        ['@lsp.type.class'] = { fg = '$orange' },
        ['@lsp.type.struct'] = { fg = '$orange' },
        ['@lsp.type.type'] = { fg = '$orange' },
        ['@lsp.type.typeParameter'] = { fg = '$orange' },
        ['@lsp.type.enum'] = { fg = '$orange' },
        ['@lsp.type.enumMember'] = { fg = '$dank_orange' },
        ['@lsp.type.interface'] = { fg = '$shiny_green' },
        ['@lsp.type.namespace'] = { fg = 'danker_orange' },

        -- Functions
        ['@lsp.type.function'] = { fg = '$shlue' },
        ['@lsp.type.method'] = { fg = 'shlue' },
        ['@lsp.type.number'] = { fg = 'yellow_orange' },
        ['@lsp.type.macro'] = { fg = '$danker_orange' },

        -- Primitives (Idk what to call this collection)
        ['@lsp.type.variable'] = { fg = '$light_gray' },
        ['@lsp.type.string'] = { fg = '$green' },
        ['@lsp.type.comment'] = { fg = '$eggshell_white' },

        ['@lsp.type.decorator'] = { fg = '$eggshell_white' },
        --['@lsp.type.event'] = { fg = '' },
        ['@lsp.type.modifier'] = { fg = 'orange' },
        --['@lsp.type.parameter'] = { fg = '' },
        ['@lsp.type.property'] = { fg = 'danker_orange' },
        --['@lsp.type.regexp'] = { fg = '' },
        ]]
    },

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = false,    -- use background color for virtual text
    },
}
require('onedark').load()

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

require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

--[[
--  SECT: Lsp
--]]
vim.lsp.enable('clangd')                            -- C / C++
vim.lsp.enable('cmake')                             -- Cmake
vim.lsp.enable('zls')                               -- Zig LSP
vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust_analyzer'] = {
            diagnostics = {
                disabled = {'unlinked_file'}
            }
        }
    }
})
vim.lsp.enable('rust_analyzer')                     -- Rust LSP
vim.lsp.enable('mesonlsp')                          -- Meson LSP
vim.lsp.enable('pylsp')                             -- Python LSP
vim.lsp.enable('ts_ls')                             -- Typescript LSP (Requires NPM)
vim.lsp.enable('lua_ls')                            -- Lua LSP
vim.lsp.enable('html')                              -- HTML LSP
vim.lsp.enable('cssls')                             -- CSS LSP
vim.lsp.enable('bashls')                            -- Bash LSP

--[[
--  SECT: Keymaps
--]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<ScrollWheelUp>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<S-ScrollWheelUp>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<C-ScrollWheelUp>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<ScrollWheelDown>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<S-ScrollWheelDown>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<C-ScrollWheelDown>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<ScrollWheelLeft>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<S-ScrollWheelLeft>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<C-ScrollWheelLeft>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<ScrollWheelRight>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<S-ScrollWheelRight>', '<nop>')
vim.keymap.set({'n', 'i', 'v', 'x', 't'}, '<C-ScrollWheelRight>', '<nop>')

vim.keymap.set('i', '<C-S-o>', '<C-o><S-o>')

vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", {desc = 'Show the warning(s) / error(s) in a float'})

vim.keymap.set('n', "<leader>pv", function() vim.cmd('Ex') end)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move the line down and adjust indentation" })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move the line up and adjust indentation" })

vim.keymap.set('n', 'J', "mzJ`z", { desc = "Append the next line to the end of this line" })

vim.keymap.set('n', '<C-d>', "<C-d>zz", { desc = "Move down 25 lines" })
vim.keymap.set('n', '<C-u>', "<C-u>zz", { desc = "Move up 25 lines" })

vim.keymap.set('x', "<leader>p", "\"_dP", { desc = "Paste without overwriting clipboard"})
vim.keymap.set('x', "<leader>d", "\"_d", { desc = "Delete without overwriting clipboard"})

-- Lsp bindings
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {noremap = true, silent = true})
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {noremap = true, silent = true})
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', {noremap = true, silent = true})
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', {noremap = true, silent = true})
vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {noremap = true, silent = true})
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', {noremap = true, silent = true})
vim.keymap.set('i', '<C-g>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', {noremap = true, silent = true})

-- Harpoon bindings
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
vim.keymap.set('n', "<leader>a", harpoon_mark.add_file, { desc = "Add file to harpoon" })
vim.keymap.set('n', "<C-e>", harpoon_ui.toggle_quick_menu, { desc = "Show harpoon files" })
vim.keymap.set('n', "<C-h>", function() harpoon_ui.nav_file(1) end, { desc = "Move to the first harpoon buffer" })
vim.keymap.set('n', "<C-j>", function() harpoon_ui.nav_file(2) end, { desc = "Move to the second harpoon buffer" })
vim.keymap.set('n', "<C-k>", function() harpoon_ui.nav_file(3) end, { desc = "Move to the third harpoon buffer" })
vim.keymap.set('n', "<C-l>", function() harpoon_ui.nav_file(4) end, { desc = "Move to the fourth harpoon buffer" })
vim.keymap.set('n', "<C-t>", function() harpoon_ui.nav_file(5) end, { desc = "Move to the fifth harpoon buffer" })
vim.keymap.set('n', "<C-n>", function() harpoon_ui.nav_file(6) end, { desc = "Move to the sixth harpoon buffer" })
vim.keymap.set('n', "<C-s>", function() harpoon_ui.nav_file(7) end, { desc = "Move to the seventh harpoon buffer" })

-- Telescope Bindings
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', telescope.find_files, {})
vim.keymap.set('n', '<C-p>', telescope.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- OpenCode
-- Default configuration with all available options

require('render-markdown').setup({
	opts = {
		anti_conceal = { enable = false },
		file_types = { 'opencode_output' }
	},
	ft = { 'Avante', 'copilot-chat', 'opencode_output' }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if string.match(bufname, "%.md$") then
            require('render-markdown').disable()
        end
    end
})

require('opencode').setup({
  preferred_picker = nil, -- 'telescope'/'telescope.nvim', 'fzf'/'fzf-lua', 'mini.pick', 'snacks'/'snacks.nvim', 'select', if nil, it will use the best available picker. Note mini.pick does not support multiple selections
  preferred_completion = nil, -- 'blink', 'nvim-cmp','vim_complete' if nil, it will use the best available completion
  default_global_keymaps = true, -- If false, disables all default global keymaps
  default_mode = 'build', -- 'build' or 'plan' or any custom configured. @see [OpenCode Agents](https://opencode.ai/docs/modes/)
  default_system_prompt = nil, -- Custom system prompt to use for all sessions. If nil, uses the default built-in system prompt
  keymap_prefix = '<leader>o', -- Default keymap prefix for global keymaps change to your preferred prefix and it will be applied to all keymaps starting with <leader>o
  opencode_executable = 'opencode', -- Name of your opencode binary
  snapshot_path = nil, -- Override base path for the snapshot git directory (default: $XDG_DATA_HOME/opencode). Appends /snapshot/<project_id>/<worktree_hash>

  -- Server configuration for custom/external opencode servers
  server = {
    url = nil,             -- URL/hostname (e.g., 'http://192.168.1.100', 'localhost', 'https://myserver.com')
    port = nil,            -- Port number (e.g., 8080), 'auto' for random port
    timeout = 5,           -- Health check timeout in seconds when connecting
    spawn_command = nil,   -- Optional function to start the server: function(port, url) ... end
    auto_kill = true,      -- Kill spawned servers when last nvim instance exits (default: true) Only applies to servers spawned by the plugin with spawn_command/kill_command
    path_map = nil,        -- Map host paths to server paths: string ('/app') or function(path) -> string
    username = nil,        -- Username for Basic auth. Falls back to OPENCODE_SERVER_USERNAME env var, then "opencode"
    password = nil,        -- Password for Basic auth. Falls back to OPENCODE_SERVER_PASSWORD env var
  },

  keymap = {
    editor = {
      ['<leader>og'] = { 'toggle' }, -- Open opencode. Close if opened
      ['<leader>oi'] = { 'open_input' }, -- Opens and focuses on input window on insert mode
      ['<leader>oI'] = { 'open_input_new_session' }, -- Opens and focuses on input window on insert mode. Creates a new session
      ['<leader>oo'] = { 'open_output' }, -- Opens and focuses on output window
      ['<leader>ot'] = { 'toggle_focus' }, -- Toggle focus between opencode and last window
      ['<leader>oT'] = { 'timeline' }, -- Display timeline picker to navigate/undo/redo/fork messages
      ['<leader>oq'] = { 'close' }, -- Close UI windows
      ['<leader>os'] = { 'select_session' }, -- Select and load a opencode session
      ['<leader>oR'] = { 'rename_session' }, -- Rename current session
      ['<leader>op'] = { 'configure_provider' }, -- Quick provider and model switch from predefined list
      ['<leader>oV'] = { 'configure_variant' }, -- Switch model variant for the current model
      ['<leader>oy'] = { 'add_visual_selection', mode = {'v'} },
      ['<leader>oY'] = { 'add_visual_selection_inline', mode = {'v'} }, -- Insert visual selection as inline code block in the input buffer
      ['<leader>oz'] = { 'toggle_zoom' }, -- Zoom in/out on the Opencode windows
      ['<leader>ov'] = { 'paste_image'}, -- Paste image from clipboard into current session
      ['<leader>od'] = { 'diff_open' }, -- Opens a diff tab of a modified file since the last opencode prompt
      ['<leader>o]'] = { 'diff_next' }, -- Navigate to next file diff
      ['<leader>o['] = { 'diff_prev' }, -- Navigate to previous file diff
      ['<leader>oc'] = { 'diff_close' }, -- Close diff view tab and return to normal editing
      ['<leader>ora'] = { 'diff_revert_all_last_prompt' }, -- Revert all file changes since the last opencode prompt
      ['<leader>ort'] = { 'diff_revert_this_last_prompt' }, -- Revert current file changes since the last opencode prompt
      ['<leader>orA'] = { 'diff_revert_all' }, -- Revert all file changes since the last opencode session
      ['<leader>orT'] = { 'diff_revert_this' }, -- Revert current file changes since the last opencode session
      ['<leader>orr'] = { 'diff_restore_snapshot_file' }, -- Restore a file to a restore point
      ['<leader>orR'] = { 'diff_restore_snapshot_all' }, -- Restore all files to a restore point
      ['<leader>ox'] = { 'swap_position' }, -- Swap Opencode pane left/right
      ['<leader>ott'] = { 'toggle_tool_output' }, -- Toggle tools output (diffs, cmd output, etc.)
      ['<leader>otr'] = { 'toggle_reasoning_output' }, -- Toggle reasoning output (thinking steps)
      ['<leader>o/'] = { 'quick_chat', mode = { 'n', 'x' } }, -- Open quick chat input with selection context in visual mode or current line context in normal mode
    },
    input_window = {
      ['<S-cr>'] = { 'submit_input_prompt', mode = { 'n', 'i' } }, -- Submit prompt (normal mode and insert mode)
      ['<esc>'] = { 'close', defer_to_completion = true }, -- Close UI windows
      ['<C-c>'] = { 'cancel', defer_to_completion = true }, -- Cancel opencode request while it is running
      ['~'] = { 'mention_file', mode = 'i' }, -- Pick a file and add to context. See File Mentions section
      ['@'] = { 'mention', mode = 'i' }, -- Insert mention (file/agent)
      ['/'] = { 'slash_commands', mode = 'i' }, -- Pick a command to run in the input window
      ['#'] = { 'context_items', mode = 'i' }, -- Manage context items (current file, selection, diagnostics, mentioned files)
      ['<M-v>'] = { 'paste_image', mode = 'i' }, -- Paste image from clipboard as attachment
      ['<tab>'] = { 'toggle_pane', mode = { 'n', 'i' }, defer_to_completion = true }, -- Toggle between input and output panes
      ['<up>'] = { 'prev_prompt_history', mode = { 'n', 'i' }, defer_to_completion = true }, -- Navigate to previous prompt in history
      ['<down>'] = { 'next_prompt_history', mode = { 'n', 'i' }, defer_to_completion = true }, -- Navigate to next prompt in history
      ['<M-m>'] = { 'switch_mode' }, -- Switch between modes (build/plan)
      ['<M-r>'] = { 'cycle_variant', mode = { 'n', 'i' } }, -- Cycle through available model variants
    },
    output_window = {
      ['<esc>'] = { 'close' }, -- Close UI windows
      ['<C-c>'] = { 'cancel' }, -- Cancel opencode request while it is running
      [']]'] = { 'next_message' }, -- Navigate to next message in the conversation
      ['[['] = { 'prev_message' }, -- Navigate to previous message in the conversation
      ['<tab>'] = { 'toggle_pane', mode = { 'n', 'i' } }, -- Toggle between input and output panes
      ['i'] = { 'focus_input', 'n' }, -- Focus on input window and enter insert mode at the end of the input from the output window
      ['gf'] = { 'jump_to_file', mode = { 'n' } }, -- Jump to file at cursor in output window
      ['<M-r>'] = { 'cycle_variant', mode = { 'n' } }, -- Cycle through available model variants
      ['<leader>oD'] = { 'debug_message' }, -- Open raw message in new buffer for debugging
      ['<leader>oO'] = { 'debug_output' }, -- Open raw output in new buffer for debugging
      ['<leader>ods'] = { 'debug_session' }, -- Open raw session in new buffer for debugging
    },
    session_picker = {
      rename_session = { '<C-r>' }, -- Rename selected session in the session picker
      delete_session = { '<C-d>' }, -- Delete selected session in the session picker
      new_session = { '<C-s>' }, -- Create and switch to a new session in the session picker
    },
    timeline_picker = {
      undo = { '<C-u>', mode = { 'i', 'n' } }, -- Undo to selected message in timeline picker
      fork = { '<C-f>', mode = { 'i', 'n' } }, -- Fork from selected message in timeline picker
    },
    history_picker = {
      delete_entry = { '<C-d>', mode = { 'i', 'n' } }, -- Delete selected entry in the history picker
      clear_all = { '<C-X>', mode = { 'i', 'n' } }, -- Clear all entries in the history picker
    },
    model_picker = {
      toggle_favorite = { '<C-f>', mode = { 'i', 'n' } },
    },
    mcp_picker = {
      toggle_connection = { '<C-t>', mode = { 'i', 'n' } }, -- Toggle MCP server connection in the MCP picker
    },
  },
  ui = {
    enable_treesitter_markdown = true, -- Use Treesitter for markdown rendering in the output window (default: true).
    position = 'right', -- 'right' (default), 'left' or 'current'. Position of the UI split. 'current' uses the current window for the output.
    input_position = 'bottom', -- 'bottom' (default) or 'top'. Position of the input window
    window_width = 0.40, -- Width as percentage of editor width
    zoom_width = 0.8, -- Zoom width as percentage of editor width
    display_model = true, -- Display model name on top winbar
    display_context_size = true, -- Display context size in the footer
    display_cost = true, -- Display cost in the footer
    hide_single_tab = true, -- Hide the panel tab strip when only one session tab exists
    notify_on_background_prompt = true, -- Notify when an unfocused session needs a question or permission response
    window_highlight = 'Normal:OpencodeBackground,FloatBorder:OpencodeBorder', -- Highlight group for the opencode window
    persist_state = true, -- Keep buffers when toggling/closing UI so window state restores quickly
    icons = {
      preset = 'nerdfonts', -- 'nerdfonts' | 'text'. Choose UI icon style (default: 'nerdfonts')
      overrides = {}, -- Optional per-key overrides, see section below
    },
    questions = {
      use_vim_ui_select = false, -- If true, render questions/prompts with vim.ui.select instead of showing them inline in the output buffer.
      inline_other_input = true, -- If true, show an inline floating input for "Other" instead of vim.ui.input.
    },
    output = {
      filetype = 'opencode_output', -- Filetype assigned to the output buffer (default: 'opencode_output')
      actions = {
        open_in_new_tab = false, -- Open inline child-session and fork actions in a new panel tab
      },
      compact_assistant_headers = false, -- 'full' (default), 'minimal' (compact if same mode), or 'hidden' (no headers for assistant)
      tools = {
        show_output = true, -- Show tools output [diffs, cmd output, etc.] (default: true)
        show_reasoning_output = true, -- Show reasoning/thinking steps output (default: true)
        use_folds = true, -- Use folds for tool output (default: true)
        folding_threshold = 25, -- Number of lines to show before folding when show_output is true (default: 25)
        fold_exclude = { -- Tools that should never be folded (default: sequential-thinking)
          'bash', -- built-in tool name (exact match)
          { server = 'sequential-thinking', tool = 'sequentialthinking' }, -- MCP tool (server + tool match)
        },
      },
      rendering = {
        markdown_debounce_ms = 250, -- Debounce time for markdown rendering on new data (default: 250ms)
        on_data_rendered = nil, -- Called when new data is rendered; set to false to disable default RenderMarkdown/Markview behavior
      },
      max_messages = nil, -- Max number of messages to keep in the output buffer; older messages will be removed as new ones arrive (default: nil, which means no limit)
    },
    input = {
      min_height = 0.10, -- min height of prompt input as percentage of window height
      max_height = 0.25, -- max height of prompt input as percentage of window height
      text = {
        wrap = false, -- Wraps text inside input window
      },
      -- Auto-hide input window when prompt is submitted or focus switches to output window
      auto_hide = false,
    },
    picker = {
      snacks_layout = nil -- `layout` opts to pass to Snacks.picker.pick({ layout = ... })
    },
    completion = {
      file_sources = {
        enabled = true,
        preferred_cli_tool = 'server', -- 'fd','fdfind','rg','git','server' if nil, it will use the best available tool, 'server' uses opencode cli to get file list (works cross platform) and supports folders
        ignore_patterns = {
          '^%.git/',
          '^%.svn/',
          '^%.hg/',
          'node_modules/',
          '%.pyc$',
          '%.o$',
          '%.obj$',
          '%.exe$',
          '%.dll$',
          '%.so$',
          '%.dylib$',
          '%.class$',
          '%.jar$',
          '%.war$',
          '%.ear$',
          'target/',
          'build/',
          'dist/',
          'out/',
          'deps/',
          '%.tmp$',
          '%.temp$',
          '%.log$',
          '%.cache$',
        },
        max_files = 10,
        max_display_length = 50, -- Maximum length for file path display in completion, truncates from left with "..."
      },
    },
  },
  context = {
    enabled = true, -- Enable automatic context capturing
    cursor_data = {
      enabled = false, -- Include cursor position and line content in the context
      context_lines = 5, -- Number of lines before and after cursor to include in context
    },
    diagnostics = {
      info = false, -- Include diagnostics info in the context (default to false
      warning = true, -- Include diagnostics warnings in the context
      error = true, -- Include diagnostics errors in the context
      only_closest = false, -- If true, only diagnostics for cursor/selection
    },
    current_file = {
      enabled = true, -- Include current file path and content in the context
      show_full_path = true,
    },
    files = {
      enabled = true,
      show_full_path = true,
    },
    selection = {
      enabled = true, -- Include selected text in the context
    },
    buffer = {
      enabled = false, -- Disable entire buffer context by default, only used in quick chat
    },
    git_diff = {
      enabled = false,
    },
  },
  logging = {
    enabled = false,
    level = 'warn', -- debug, info, warn, error
    outfile = nil,
  },
  debug = {
    enabled = false, -- Enable debug messages in the output window
    capture_streamed_events = false,
    show_ids = true,
    quick_chat = {
      keep_session = false, -- Keep quick_chat sessions for inspection, this can pollute your sessions list
      set_active_session = false,
    },
  },
  prompt_guard = nil, -- Optional function that returns boolean to control when prompts can be sent (see Prompt Guard section)
  child_readonly = true, -- When true (default), child sessions are read-only: messaging is blocked and input window is hidden on switch

  -- User Hooks for custom behavior at certain events
  hooks = {
    on_file_edited = nil, -- Called after a file is edited by opencode.
    on_session_loaded = nil, -- Called after a session is loaded.
    on_done_thinking = nil, -- Called when a session becomes idle, including sessions started outside Neovim.
    on_permission_requested = nil, -- Called when a permission request is issued.
  },
  quick_chat = {
    default_model = nil,   -- works better with a fast model like gpt-4.1
    default_agent = nil, -- Uses the current mode when nil
    instructions = nil, -- Use built-in instructions if nil
  },
})
