-- NOTE: Configuraciones globales ----------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
vim.g.mkdp_filetypes = { 'markdown' }
vim.g.mkdp_auto_start = 0 -- for MarkdownPriview
vim.g.mkdp_auto_close = 0 -- for MarkdownPriview

vim.g.skip_ts_context_commentstring_module = true -- for plugin 'nvim-ts-context-commentstring'

-- for codeium
vim.g.codeium_disable_bindings = 1 -- add new keymaps
vim.cmd([[
let g:codeium_filetypes = {
  \ "bash": v:false,
  \ "markdown": v:false,
  \ "": v:false,
  \ }
]])

-- disable some default providers
for _, provider in ipairs({ 'node', 'perl', 'python3', 'ruby' }) do
   vim.g['loaded_' .. provider .. '_provider'] = 0
end

-- NOTE: Configuraciones locales -----------------------------------------------------
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.mousemodel = 'popup'
vim.opt.mousemoveevent = true

-- para el Cmd y statusline
-- opt.cmdheight = 0
vim.opt.confirm = true -- Confirmar cambios antes de cerrar el buffer
vim.opt.showmode = false -- mostrar modo Insert, Normal..
vim.opt.laststatus = 3 -- global statusline

-- Barra vertical de signos y numeros
vim.opt.signcolumn = 'yes' -- columna de signos
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.ruler = false
vim.opt.cursorline = true -- muesta la linea del cursor
vim.opt.colorcolumn = '90' -- limite de caracteres por linea

-- Indentado
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.wrap = false
vim.opt.linebreak = true

vim.opt.conceallevel = 0 -- Ocultar * markup para negrita y cursiva en markdown
vim.opt.list = true -- for mini.indentscope
vim.opt.listchars = { tab = '▏ ', lead = ' ', trail = '-', nbsp = '␣' }
vim.opt.fillchars = {
   foldopen = '',
   foldclose = '',
   -- fold = '⸱',
   fold = ' ',
   foldsep = ' ',
   diff = '╱',
   eob = ' ',
   lastline = ' ',
}

-- case insensitive searching
vim.opt.hlsearch = true -- highlight on search
vim.opt.ignorecase = false
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Save undo history and files
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.writebackup = false
vim.opt.backup = false -- creates a backup file
vim.opt.swapfile = false -- creates a swapfile

vim.opt.updatetime = 250 -- disminue el tiempo de refresco
vim.opt.timeoutlen = 300 -- para whick-key como ejemplo.

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- disable nvim intro
-- vim.opt.shortmess:append('sI') -- ver si es reemplazablo o lo restauro
vim.opt.shortmess:append({ s = true, I = true })
vim.opt.whichwrap:append('<>[]hl')

-- My custom
vim.opt.hidden = true -- para ToggleTerm
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Numero maximo para mostrar un popup

vim.opt.spelllang = { 'en', 'es', 'cjk' } -- Establecer idiomas en ese orden
vim.opt.spellsuggest = 'best,9' -- Muestra las 9 mejores opciones de correccion.
vim.opt.spelloptions = 'camel' -- Para que no muestre error ortografico en los CamelCase

vim.opt.scrolloff = 4 -- Dejar espacio encima o debajo del cursor
vim.opt.sidescrolloff = 8 -- Dejar espacio a los laterales del cursor
vim.opt.foldmethod = 'expr' -- folding, set to "expr" for treesitter based folding
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' -- set to "nvim_treesitter#foldexpr()" for treesitter based folding

-- NOTE: Configuracion de vim.o -----------------------------------------------------
-- modo del cursor
vim.o.guicursor = 'n-c-sm:block,i-ci-ve:ver25,r-cr-o-v:hor20'

vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'
vim.env.PATH = vim.env.PATH .. (is_windows and ';' or ':') .. vim.fn.stdpath('data') .. '/mason/bin'
