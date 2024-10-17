-- :i  :inoremap    Insert
-- :n  :nnoremap    Normal
-- :v  :vnoremap    Visual and Select
-- :x  :xnoremap    Visual
-- :s  :snoremap    Select
-- :o  :onoremap    Operator-pending
-- :l  :lnoremap    Insert, Command-line, Lang-Arg
-- :c  :cnoremap    Command-line
-- :t  :tnoremap    Terminal

local cmd = function(str)
   return '<cmd>' .. str .. '<CR>'
end

local map = vim.keymap.set

map('n', '<leader>w', cmd('write'), { desc = 'Save file' })
map('n', '<leader>q', cmd('quit'), { desc = 'Quit file' })
map('n', '<leader>y', cmd('%y+'), { desc = 'copy whole file' })
-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
map('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = 'Dont copy replaced text', silent = true })

-- Espacar del modo insertar
map('i', 'kj', '<Esc>', { silent = true, desc = 'Escap' })
map('i', 'KJ', '<Esc>', { silent = true, desc = 'Escap' })

-- Allow moving the cursor through wrapped lines with j, k
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
map({ 'n', 'v' }, 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = 'Move down', expr = true })
map({ 'n', 'v' }, 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = 'Move up', expr = true })

-- Re-configurar las teclas de flechas
map({ 'i', 'v' }, '<Up>', '<Nop>', { desc = 'delete arrow up' })
map({ 'i', 'v' }, '<Down>', '<Nop>', { desc = 'delete arrow down' })
map({ 'n', 'i', 'v', 'c' }, '<Right>', '<Nop>', { desc = 'delete arrow right' })
map({ 'n', 'i', 'v', 'c' }, '<Left>', '<Nop>', { desc = 'delete arrow left' })
map('n', '<Up>', '<ScrollWheelUp>')
map('n', '<Down>', '<ScrollWheelDown>')

-- navigate within insert mode
map({ 'i', 'c' }, '<C-h>', '<Left>', { desc = 'Move left' })
map({ 'i', 'c' }, '<C-l>', '<Right>', { desc = 'Move right' })
map('i', '<C-j>', '<Down>', { desc = 'Move down' })
map('i', '<C-k>', '<Up>', { desc = 'Move up' })

-- Deleted characters in mode 'Command'
map('c', '<A-h>', '<BS>', { desc = 'delete to left' })
map('c', '<A-l>', '<Del>', { desc = 'delete to right' })

--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- mover Linea/Bloque arriba o abajo
map('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
map('x', '<A-j>', ":m '>+1<CR>gv-gv")
map('x', '<A-k>', ":m '<-2<CR>gv-gv")

-- Better indenting
map({ 'x' }, '<', '<gv', { desc = 'Indent left' })
map({ 'x' }, '>', '>gv', { desc = 'Indent right' })

-- Resize with arrows
map('n', '<A-S-Up>', ':resize -2<CR>', { desc = 'Resize up' })
map('n', '<A-S-Down>', ':resize +2<CR>', { desc = 'Resize down' })
map('n', '<A-S-Left>', ':vertical resize -2<CR>', { desc = 'Resize left' })
map('n', '<A-S-Right>', ':vertical resize +2<CR>', { desc = 'Resize right' })

-- ahora se usa toggleterm
-- map('n', '<leader>t', cmd('bo terminal'), { desc = 'Open terminal' })
-- map('t', '<leader>n', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- NOTE: para el buffer --------------------------------------------------------------
-- map('n', '<leader>x', function()
--    vim.cmd('BufferLineMoveNext')
--    vim.cmd('bprevious')
--    vim.cmd('BufferLineCloseRight')
-- end, { desc = 'Delete Buffer' })
-- map('n', '<leader>k', cmd('bnext'), { desc = 'Next Buffer' })
-- map('n', '<leader>j', cmd('bprevious'), { desc = 'Previous Buffer' })

-- NOTE: atajos especiales -----------------------------------------------------------
-- Options for search: clear highlight and word coincidences
map('n', 'm', cmd("lua require('gr-utils').search.clear()"), { silent = true, desc = 'no highlight' })
map('n', 'n', 'nzz' .. cmd("lua require('gr-utils').search.run()"), { desc = 'Next search' })
map('n', 'N', 'Nzz' .. cmd("lua require('gr-utils').search.run()"), { desc = 'Previous search' })

--keywordprg doc for 'man'
map('n', 'gk', cmd('norm! K'), { desc = 'Keywordprg' })

-- options for spell select
map('n', 'fs', 'i<C-x>s', { desc = 'Spell options' })

-- Inspect for Treesitter
map('n', '<leader>i', cmd('Inspect'), { desc = 'Inspect highlight' })

-- Toggle para booleanos: true|false, on|off, yes|no
map('n', '<leader>b', cmd("lua require('gr-utils').toggle()"), { desc = 'Toggle boolean' })

-- NOTE: Diagnostics for LSP ---------------------------------------------------------
-- disable diagnostics 'vim.diagnostic.open_float()'
vim.keymap.del('n', '<C-W>d')
vim.keymap.del('n', '<C-W><C-D>')

map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
