------------------------------------- vim.opt ----------------------------------------
local opt = vim.opt

-- opt.cmdheight = 0
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.confirm = true -- Confirmar cambios antes de cerrar el buffer
opt.clipboard = 'unnamedplus'
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.conceallevel = 0 -- Ocultar * markup para negrita y cursiva en markdown
opt.list = true -- for mini.indentscope
opt.listchars = { tab = '▏ ', lead = ' ', trail = '-' } -- for mini.indentscope
opt.fillchars = {
   foldopen = '',
   foldclose = '',
   -- fold = '⸱',
   fold = ' ',
   foldsep = ' ',
   diff = '╱',
   eob = ' ',
   lastline = ' ',
}

opt.ignorecase = false
opt.smartcase = true

opt.mouse = 'a'
opt.mousemodel = 'popup'

opt.number = true
opt.rnu = true
opt.signcolumn = 'yes'
opt.colorcolumn = '90'

opt.numberwidth = 2
opt.ruler = false

opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- disable nvim intro
opt.shortmess:append('sI')
opt.whichwrap:append('<>[]hl')

-- My custom
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.hidden = true
opt.writebackup = false
opt.backup = false -- creates a backup file
opt.swapfile = false -- creates a swapfile
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Numero maximo para mostrar un popup
opt.spelllang = { 'en', 'es', 'cjk' } -- Establecer idiomas en ese orden
opt.spellsuggest = 'best,9' -- Muestra las 9 mejores opciones de correccion.
opt.spelloptions = 'camel' -- Para que no muestre error ortografico en los CamelCase
opt.inccommand = 'split'
opt.scrolloff = 4 -- Dejar espacio encima o debajo del cursor
opt.sidescrolloff = 8 -- Dejar espacio a los laterales del cursor
opt.foldmethod = 'expr' -- folding, set to "expr" for treesitter based folding
opt.foldexpr = 'nvim_treesitter#foldexpr()' -- set to "nvim_treesitter#foldexpr()" for treesitter based folding

local icon_os = {
   fedora = ' ',
   debian = ' ',
   arch = ' ',
   ubuntu = ' ',
   manjaro = ' ',
   linuxmint = ' ',
   pop = ' ',
   zorin = ' ',
   cereus = '󰶵 ',
   linux = ' ',
}

local hostname = vim.fn.hostname()
local icon_use = icon_os[hostname] or icon_os.linux

opt.title = true -- set the title of window to the value of the titlestring
opt.titlestring = ' ../%t ' .. ' ↭  NeoVim and ' .. icon_use

-------------------------------------- vim.o -----------------------------------------
-- modo del cursor
vim.o.guicursor = 'n-c-sm:block,i-ci-ve:ver25,r-cr-o-v:hor20'

vim.o.encoding = 'utf-8'
vim.cmd('set fileencoding=utf-8')

vim.o.foldenable = true
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99

-------------------------------------- vim.g -----------------------------------------
vim.g.mapleader = ' '
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
vim.g.mkdp_auto_start = 0 -- for MarkdownPriview
vim.g.mkdp_auto_close = 0 -- for MarkdownPriview

-- for codeium
vim.g.codeium_disable_bindings = 1
vim.cmd([[
let g:codeium_filetypes = {
  \ "bash": v:false,
  \ "markdown": v:false,
  \ }
]])

-- disable some default providers
for _, provider in ipairs({ 'node', 'perl', 'python3', 'ruby' }) do
   vim.g['loaded_' .. provider .. '_provider'] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'
vim.env.PATH = vim.env.PATH .. (is_windows and ';' or ':') .. vim.fn.stdpath('data') .. '/mason/bin'
