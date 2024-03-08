local augroups = {}

augroups.text_yank = {
   highlight_yank = {
      event = 'TextYankPost',
      callback = function()
         vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
      end,
   },
}

augroups.disable_node = {
   node_modules = {
      event = { 'BufRead', 'BufNewFile' },
      pattern = '*/node_modules/*',
      command = 'lua vim.diagnostic.disable(0)',
   },
}

-- NOTE: Eliminar lineas porteriores al guardar, al final de la linea y al final del documento
augroups.buf_write_pre = {
   mkdir_before_saving = {
      event = { 'BufWritePre', 'FileWritePre' },
      pattern = '*',
      command = [[ silent! call mkdir(expand("<afile>:p:h"), "p") ]],
   },
   trim_extra_spaces_and_newlines = {
      event = 'BufWritePre',
      pattern = '*',
      command = [[
      let current_pos = getpos(".")
      silent! %s/\v\s+$|\n+%$//e
      silent! call setpos(".", current_pos)
      ]],
   },
}

-- NOTE: Para agregar el texto con wrap y con tabulacion.
augroups.prose = {
   wrap = {
      event = 'Filetype',
      pattern = { 'markdown', 'mdx', 'tex', 'html' },
      callback = function()
         vim.opt_local.wrap = true
         vim.opt_local.breakindentopt = 'shift:0'
      end,
   },
   wrap_showbreak = {
      event = 'Filetype',
      pattern = { 'json', 'css', 'scss' },
      callback = function()
         vim.opt_local.wrap = true
         vim.opt_local.breakindentopt = 'shift:2'
      end,
   },
}

-- NOTE: Para agregar indentado personalizado
augroups.indent_spaces = {
   three_space = {
      event = 'Filetype',
      pattern = { 'lua', 'vim', 'NvimTree' },
      callback = function()
         vim.opt_local.tabstop = 3
         vim.opt_local.shiftwidth = 3
      end,
   },
   four_space = {
      event = 'Filetype',
      pattern = { 'xml', 'groovy' },
      callback = function()
         vim.opt_local.tabstop = 4
         vim.opt_local.shiftwidth = 4
      end,
   },
}

-- Para eliminar el encadenamiento de sangrias en js
augroups.for_language = {
   for_javascript = {
      event = 'Filetype',
      pattern = { 'javascript' },
      callback = function()
         vim.cmd([[let g:javascript_opfirst = 1]])
      end,
   },
   for_all = {
      event = 'Filetype',
      pattern = '*',
      callback = function()
         vim.opt.formatoptions:remove('c')
         vim.opt.formatoptions:remove('r')
         vim.opt.formatoptions:remove('o')
      end,
   },
}

augroups.custom_statusColumn = {
   status_column_on = {
      event = 'Filetype',
      pattern = {
         'html',
         'css',
         'scss',
         'javascript',
         'javascriptreact',
         'jsx',
         'typescript',
         'typescriptreact',
         'vue',
         'tsx',
         'json',
         'python',
         'dart',
         'rust',
         'lua',
         'svelte',
      },
      callback = function()
         vim.opt_local.statuscolumn = "%!v:lua.require('core.utils').status_column()"
         -- vim.opt_local.statuscolumn = "%!v:lua.require('core.utils').statuscolumn()"
      end,
   },
}

-- HACK: Lsp, es mas rapido que declararlo en el on_attach.
augroups.lsp_Attach = {
   lsp_on_attach = {
      event = 'LspAttach',
      desc = 'Acciones LSP',
      callback = function(args)
         local client = vim.lsp.get_client_by_id(args.data.client_id)
         client.server_capabilities.semanticTokensProvider = nil

         local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
         end

         -- Muestra información sobre símbolo debajo del cursor
         -- bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

         bufmap('n', 'K', function()
            local winid = require('ufo').peekFoldedLinesUnderCursor()
            if not winid then
               vim.lsp.buf.hover()
            end
         end)
         -- Mostrar argumentos de función
         bufmap('n', 'L', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

         -- Saltar a definición
         bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

         -- Saltar a declaración
         bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

         -- Mostrar implementaciones
         bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

         -- Saltar a definición de tipo
         bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

         -- Listar referencias
         bufmap('n', '<leader>rf', '<cmd>lua vim.lsp.buf.references()<cr>')

         -- Renombrar símbolo
         -- bufmap('n', '<leader>re', function()
         --    require('core.renamer').open()
         -- end)
         -- bufmap('n', '<leader>re', vim.lsp.buf.rename)
         bufmap('n', '<leader>re', ':IncRename')

         -- formatear manualmente
         bufmap('n', '<leader>fr', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>')

         -- Listar "code actions" disponibles en la posición del cursor
         bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
         bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

         -- Mostrar diagnósticos de la línea actual
         bufmap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<cr>')

         -- Saltar al diagnóstico anterior
         bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

         -- Saltar al siguiente diagnóstico
         bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
      end,
   },
}

local add_cmd = vim.api.nvim_create_autocmd
for group, commands in pairs(augroups) do
   local augroup = vim.api.nvim_create_augroup('AU_' .. group, { clear = true })

   for _, opts in pairs(commands) do
      local event = opts.event
      opts.event = nil
      opts.group = augroup
      add_cmd(event, opts)
   end
end
