require("./ben/remap")
require("./ben/opts")

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
        {'lewis6991/gitsigns.nvim'},
        {'echasnovski/mini.nvim'},
        {'nvim-tree/nvim-web-devicons'},
		-- I have a separate config.mappings file where I require which-key.
		-- With lazy the plugin will be automatically loaded when it is required somewhere
		{ "folke/which-key.nvim", lazy = false },
		{ "folke/todo-comments.nvim", opts = {} },
		{
			'nvim-telescope/telescope.nvim', tag = '0.1.8',
			dependencies = { 'nvim-lua/plenary.nvim' }
		},
		{'nvim-treesitter/nvim-treesitter',
			compilers = { "clang" },
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
		{'williamboman/mason-lspconfig.nvim'}, --
		{'L3MON4D3/LuaSnip'},
		{
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			config = true
			-- use opts = {} for passing setup options
			-- this is equivalent to setup({}) function
		},
		{'mbbill/undotree'},
		{'tpope/vim-fugitive'},
	},
  -- Configure any other settings here. See the documentation for more details.
  -- automatically check for plugin updates
  checker = { enabled = false },
})
