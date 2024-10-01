local GROUPS = {}

GROUPS.highlight_yank = {
   event = 'TextYankPost',
   callback = function()
      vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
   end,
}

GROUPS.clean_file_qf = {
   event = 'Filetype',
   pattern = { 'qf', 'help', 'man', 'lspinfo', 'spectre_panel' },
   callback = function()
      vim.opt_local.relativenumber = false
      vim.opt_local.number = false
      vim.opt_local.signcolumn = 'no'
      vim.opt_local.colorcolumn = ''
   end,
}

GROUPS.disable_node_modules = {
   event = { 'BufRead', 'BufNewFile' },
   pattern = '*/node_modules/*',
   command = 'lua vim.diagnostic.disable(0)',
}

-- NOTE: Para agregar el texto con wrap y con tabulacion.
GROUPS.text_wrap = {
   event = 'Filetype',
   pattern = { 'markdown', 'mdx', 'tex', 'html' },
   callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.breakindentopt = 'shift:0'
   end,
}
GROUPS.wrap_showbreak = {
   event = 'Filetype',
   pattern = { 'json', 'css', 'scss' },
   callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.breakindentopt = 'shift:2'
   end,
}

-- NOTE: Para agregar indentado personalizado
GROUPS.three_space = {
   event = 'Filetype',
   pattern = { 'lua', 'vim', 'NvimTree' },
   callback = function()
      vim.opt_local.tabstop = 3
      vim.opt_local.shiftwidth = 3
   end,
}
GROUPS.four_space = {
   event = 'Filetype',
   pattern = { 'xml', 'groovy', 'gdscript' },
   callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
   end,
}

-- Para eliminar el encadenamiento de sangrias en js
GROUPS.for_javascript = {
   event = 'Filetype',
   pattern = { 'javascript' },
   callback = function()
      vim.cmd([[let g:javascript_opfirst = 1]])
   end,
}
GROUPS.for_all = {
   event = 'Filetype',
   pattern = '*',
   callback = function()
      vim.opt.formatoptions:remove('c')
      vim.opt.formatoptions:remove('r')
      vim.opt.formatoptions:remove('o')
   end,
}

for group, opts in pairs(GROUPS) do
   local augroup = vim.api.nvim_create_augroup('AU_' .. group, { clear = true })

   local event = opts.event
   opts.event = nil
   opts.group = augroup
   vim.api.nvim_create_autocmd(event, opts)
end
