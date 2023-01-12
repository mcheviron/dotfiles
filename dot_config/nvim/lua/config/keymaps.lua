-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n' }, '<C-q>', ':q<cr>', { silent = true })
vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file", silent = true })
vim.keymap.set({ 'n' }, '<C-a>', 'ggVG', { silent = true })
vim.keymap.set({ 'n' }, '<C-w>', ':bd<cr>', { silent = true })
vim.keymap.set({ 'n' }, '<tab>', '>>', { silent = true })
vim.keymap.set({ 'n' }, '<S-tab>', '<<', { silent = true })
-- todo-comments keymaps
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })


-- Better window navigation
vim.keymap.set({ 'n' }, "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set({ 'n' }, "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set({ 'n' }, "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set({ 'n' }, "<C-l>", "<C-w>l", { silent = true })
-- Resize with arrows
vim.keymap.set({ 'n' }, "<C-Up>", ":resize -2<CR>", { silent = true })
vim.keymap.set({ 'n' }, "<C-Down>", ":resize +2<CR>", { silent = true })
vim.keymap.set({ 'n' }, "<C-Left>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set({ 'n' }, "<C-Right>", ":vertical resize +2<CR>", { silent = true })
-- Navigate buffers
vim.keymap.set({ 'n' }, "<S-l>", ":bnext<CR>", { silent = true })
vim.keymap.set({ 'n' }, "<S-h>", ":bprevious<CR>", { silent = true })
-- Move text up and down
vim.keymap.set({ 'n' }, "<A-j>", "<Esc>:m .+1<CR>==", { silent = true })
vim.keymap.set({ 'n' }, "<A-k>", "<Esc>:m .-2<CR>==", { silent = true })
-- Stay in indent mode
vim.keymap.set({ 'v' }, "<", "<gv", { silent = true })
vim.keymap.set({ 'v' }, ">", ">gv", { silent = true })
-- Move text up and down
vim.keymap.set({ 'v' }, "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set({ 'v' }, "<A-k>", ":m .-2<CR>==", { silent = true })


vim.keymap.set({ 'i' }, "<C-enter>", "<esc>o", { silent = true })
vim.keymap.set({ 'i' }, "<S-enter>", "<esc>O", { silent = true })




-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist)

-- Needed for GUI frontends
vim.keymap.set('n', '<C-S-v>', 'a<C-r>+<Esc>')
vim.keymap.set('i', '<C-S-v>', '<C-r>+')
vim.keymap.set('v', '<C-S-v>', '<C-r>+')
