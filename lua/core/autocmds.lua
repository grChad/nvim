local GROUPS = {}

GROUPS.highlight_yank = {
   event = 'TextYankPost',
   callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 }) end,
}

GROUPS.disable_node_modules = {
   event = { 'BufRead', 'BufNewFile' },
   pattern = '*/node_modules/*',
   command = 'lua vim.diagnostic.disable(0)',
}

GROUPS.disable_new_comment = {
   event = { 'FileType', 'BufEnter', 'BufWinEnter' },
   pattern = '*',
   callback = function()
      -- NOTE: [schedule]: Ejecuta después de que los plugins hayan terminado
      vim.schedule(function() vim.bo.formatoptions = vim.bo.formatoptions:gsub('[cro]', '') end)
   end,
}

for group, opts in pairs(GROUPS) do
   local augroup = vim.api.nvim_create_augroup('AU_' .. group, { clear = true })

   local event = opts.event
   opts.event = nil
   opts.group = augroup
   vim.api.nvim_create_autocmd(event, opts)
end
