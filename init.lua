-- [[
--  SECT: Plugin Manager
-- ]]
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- ADD PLUGINS HERE
        {
            -- Configuring this here stopped the lualine from breaking... not sure why...
            'navarasu/onedark.nvim',
            priority = 1000,
            config = function()
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
            end
        },
        {'williamboman/mason.nvim'},
        {
                'nvim-flutter/flutter-tools.nvim',
                lazy = false,
                dependencies = {
                    'nvim-lua/plenary.nvim',
                    -- 'stevearc/dressing.nvim', -- optional for vim.ui.select
                },
                config = true,
        },
		{'williamboman/mason-lspconfig.nvim'},
        {'folke/lua-dev.nvim'},
        {'rhysd/vim-llvm'},
        {'lewis6991/gitsigns.nvim'},
        {'echasnovski/mini.nvim'},
        {'nvim-tree/nvim-web-devicons'},
		{ "folke/which-key.nvim", lazy = false },
		{ "folke/todo-comments.nvim", opts = {} },
		{
			'nvim-telescope/telescope.nvim', tag = '0.1.8',
			dependencies = { 'nvim-lua/plenary.nvim' }
		},
		{'nvim-treesitter/nvim-treesitter',
			build = ':TSUpdate',
			main = 'nvim-treesitter.configs', -- Sets main module to use for opts
			opts = {
				--ensure_installed = { 'bash', 'cpp', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'kotlin' },
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = { enable = true, disable = { 'ruby' } },
			}
		},
		{'nvim-treesitter/playground'},
        {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }},
		{'theprimeagen/harpoon'}, --
		{'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'}, --
		{'neovim/nvim-lspconfig'}, --
		{'hrsh7th/cmp-nvim-lsp'}, --
		{'hrsh7th/nvim-cmp'}, --
		{'hrsh7th/cmp-buffer'}, --
		{'L3MON4D3/LuaSnip'},
        --[[
		{
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			config = true
			-- use opts = {} for passing setup options
			-- this is equivalent to setup({}) function
		},
        ]]
		{'mbbill/undotree'},
		{'tpope/vim-fugitive'},
	},
  -- Configure any other settings here. See the documentation for more details.
  -- automatically check for plugin updates
  checker = { enabled = false },
})
--[[
--  SECT: Plugin Configurations
--]]

-- SECT: Gitsigns
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

-- SECT: Harpoon
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

-- SECT: LSP
local lsp = require('lsp-zero')

local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('i', '<C-g>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
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

vim.lsp.config['lua_ls'] = {
	settings = {
		Lua = {
			telemetry = {
				enable = false
			},
		},
	},
	on_init = function(client)
		local join = vim.fs.joinpath
		local path = vim.fs.abspath('.')

		-- Don't do anything if there is project local config
		if vim.uv.fs_stat(join(path, '.luarc.json')) 
			or vim.uv.fs_stat(join(path, '.luarc.jsonc'))
		then
			return
		end

		local nvim_settings = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'}
			},
			workspace = {
				checkThirdParty = false,
				library = {
					-- Make the server aware of Neovim runtime files
					vim.env.VIMRUNTIME,
					vim.fn.stdpath('config'),
				},
			},
		}

		client.config.settings.Lua = vim.tbl_deep_extend(
			'force',
			client.config.settings.Lua,
			nvim_settings
		)
	end,
}

-- SECT: Lualine
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

-- SECT: Mason
require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here 
    -- with the ones you want to install
    ensure_installed = {
        'clangd', --dependency: unzip       -- C, C++, Fortran, etc.
        'cmake',                            -- Cmake
        'zls',                              -- Zig LSP
        'rust_analyzer',                    -- Rust LSP
        'mesonlsp',                         -- Meson LSP
        'pylsp',                            -- Python LSP
        'ts_ls',                            -- Typescript LSP (Requires NPM)
        'lua_ls',                           -- Lua LSP
        'html',                             -- HTML LSP
        'cssls',                            -- CSS LSP
        'bashls',                           -- Bash LSP
        'gradle_ls',                        -- Gradle LSP
        'kotlin_language_server',           -- Kotlin LSP
        --'java_language_server',             -- Java LSP (requires jlink and i don't feel like figuring out where that resides)
    },

    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
    automatic_installation = true,
})

require('mason-lspconfig').setup({
    handlers = {
        -- this first function is the "default handler"
        -- it applies to every language server without a "custom handler"
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        -- this is the "custom handler" for `example_server`
        --example_server = function()
        --require('lspconfig').example_server.setup({
        ---
        -- in here you can add your own
        -- custom configuration
        ---
        --})
        --end,
    },
})

--SECT: Mini
require('mini.statusline').setup({
    use_icons = vim.g.have_nerd_font
})

-- SECT: Telescope
local telescope = require('telescope.builtin')

-- SECT: Todo Comments
require('todo-comments').setup ({
    keywords = {
        SECTION = {
            icon =  "§ ",
            color = "#93E9BE",
            alt = {"SECT", "BREAK"}
        }
    }
})

-- SECT: Treesitter
require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

-- SECT: Undo Tree
vim.keymap.set('n', "<leader>u", vim.cmd.UndotreeToggle)

-- SECT: Which Key
require('which-key').add({
    {'<leader>u', desc = "Toggle Undo tree"},
    {'<leader>a', desc = "Add file to harpoon"},
    {'<leader>pf', desc = "Fuzzy Find files"},
    {'<leader>pv', desc = "Open file explorer"},
    {'<leader>ps', desc = "Grep files"},
    {'<leader>gs', desc = "Git Status"},
    {'<leader>g', desc = "Git"},
    {'<leader>p', desc = "File Functions"},
    {'gd', desc = "Go to Definition"},
    {'gD', desc = "Go to Declaration"},
    {'gi', desc = "Go to Implementation"},
    {'go', desc = "Go to Type Definition"},
    {'gr', desc = "Go to References"},
    {'<C-g>', desc = "Show Signature Help"},
    {'<F2>', desc = "Rename Under Cursor"},
    {'<F3>', desc = "Format Selection"},
    {'<F4>', desc = "Go to next Code Action"},
    {'K', desc = "Show Hover Window" }
})

--[[
--  SECT: Neovim Options
--]]

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

-- Fugitive binding
vim.keymap.set('n', "<leader>gs", vim.cmd.Git, { desc = "Open Git Viewer" })

-- Harpoon bindings
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
vim.keymap.set('n', '<leader>pf', telescope.find_files, {})
vim.keymap.set('n', '<C-p>', telescope.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)
