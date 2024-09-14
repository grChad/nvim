vim.api.nvim_create_autocmd('LspAttach', {
   group = vim.api.nvim_create_augroup('grChad-lsp-attach', { clear = true }),
   callback = function(event)
      local lsp_map = function(keys, func, desc)
         vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      lsp_map('L', vim.lsp.buf.signature_help, 'Signature Documentation')
      lsp_map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      lsp_map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
      lsp_map('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      lsp_map('go', vim.lsp.buf.type_definition, 'Type [D]efinition')
      lsp_map('<leader>re', function()
         require('utils.renamer').open()
      end, '[R]e[n]ame')
      lsp_map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      lsp_map('K', function()
         local winid = require('ufo').peekFoldedLinesUnderCursor()
         if not winid then
            vim.lsp.buf.hover()
         end
      end, 'Hover Documentation')
      lsp_map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      --

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client and client.server_capabilities.documentHighlightProvider then
         local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
         vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
         })

         vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
         })

         vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
               vim.lsp.buf.clear_references()
               vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
            end,
         })
      end

      -- Habilidar 'inlay_hint' si esta disponible en el lsp.
      if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
         lsp_map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            local msg = vim.lsp.inlay_hint.is_enabled() and 'Inlay Hints enabled' or 'Inlay Hints disabled'
            vim.notify(msg, vim.log.levels.INFO)
         end, '[T]oggle Inlay [H]ints')
      end

      if client and client.server_capabilities.semanticTokensProvider then
         vim.lsp.semantic_tokens = nil
         client.server_capabilities.semanticTokensProvider = nil
      end
   end,
})
