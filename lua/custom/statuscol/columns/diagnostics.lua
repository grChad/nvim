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

return function()
   local diagnostics = vim.diagnostic.get(0, { lnum = vim.v.lnum - 1 })

   ---@type vim.diagnostic.Severity?
   local highest = math.huge

   for _, diag in ipairs(diagnostics) do
      if diag.severity < highest then highest = diag.severity end
   end

   local default_space = '  '
   return cached[highest] or default_space
end
