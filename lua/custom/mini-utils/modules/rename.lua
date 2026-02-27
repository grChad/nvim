-- https://github.com/filipdutescu/renamer.nvim en el futuro modificar desde aqui

local M = {}

local function get_client_with_rename()
   local clients = vim.lsp.get_clients({ bufnr = 0, method = 'textDocument/rename' })
   if #clients == 0 then
      vim.notify('Ningún LSP soporta rename', vim.log.levels.ERROR)
      return nil
   end
   return clients[1]
end

M.apply = function(curr, win)
   local raw_name = vim.api.nvim_get_current_line()
   if not vim.api.nvim_win_is_valid(win) then return end
   vim.api.nvim_win_close(win, true)

   -- Validación del nombre
   local safe_name = raw_name:gsub('^%s+', ''):gsub('%s+$', ''):gsub('%s+', '_')

   if safe_name == '' or #safe_name < 2 or #safe_name > 50 then
      vim.notify('❌ Nombre inválido', vim.log.levels.WARN)
      return
   end

   if safe_name == curr then return end

   local client = get_client_with_rename()
   if not client then return end

   local encoding = client.offset_encoding or 'utf-16'
   local params = vim.lsp.util.make_position_params(0, encoding)

   ---@type lsp.RenameParams
   local rename_params = {
      textDocument = params.textDocument,
      position = params.position,
      newName = safe_name,
   }

   vim.lsp.buf_request(0, 'textDocument/rename', rename_params)
end

M.run = function()
   local currName = vim.fn.expand('<cword>') .. ' '

   -- Posición absoluta del cursor en pantalla (1-based)
   local screen_row = vim.fn.screenrow()
   local screen_col = vim.fn.screencol()

   -- Offset deseado: 2 líneas abajo, alineado al inicio del símbolo (calculado previamente)
   local line = screen_row + 2
   local col = screen_col - 3 -- ajusta este offset según tu alineación horizontal

   -- Asegurar que el popup no se salga de la pantalla (considerando borde y altura)
   local height = 1
   local border_thickness = 1
   local max_line = vim.o.lines - height - 2 * border_thickness
   if line > max_line then line = max_line end

   local width = 25
   local max_col = vim.o.columns - width - 2 * border_thickness
   if col > max_col then col = max_col end

   local win = require('plenary.popup').create(currName, {
      title = 'Rename',
      style = 'minimal',
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      relative = 'editor',
      borderhighlight = 'FloatBorder',
      titlehighlight = 'FloatTitle',
      focusable = true,
      width = width,
      height = height,
      line = line,
      col = col,
      zindex = 60, -- pare evitar que otros popups se superpongan
   })

   -- Deshabilitar autocompletado para este buffer
   local buf = vim.api.nvim_win_get_buf(win)
   vim.b[buf].completion = false -- Buffer-locall

   local map_opts = { noremap = true, silent = true, nowait = true }

   vim.cmd('normal w')
   vim.cmd('startinsert')

   -- Crear el comando string escapado correctamente
   local apply_cmd = string.format(
      "lua require('custom.mini-utils.modules.rename').apply('%s', %d)",
      currName:gsub("'", "''"), -- Escapar comillas simples
      win
   )

   local keymaps = {
      i = '<cmd>stopinsert | ' .. apply_cmd .. '<CR>',
      n = '<cmd>stopinsert | ' .. apply_cmd .. '<CR>',
   }

   local set_keymap = vim.api.nvim_buf_set_keymap

   for mode, mapping in pairs(keymaps) do
      set_keymap(0, mode, '<Esc>', '<cmd>stopinsert | q!<CR>', map_opts)
      set_keymap(0, mode, '<CR>', mapping, map_opts)
   end

   -- NUEVO: Autocomando para cerrar el popup cuando pierde el foco
   local close_on_leave = vim.api.nvim_create_augroup('RenamePopupLeave', { clear = true })

   vim.api.nvim_create_autocmd('WinEnter', {
      group = close_on_leave,
      buffer = buf,
      callback = function()
         if vim.api.nvim_win_is_valid(win) then vim.cmd('redrawstatus') end
      end,
   })
end

return M
