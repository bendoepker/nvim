vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = '·', nbsp = '␣' }

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 50

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.inccommand = 'split'

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.opt.ww = 'h,l,<,>,[,]'
