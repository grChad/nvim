local U = {}

-- NOTE: On Attach ------------------------------------------------------------
U.on_attach = function(client, bufnr)
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
   client.server_capabilities.documentFormattingProvider = true
   client.server_capabilities.documentRangeFormattingProvider = true
end

U.on_attach_sin_highlight = function(client, _)
   client.server_capabilities.semanticTokensProvider = nil
   client.server_capabilities.documentFormattingProvider = false
   client.server_capabilities.documentRangeFormattingProvider = false
end

-- NOTE: Capabilities ---------------------------------------------------------
-- U.capabilities = require('cmp_nvim_lsp').default_capabilities()
U.capabilities = vim.lsp.protocol.make_client_capabilities()
U.capabilities.textDocument.completion.completionItem = {
   documentationFormat = { 'markdown', 'plaintext' },
   snippetSupport = true,
   preselectSupport = true,
   insertReplaceSupport = true,
   labelDetailsSupport = true,
   deprecatedSupport = true,
   commitCharactersSupport = true,
   tagSupport = { valueSet = { 1 } },
   resolveSupport = {
      properties = {
         'documentation',
         'detail',
         'additionalTextEdits',
      },
   },
}
U.capabilities.textDocument.foldingRange = {
   dynamicRegistration = false,
   lineFoldingOnly = true,
}

-- NOTE: Handlers -------------------------------------------------------------
U.handlers = {
   ['textDocument/hover'] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = 'rounded', title = ' Hover ', max_width = 85, max_height = 18, silent = true }
   ),
   ['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = 'rounded', title = ' Help ', max_width = 85, max_height = 18 }
   ),
   ['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      { virtual_text = true, signs = true }
   ),
}

---@param opts PluginLspOpts
U.config_diagnostics = function(opts)
   local signs = grvim.lsp.signs

   for name, icon in pairs(signs) do
      name = 'DiagnosticSign' .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
   end

   vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
end

return U
