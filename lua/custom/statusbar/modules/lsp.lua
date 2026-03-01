local separator = require('custom.statusbar.utils').separator()
local icons = grvim.statusbar.icons
local texthl = require('custom.statusbar.utils').texthl
local button = require('custom.statusbar.utils').on_click
local hl = require('custom.statusbar.constants').hl_groups.lsp
local icons_lsp = grvim.lsp.signs
local trimAndPad = require('custom.statusbar.utils').trimAndPad

--------------------------------- [ btn onclick function ] ---------------------------
vim.cmd([[
   function! ToggleServers(a,b,c,d)
      lua require('custom.statusbar.function_btn').toggle_servers()
   endfunction
]])

------------------------------------ [ functions ] ------------------------------------
local getServers = function()
   local icon = icons.separator.arrow.right
   local servers = {}

   local clients = vim.lsp.get_clients({ bufnr = 0 })
   for _, server in pairs(clients) do
      table.insert(servers, server.name)
   end

   ---@type string
   local str
   if #servers > 0 then str = icon .. '[' .. table.concat(servers, ' ') .. ']' end

   return { str = str, hasLsp = #servers > 0 }
end

local diagnostic = function(error, warning, hint, info)
   if not rawget(vim, 'lsp') then return '' end

   local i_error = texthl(hl.lspError, trimAndPad(error, 2))
   local i_warn = texthl(hl.lspWarning, trimAndPad(warning, 2))
   local i_hint = texthl(hl.lspHint, trimAndPad(hint, 2))
   local i_info = texthl(hl.lspInfo, trimAndPad(info, 2))

   local messages = {
      { severity = vim.diagnostic.severity.ERROR, hl = i_error },
      { severity = vim.diagnostic.severity.WARN, hl = i_warn },
      { severity = vim.diagnostic.severity.HINT, hl = i_hint },
      { severity = vim.diagnostic.severity.INFO, hl = i_info },
   }

   local caret_right = texthl(hl.lspIcon, icons.separator.arrow.right)
   local message_str = ''

   for _, message in ipairs(messages) do
      local count = #vim.diagnostic.get(0, { severity = message.severity })
      if count > 0 then message_str = message_str .. message.hl .. count .. ' ' end
   end

   if #vim.diagnostic.get(0) == 0 then caret_right = '' end

   return caret_right .. message_str
end

return function()
   local lspIcon = texthl(hl.lspIcon, icons.others.lsp)
   local servers = getServers()

   local icon_diagnostics = diagnostic(icons_lsp.Error, icons_lsp.Warn, icons_lsp.Hint, icons_lsp.Info)

   if not servers.hasLsp then return '' end

   ---@type string
   local finalStr

   if vim.g.s_servers_is_active then
      finalStr = lspIcon .. servers.str .. icon_diagnostics
   else
      finalStr = lspIcon .. icon_diagnostics
   end

   return separator .. button(finalStr, 'ToggleServers')
end
