return function()
   local ok, gitsigns = pcall(require, 'gitsigns')
   if not ok then return ' ' end

   local bufnr = 0
   local result = gitsigns.statuscolumn(bufnr, vim.v.lnum)

   local space = ' '
   return result or space
end
