local function setup_gitsigns_refresh()
   local gitsigns = require('gitsigns')
   vim.api.nvim_create_autocmd('BufWinEnter', {
      callback = function()
         local bufnr = vim.api.nvim_get_current_buf()
         local ok, _ = pcall(gitsigns.refresh, { bufnr = bufnr, max_payload = 50 })
         if ok then vim.schedule(function() vim.cmd.redrawstatus() end) end
      end,
   })
end

setup_gitsigns_refresh()

return function(win)
   local ok, gitsigns = pcall(require, 'gitsigns')
   if not ok then return ' ' end

   local bufnr = vim.api.nvim_win_get_buf(win)
   local result = gitsigns.statuscolumn(bufnr, vim.v.lnum)

   return result or ' '
end
