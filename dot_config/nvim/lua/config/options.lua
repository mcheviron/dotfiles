-- [[ Setting options ]]
-- See `:help vim.o`

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local remember_folds = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = remember_folds,
  pattern = '*',
})

-- colorscheme
-- vim.cmd [[ colorscheme catppuccin-macchiato ]]
-- vim.cmd [[ colorscheme catppuccin-frappe ]]
vim.cmd [[ colorscheme tokyonight-storm ]]

-- Set the timeout to show WhichKey
vim.o.timeoutlen = 600
-- Set highlight on search
vim.o.termguicolors = true

-- highlight the current line
vim.opt.cursorline = true

-- Make line numbers default (relative)
vim.wo.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Make all splits happen on the right side if vertical and below if horizontal
vim.o.splitright = true
vim.o.splitbelow = true

-- Enable break indent
vim.o.breakindent = true

-- Sync with the system clipboard
vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'


-- Format on save
vim.cmd('autocmd BufWritePre * lua vim.lsp.buf.format()')

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Save folds after exiting buffers
vim.cmd([[
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
  augroup END
]])
-- run 'chezmoi apply' everytime you write to a dotfile
vim.cmd([[
  autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"
]])
