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

   local win = require('plenary.popup').create(currName, {
      title = 'Rename',
      style = 'minimal',
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      relative = 'cursor',
      borderhighlight = 'FloatBorder',
      titlehighlight = 'FloatTitle',
      focusable = true,
      width = 25,
      height = 1,
      line = 'cursor+2',
      col = 'cursor-1',
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
end

return M
