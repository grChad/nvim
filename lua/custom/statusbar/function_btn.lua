local M = {}

M.toggle_file_name = function()
   if vim.g.s_filename_is_active then
      vim.g.s_filename_is_active = false
   else
      vim.g.s_filename_is_active = true
   end

   vim.api.nvim_command('redraw!')
end

M.toggle_servers = function()
   if vim.g.s_servers_is_active then
      vim.g.s_servers_is_active = false
   else
      vim.g.s_servers_is_active = true
   end

   vim.api.nvim_command('redraw!')
end

M.showBranchName = function()
   if vim.g.s_show_name_branch then
      vim.g.s_show_name_branch = false
   else
      vim.g.s_show_name_branch = true
   end

   vim.api.nvim_command('redraw!')
end

M.showUser = function()
   if vim.g.s_show_user then
      vim.g.s_show_user = false
   else
      vim.g.s_show_user = true
   end

   vim.api.nvim_command('redraw!')
end

M.showCwd = function()
   vim.g.s_status_cwd = vim.g.s_status_cwd + 1
   vim.api.nvim_command('redraw!')
end

M.toggle_spell = function()
   if vim.g.s_show_spell then
      vim.g.s_show_spell = false
      vim.o.spell = false
      vim.notify('  Deshabilitando Spellchecking ... 😭😭')
   else
      vim.g.s_show_spell = true
      vim.o.spell = true
      vim.notify('  Habilitando Spellchecking ... 😃😃')
   end

   vim.api.nvim_command('redraw!')
end

M.assistant = function()
   local status_ok, api = pcall(require, 'supermaven-nvim.api')

   if status_ok then
      if api.is_running() then
         api.stop()
         vim.notify(' Assistant: Se ha deshabilitado 😭')
      else
         api.start()
         vim.notify(' Assistant: Habilitado 😊')
      end
   end

   vim.cmd('redraw!')
end

M.toggleTheme = function()
   local current = vim.g.gr_theme_mode or 'dark'

   if current == 'dark' then
      vim.g.gr_theme_mode = 'light'
   else
      vim.g.gr_theme_mode = 'dark'
   end

   -- Recargar el tema
   require('custom.gr-theme').reload()
   vim.cmd('doautocmd ColorScheme')
   vim.cmd('HighlightColors On') -- plugin  brenoprata10/nvim-highlight-colors
end

M.position = function()
   if vim.g.s_position_is_active then
      vim.g.s_position_is_active = false
   else
      vim.g.s_position_is_active = true
   end

   vim.api.nvim_command('redraw!')
end

return M
