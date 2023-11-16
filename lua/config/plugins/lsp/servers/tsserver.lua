local M = {}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
   },
}
capabilities.textDocument.codeAction = {
   dynamicRegistration = false,
   codeActionLiteralSupport = {
      codeActionKind = {
         valueSet = {
            '',
            'quickfix',
            'refactor',
            'refactor.extract',
            'refactor.inline',
            'refactor.rewrite',
            'source',
            'source.organizeImports',
         },
      },
   },
}
capabilities.textDocument.foldingRange = {
   dynamicRegistration = false,
   lineFoldingOnly = true,
}

local on_attach = function(client, bufnr)
   if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_document_highlight' })
      vim.api.nvim_create_autocmd('CursorHold', {
         callback = vim.lsp.buf.document_highlight,
         buffer = bufnr,
         group = 'lsp_document_highlight',
         desc = 'Document Highlight',
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
         callback = vim.lsp.buf.clear_references,
         buffer = bufnr,
         group = 'lsp_document_highlight',
         desc = 'Clear All the References',
      })
   end

   client.server_capabilities.semanticTokensProvider = nil
   client.server_capabilities.documentFormattingProvider = false
   client.server_capabilities.documentRangeFormattingProvider = false

   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end

   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local function filter(arr, fn)
   if type(arr) ~= 'table' then
      return arr
   end

   local filtered = {}
   for k, v in pairs(arr) do
      if fn(v, k, arr) then
         table.insert(filtered, v)
      end
   end

   return filtered
end

local function filterReactDTS(value)
   -- Depending on typescript version either uri or targetUri is returned
   if value.uri then
      return string.match(value.uri, '%.d.ts') == nil
   elseif value.targetUri then
      return string.match(value.targetUri, '%.d.ts') == nil
   end
end

local handlers = {
   ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', title = ' Hover ' }),
   ['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = 'rounded', title = ' Help ' }
   ),
   ['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      { virtual_text = true }
   ),
   ['textDocument/definition'] = function(err, result, method, ...)
      if vim.tbl_islist(result) and #result > 1 then
         local filtered_result = filter(result, filterReactDTS)
         return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
      end

      vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
   end,
}

local settings = {
   typescript = {
      inlayHints = {
         includeInlayParameterNameHints = 'all',
         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
         includeInlayFunctionParameterTypeHints = true,
         includeInlayVariableTypeHints = false,
         includeInlayPropertyDeclarationTypeHints = true,
         includeInlayFunctionLikeReturnTypeHints = false,
         includeInlayEnumMemberValueHints = true,
      },
      suggest = {
         includeCompletionsForModuleExports = true,
      },
   },
   javascript = {
      inlayHints = {
         includeInlayParameterNameHints = 'all',
         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
         includeInlayFunctionParameterTypeHints = true,
         includeInlayVariableTypeHints = false,
         includeInlayPropertyDeclarationTypeHints = true,
         includeInlayFunctionLikeReturnTypeHints = false,
         includeInlayEnumMemberValueHints = true,
      },
      suggest = {
         includeCompletionsForModuleExports = true,
      },
   },
}

M.capabilities = capabilities
M.on_attach = on_attach
M.handlers = handlers
M.settings = settings

return M
