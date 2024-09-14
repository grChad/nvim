local TS = {}

local handlers = {
   ['textDocument/hover'] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = 'rounded', title = ' Hover ', silent = true }
   ),
   ['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = 'rounded', title = ' Help ' }
   ),
   ['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      { virtual_text = true }
   ),
}

local settings = {
   typescript = {
      format = {
         indentSize = vim.o.shiftwidth,
         convertTabsToSpaces = vim.o.expandtab,
         tabSize = vim.o.tabstop,
      },
   },
   javascript = {
      format = {
         indentSize = vim.o.shiftwidth,
         convertTabsToSpaces = vim.o.expandtab,
         tabSize = vim.o.tabstop,
      },
   },
   completions = {
      completeFunctionCalls = true,
   },
}

TS.handlers = handlers
TS.settings = settings
return TS
