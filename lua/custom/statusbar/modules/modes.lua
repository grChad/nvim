local hl = require('custom.statusbar.constants').hl_groups.modes
local texthl = require('custom.statusbar.utils').texthl

local modes = {
   ['n'] = { 'NORMAL', hl.normal },
   ['niI'] = { 'NORMAL i', hl.normal },
   ['niR'] = { 'NORMAL r', hl.normal },
   ['niV'] = { 'NORMAL v', hl.normal },
   ['no'] = { 'N-PENDING', hl.normal },
   ['i'] = { 'INSERT', hl.insert },
   ['ic'] = { 'INSERT (completion)', hl.insert },
   ['ix'] = { 'INSERT completion', hl.insert },
   ['v'] = { 'VISUAL', hl.visual },
   ['V'] = { 'V-LINE', hl.visual },
   ['Vs'] = { 'V-LINE (Ctrl O)', hl.visual },
   [''] = { 'V-BLOCK', hl.visual },
   ['R'] = { 'REPLACE', hl.replace },
   ['Rv'] = { 'V-REPLACE', hl.replace },
   ['s'] = { 'SELECT', hl.select },
   ['S'] = { 'S-LINE', hl.select },
   [''] = { 'S-BLOCK', hl.select },
   ['c'] = { 'COMMAND', hl.command },
   ['cv'] = { 'COMMAND', hl.command },
   ['ce'] = { 'COMMAND', hl.command },
   ['r'] = { 'PROMPT', hl.confirm },
   ['rm'] = { 'MORE', hl.confirm },
   ['r?'] = { 'CONFIRM', hl.confirm },
   ['t'] = { 'TERMINAL', hl.terminal },
   ['nt'] = { 'NTERMINAL', hl.terminal },
   ['!'] = { 'SHELL', hl.terminal },
}

return function()
   local mode = vim.api.nvim_get_mode().mode
   local hl_mode = texthl(modes[mode][2], ' ' .. modes[mode][1])

   return hl_mode .. ' '
end
