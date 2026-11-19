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

vim.o.fileformat = "unix"
vim.opt.fileformats = {"unix", "dos"}

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
    {
        src = 'https://github.com/stevearc/oil.nvim',
        name = 'oil',
    },
    {
        src = 'https://github.com/refractalize/oil-git-status.nvim',
        name = 'oil-git-status',
    },
    {
        src = 'https://github.com/tpope/vim-fugitive',
        name = 'fugitive',
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
    },
    highlights = {
        -- Brighter gray comments (covers legacy, Treesitter, and LSP groups)
        ['Comment'] = { fg = '#7f8590' },
        ['@comment'] = { fg = '#7f8590' },
        ['@lsp.type.comment'] = { fg = '#7f8590' },

        -- Transparent statusline fill (the empty middle of lualine)
        ['StatusLine'] = { bg = 'none' },
        ['StatusLineNC'] = { bg = 'none' },

        ['FloatBorder'] = { fg = '#d6cfc9', bg = 'none' },
        ['NormalFloat'] = { fg = '#d6cfc9', bg = 'none' },

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
        ['@lsp.type.variable'] = { fg = '$eggshell_white' },
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
    c = { fg = 'ffffff', bg = 'NONE' },
}
auto.insert = {
    a = { fg = '000000', bg = 'ffcc80' },
    b = { fg = '000000', bg = 'd6cfc9' },
    c = { fg = 'ffffff', bg = 'NONE' },
}
auto.visual = {
    a = { fg = 'ffffff', bg = '5007d9' },
    b = { fg = '000000', bg = 'd6cfc9' },
    c = { fg = 'ffffff', bg = 'NONE' },
}
auto.replace = {
    a = { fg = 'ffffff', bg = 'bd6315' },
    b = { fg = '000000', bg = 'd6cfc9' },
    c = { fg = 'ffffff', bg = 'NONE' },
}
auto.command = {
    a = { fg = '000000', bg = 'd6cfc9' },
    b = { fg = '000000', bg = 'd6cfc9' },
    c = { fg = 'ffffff', bg = 'NONE' },
}
auto.inactive = auto.normal -- unfocused windows use the same colors as normal mode
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
        lualine_a = {'location'},
        lualine_b = {'branch', 'diff', 'diagnostics', 'filename', 'filetype'},
        lualine_c = {},
        lualine_x = {},
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
--  SECT: File Explorer
--]]
-- Oil.nvim: edit directories like a buffer. Rename a line to rename the file,
-- delete a line to delete it, add a line to create it (end it with / for a
-- folder), then :w to apply. Press g? inside an oil buffer for all keys.

-- Turn off Neovim 0.13's built-in read-only directory viewer so oil owns
-- directory buffers (this must run before Neovim loads its runtime plugins).
vim.g.loaded_nvim_dir_plugin = 1

require('oil').setup({
    default_file_explorer = true,   -- Open oil for `nvim .` and `:e somedir` (replaces netrw)
    columns = { 'icon' },           -- Add 'size', 'mtime', 'permissions' for more detail
    delete_to_trash = true,         -- Deleted files go to the Recycle Bin, not gone for good
    skip_confirm_for_simple_edits = false, -- Always show a confirmation before changing files
    watch_for_changes = true,       -- Refresh when files change outside of Neovim
    view_options = {
        show_hidden = true,         -- Show dotfiles (toggle with g.)
        natural_order = true,       -- file2 sorts before file10
    },
    keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-s>'] = false,
        ['<C-t>'] = false,
        -- Replacements for the split / refresh actions freed up above
        ['<C-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open in vertical split' },
        ['<C-x>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open in horizontal split' },
        ['<C-r>'] = {
            callback = function()
                require('oil.actions').refresh.callback()
                OilGitRefresh(require('oil').get_current_dir())
                require('oil-git-status').refresh_buffer(vim.api.nvim_get_current_buf())
            end,
            desc = 'Refresh the listing and git status',
        },
        ['q'] = { 'actions.close', desc = 'Close oil and go back' },
        ['<Esc>'] = {
            callback = function()
                if vim.api.nvim_win_get_config(0).relative ~= '' then
                    require('oil').close()      -- Floating oil: close it
                else
                    vim.cmd('nohlsearch')       -- Normal oil window: usual <Esc> (clear search highlight)
                end
            end,
            desc = 'Close oil when floating, otherwise clear search highlight',
        },
        -- Git diffs (fugitive) for the entry under the cursor. Same keys as in a file.
        ['<leader>gd'] = { callback = function() OilGitDiff() end, desc = 'Git diff entry vs staged (fugitive)' },
        ['<leader>gD'] = { callback = function() OilGitDiff('HEAD') end, desc = 'Git diff entry vs last commit (fugitive)' },
    },
    win_options = {
        winbar = '%!v:lua.OilWinbar()', -- Directory header, built below
        signcolumn = 'yes:2',           -- Room for the git status column (oil-git-status)
    },
    float = {
        border = 'rounded',
        win_options = {
            -- Transparent float: use the see-through Normal background instead of
            -- onedark's solid NormalFloat / FloatBorder colors (oil floats only)
            winhighlight = 'NormalFloat:Normal,FloatBorder:OilFloatBorder,FloatTitle:OilFloatTitle',
        },
    },
})
-- Border and title keep onedark's colors, just without a background
vim.api.nvim_set_hl(0, 'OilFloatBorder', { fg = vim.api.nvim_get_hl(0, { name = 'FloatBorder', link = false }).fg })
vim.api.nvim_set_hl(0, 'OilFloatTitle', { fg = vim.api.nvim_get_hl(0, { name = 'FloatTitle', link = false }).fg, bold = true })

-- Git status column in oil, left of the icons. Two letters per entry, like
-- `git status --short`: left = staged, right = not staged.
--   M modified  A added  D deleted  R renamed  ? untracked  ! ignored
-- Folders show the status of what's inside them.
require('oil-git-status').setup({
    show_ignored = true,  -- Show gitignored entries with !!
})

-- Open a fugitive diff for the oil entry under the cursor.
--   File:   opens the file with a side-by-side diff (:Gvdiffsplit)
--   Folder: opens `git diff` for everything inside it in a new split
-- `rev` is what to compare against: nil = staged (index), 'HEAD' = last commit.
function OilGitDiff(rev)
    local oil = require('oil')
    local entry = oil.get_cursor_entry()
    local dir = oil.get_current_dir()
    if not entry or not dir then return end
    local path = vim.fs.joinpath(dir, entry.name)
    if entry.type == 'directory' then
        vim.cmd('Git -C ' .. vim.fn.fnameescape(dir) .. ' diff ' .. (rev or '') .. ' -- ' .. vim.fn.fnameescape(entry.name))
    else
        vim.cmd.edit(vim.fn.fnameescape(path))
        vim.cmd('Gvdiffsplit' .. (rev and (' ' .. rev) or ''))
    end
end

-- Oil directory header: path, git branch, and change counts for that folder.
--   +N staged   ~N changed (not staged)   ?N untracked   ✓ nothing changed
-- Git runs in the background and the result is cached per folder, so oil never
-- waits on it. The header refreshes on entering oil, after :w, and on <C-r>.
local oil_git = {}  -- dir -> { branch = 'main', staged = 0, changed = 0, untracked = 0 } | false (not a repo)

function OilGitRefresh(dir)
    if not dir then return end
    vim.system(
        { 'git', '-C', dir, 'status', '--porcelain=v1', '--branch', '--', '.' },
        { text = true },
        function(res)
            local info = false
            if res.code == 0 then
                info = { branch = '?', staged = 0, changed = 0, untracked = 0 }
                for line in res.stdout:gmatch('[^\n]+') do
                    if line:sub(1, 2) == '##' then
                        -- "## main...origin/main [ahead 1]" or "## No commits yet on main"
                        info.branch = line:match('^## No commits yet on (.+)$')
                            or line:match('^## (.-)%.%.%.')
                            or line:match('^## (%S+)')
                            or '?'
                        info.ahead = line:match('ahead (%d+)')
                        info.behind = line:match('behind (%d+)')
                    elseif line:sub(1, 2) == '??' then
                        info.untracked = info.untracked + 1
                    else
                        local x, y = line:sub(1, 1), line:sub(2, 2)
                        if x ~= ' ' then info.staged = info.staged + 1 end
                        if y ~= ' ' then info.changed = info.changed + 1 end
                    end
                end
            end
            oil_git[dir] = info
            vim.schedule(function() vim.cmd('redrawstatus!') end)
        end
    )
end

function OilWinbar()
    local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require('oil').get_current_dir(buf)
    if not dir then
        -- Non-local oil buffers (ssh, trash) have no folder on disk; show the raw name
        return ' ' .. vim.api.nvim_buf_get_name(buf):gsub('%%', '%%%%')
    end

    local path = vim.fn.fnamemodify(dir, ':~'):gsub('%%', '%%%%')
    local parts = { '%#OilWinbarPath# ' .. path .. '%*' }

    local git = oil_git[dir]
    if git then
        local s = { '%#OilWinbarBranch# ' .. git.branch:gsub('%%', '%%%%') }
        if git.ahead then table.insert(s, '↑' .. git.ahead) end
        if git.behind then table.insert(s, '↓' .. git.behind) end
        if git.staged > 0 then table.insert(s, '%#OilWinbarStaged#+' .. git.staged) end
        if git.changed > 0 then table.insert(s, '%#OilWinbarChanged#~' .. git.changed) end
        if git.untracked > 0 then table.insert(s, '%#OilWinbarUntracked#?' .. git.untracked) end
        if git.staged + git.changed + git.untracked == 0 then table.insert(s, '%#OilWinbarClean#✓') end
        table.insert(parts, table.concat(s, ' ') .. '%*')
    end
    return table.concat(parts, '   ')
end

-- Header colors (linked to theme groups so they follow the colorscheme)
vim.api.nvim_set_hl(0, 'OilWinbarPath', { link = 'Directory', default = true })
vim.api.nvim_set_hl(0, 'OilWinbarBranch', { link = 'Special', default = true })
vim.api.nvim_set_hl(0, 'OilWinbarStaged', { link = 'GitSignsAdd', default = true })
vim.api.nvim_set_hl(0, 'OilWinbarChanged', { link = 'GitSignsChange', default = true })
vim.api.nvim_set_hl(0, 'OilWinbarUntracked', { link = 'Comment', default = true })
vim.api.nvim_set_hl(0, 'OilWinbarClean', { link = 'GitSignsAdd', default = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'FocusGained' }, {
    desc = 'Refresh git status in the oil header',
    callback = function(ev)
        if vim.bo[ev.buf].filetype == 'oil' then
            OilGitRefresh(require('oil').get_current_dir(ev.buf))
        end
    end,
})
vim.api.nvim_create_autocmd('User', {
    pattern = 'OilActionsPost', -- After oil finishes creating / renaming / deleting files
    desc = 'Refresh git status in the oil header after file changes',
    callback = function()
        OilGitRefresh(require('oil').get_current_dir())
    end,
})

-- Moving / renaming a file that has unsaved edits: carry the buffer along quietly.
-- Out of the box, oil copies the unsaved text into a new buffer but can't close the
-- old one (it's unsaved), which causes E89 and an E211 "no longer available" prompt.
-- Here, just before the move, each affected buffer's unsaved text, undo history, and
-- cursor are saved and the buffer is marked saved, so oil swaps it out cleanly. After
-- the move, everything is put back on the new buffer, which stays unsaved.
local oil_moving = {}

local function oil_url_to_path(url)
    local _, path = require('oil.util').parse_url(url)
    return path and vim.fs.normalize(require('oil.fs').posix_to_os_path(path)) or nil
end

vim.api.nvim_create_autocmd('User', {
    pattern = 'OilActionsPre',
    desc = 'Save unsaved buffers that oil is about to move',
    callback = function(ev)
        oil_moving = {}
        for _, action in ipairs(ev.data.actions) do
            local src = action.type == 'move' and oil_url_to_path(action.src_url)
            local dest = src and oil_url_to_path(action.dest_url)
            if src and dest then
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    local name = vim.fs.normalize(vim.api.nvim_buf_get_name(buf))
                    local inside = name == src or vim.startswith(name, src .. '/') -- the file, or a file in a moved folder
                    if inside and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == '' and vim.bo[buf].modified then
                        local item = {
                            buf = buf,
                            dest = dest .. name:sub(#src + 1),
                            lines = vim.api.nvim_buf_get_lines(buf, 0, -1, true),
                            undo = vim.fn.tempname(),
                            cursors = {},
                        }
                        for _, win in ipairs(vim.fn.win_findbuf(buf)) do
                            item.cursors[win] = vim.api.nvim_win_get_cursor(win)
                        end
                        vim.api.nvim_buf_call(buf, function()
                            vim.cmd('silent! wundo! ' .. vim.fn.fnameescape(item.undo))
                        end)
                        vim.bo[buf].modified = false
                        -- Until oil swaps it out, its file is "missing"; skip Neovim's
                        -- changed-on-disk check (E211 / reload prompt) for this buffer only
                        item.guard = vim.api.nvim_create_autocmd('FileChangedShell', {
                            buffer = buf,
                            callback = function() vim.v.fcs_choice = '' end,
                        })
                        table.insert(oil_moving, item)
                    end
                end
            end
        end
    end,
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'OilActionsPost',
    desc = 'Restore unsaved edits on buffers that oil moved',
    callback = function(ev)
        local items = oil_moving
        oil_moving = {}
        if #items == 0 then return end
        -- Run after oil's own (scheduled) buffer swap has finished
        vim.schedule(function()
            for _, item in ipairs(items) do
                local buf = item.buf
                if ev.data.err == nil then
                    buf = vim.fn.bufadd(item.dest)
                    vim.fn.bufload(buf)
                    vim.bo[buf].buflisted = true
                    vim.api.nvim_buf_set_lines(buf, 0, -1, true, item.lines)
                    vim.api.nvim_buf_call(buf, function()
                        vim.cmd('silent! rundo ' .. vim.fn.fnameescape(item.undo))
                    end)
                    -- Any window still showing the old buffer switches to the moved one
                    for _, win in ipairs(vim.fn.win_findbuf(item.buf)) do
                        if win ~= nil and item.buf ~= buf then vim.api.nvim_win_set_buf(win, buf) end
                    end
                    for win, cursor in pairs(item.cursors) do
                        if vim.api.nvim_win_is_valid(win) then
                            if vim.api.nvim_win_get_buf(win) ~= buf then vim.api.nvim_win_set_buf(win, buf) end
                            pcall(vim.api.nvim_win_set_cursor, win, cursor)
                        end
                    end
                    -- Oil sometimes leaves the old buffer behind (files inside a moved folder)
                    if item.buf ~= buf and vim.api.nvim_buf_is_valid(item.buf) then
                        pcall(vim.api.nvim_buf_delete, item.buf, { force = true })
                    end
                end
                -- Mark unsaved again (on the moved buffer, or the original if the move failed)
                if vim.api.nvim_buf_is_valid(buf) then vim.bo[buf].modified = true end
                pcall(vim.api.nvim_del_autocmd, item.guard)
                os.remove(item.undo)
            end
        end)
    end,
})
-- Oil keymaps (-, <leader>pv, <leader>po) live in the Keymaps section,
-- after mapleader is set.

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

-- File explorer (oil)
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory in oil' })
vim.keymap.set('n', '<leader>pv', '<cmd>Oil<CR>', { desc = 'Open file explorer (oil)' })
vim.keymap.set('n', '<leader>po', function() require('oil').toggle_float() end, { desc = 'Open file explorer in a float (oil)' })

-- Git (fugitive). Inside oil, <leader>gd / <leader>gD act on the entry under the cursor instead.
vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>', { desc = 'Git diff this file vs staged (side by side)' })
vim.keymap.set('n', '<leader>gD', '<cmd>Gvdiffsplit HEAD<CR>', { desc = 'Git diff this file vs last commit (side by side)' })
vim.keymap.set('n', '<leader>gs', '<cmd>Git<CR>', { desc = 'Git status (fugitive)' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move the line down and adjust indentation" })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move the line up and adjust indentation" })

vim.keymap.set('n', 'J', "mzJ`z", { desc = "Append the next line to the end of this line" })

-- Half-page jumps that keep the cursor centered. In a diff window, move by real
-- lines instead of scrolling the screen. Otherwise <C-d>/<C-u> get stuck when
-- the other side has a block of added lines bigger than half a page: the
-- cursor can't land on the blank filler rows, so zz keeps pulling it back.
local function half_page(down)
    return function()
        if not vim.wo.diff then
            return (down and '<C-d>' or '<C-u>') .. 'zz'
        end
        local n = vim.wo.scroll > 0 and vim.wo.scroll or math.floor(vim.api.nvim_win_get_height(0) / 2)
        return n .. (down and 'j' or 'k') .. 'zz'
    end
end
vim.keymap.set('n', '<C-d>', half_page(true), { expr = true, desc = "Move down half a page" })
vim.keymap.set('n', '<C-u>', half_page(false), { expr = true, desc = "Move up half a page" })

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

-- Telescope Bindings
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', telescope.find_files, { desc = "Fuzzy find files" })
vim.keymap.set('n', '<leader>pg', telescope.git_files, { desc = "Fuzzy find git files" })
vim.keymap.set('n', '<leader>ps', function()
	telescope.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Fuzzy find files with grep" })

-- OpenCode
-- Default configuration with all available options

require('render-markdown').setup({
	opts = {
		anti_conceal = { enable = false },
		file_types = { 'opencode_output' }
	},
	ft = { 'Avante', 'copilot-chat', 'opencode_output' },
	-- Don't render inside floating windows (LSP hover / signature help popups).
	-- Neovim's own markdown highlighting still applies there.
	ignore = function(buf)
		for _, win in ipairs(vim.fn.win_findbuf(buf)) do
			if vim.api.nvim_win_get_config(win).relative ~= '' then
				return true
			end
		end
		return false
	end,
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
    url = 'localhost',      -- URL/hostname (e.g., 'http://192.168.1.100', 'localhost', 'https://myserver.com')
    port = auto,            -- Port number (e.g., 8080), 'auto' for random port
    timeout = 5,            -- Health check timeout in seconds when connecting
    spawn_command = nil,    -- Optional function to start the server: function(port, url) ... end
    auto_kill = true,       -- Kill spawned servers when last nvim instance exits (default: true) Only applies to servers spawned by the plugin with spawn_command/kill_command
    path_map = nil,         -- Map host paths to server paths: string ('/app') or function(path) -> string
    username = nil,         -- Username for Basic auth. Falls back to OPENCODE_SERVER_USERNAME env var, then "opencode"
    password = nil,         -- Password for Basic auth. Falls back to OPENCODE_SERVER_PASSWORD env var
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
