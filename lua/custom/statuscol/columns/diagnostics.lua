local texthl = require('custom.statuscol.utils').texthl
local trimAndPad = require('custom.statuscol.utils').trimAndPad
local icons = grvim.lsp.signs
local severity = vim.diagnostic.severity

local cached = {
   [severity.ERROR] = texthl('DiagnosticError', trimAndPad(icons.Error, 2)),
   [severity.WARN] = texthl('DiagnosticWarn', trimAndPad(icons.Warn, 2)),
   [severity.INFO] = texthl('DiagnosticInfo', trimAndPad(icons.Info, 2)),
   [severity.HINT] = texthl('DiagnosticHint', trimAndPad(icons.Hint, 2)),
}

return function(win)
   local bufnr = vim.api.nvim_win_get_buf(win)
   local diagnostics = vim.diagnostic.get(bufnr, { lnum = vim.v.lnum - 1 })

   ---@type vim.diagnostic.Severity?
   local highest = nil

   for _, diag in ipairs(diagnostics) do
      if not highest or diag.severity < highest then highest = diag.severity end
   end

   local default_space = '  '
   if highest then
      return cached[highest] or default_space
   else
      return default_space
   end
end
