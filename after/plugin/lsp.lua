-- Configure for all LSP servers
vim.lsp.config('*', {
   capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- Enable LSP servers
vim.lsp.enable({
   'luals',
   'ts_ls',
   'biome',
   'html',
   'cssls',
   'stylelint_lsp',
   'astro',
   'pyright',
   'ruff',
   'jsonls',
   'marksman',
   'texlab',
   'tailwind',
})

-- config LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
   group = vim.api.nvim_create_augroup('GrLspAttach', { clear = true }),
   callback = function(args)
      local lsp_map = function(keys, func, desc)
         vim.keymap.set('n', keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
      end

      lsp_map(
         'L',
         function()
            vim.lsp.buf.signature_help({ border = 'single', title = ' Ayuda ', max_width = 80, max_height = 18 })
         end,
         'Signature Documentation'
      )
      lsp_map('gd', require('snacks').picker.lsp_definitions, '[G]oto [D]efinition')
      lsp_map('gt', require('snacks').picker.lsp_type_definitions, 'Type [D]efinition')
      lsp_map('gr', require('snacks').picker.lsp_references, '[G]oto [R]eferences')
      lsp_map('gi', require('snacks').picker.lsp_implementations, '[G]oto [I]mplementation')
      lsp_map('gO', require('snacks').picker.lsp_symbols, '[D]ocument [S]ymbols')
      lsp_map('<Leader>ws', require('snacks').picker.lsp_workspace_symbols, '[W]orkspace [S]ymbols')
      lsp_map('<Leader>re', vim.lsp.buf.rename, '[R]e[n]ame')
      lsp_map('<Leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      lsp_map(
         'K',
         function() vim.lsp.buf.hover({ border = 'single', title = ' Hover ', max_width = 80, max_height = 18 }) end,
         'Hover Documentation'
      )
      lsp_map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -----------------------------[ Highlight References ]-----------------------------
      -- Los siguientes 2 autocommands son usados para resaltar referencias de la palabra
      -- bajo el cursor cuando el cursor se queda en ella durante un poco.
      -- Ver `:help CursorHold` para informacion sobre cuando se ejecuta esto.

      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      -- Cuando mueves el cursor, se borraran los highlight (el segundo autocommand).
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client and client.server_capabilities.documentHighlightProvider then
         local highlight_augroup = vim.api.nvim_create_augroup('GRLspHighlight', { clear = false })
         vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = args.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
         })

         vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = args.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
         })

         vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('GRLspDetach', { clear = true }),
            callback = function(event2)
               vim.lsp.buf.clear_references()
               vim.api.nvim_clear_autocmds({ group = 'GRLspHighlight', buffer = event2.buf })
            end,
         })
      end

      -- Habilidar 'inlay_hint' si esta disponible en el lsp.
      if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
         lsp_map('<leader>ih', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            local msg = vim.lsp.inlay_hint.is_enabled() and 'Inlay Hints: Enabled 😀' or 'Inlay Hints: Disabled 😭'
            vim.notify(msg, vim.log.levels.INFO)
         end, '[T]oggle Inlay [H]ints')
      end

      -- Desabilitar 'semantic_tokens' si esta disponible en el lsp.
      if client and client.server_capabilities.semanticTokensProvider then
         vim.lsp.semantic_tokens = nil
         client.server_capabilities.semanticTokensProvider = nil
      end
   end,
})
