return {
   -- NOTE: -------------------[for typescript]---------------------
   {
      'pmizio/typescript-tools.nvim',
      event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
      dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
      opts = {
         on_attach = function(client, bufnr)
            client.server_capabilities.semanticTokensProvider = nil
         end,
         handlers = {
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
         },
         settings = {
            tsserver_locale = 'es',
            separate_diagnostic_server = true,
            tsserver_file_preferences = {
               includeInlayParameterNameHints = 'all',
               includeCompletionsForModuleExports = true,
               quotePreference = 'auto',
            },
            tsserver_plugins = {
               -- for TypeScript v4.9+
               '@styled/typescript-styled-plugin',
               -- or for older TypeScript versions
               -- 'typescript-styled-plugin',
            },
         },
      },
   },

   -- NOTE: --------------------[for markdown]----------------------
   {
      'lukas-reineke/headlines.nvim',
      ft = { 'markdown', 'norg', 'rmd', 'org' },
      config = function()
         vim.schedule(function()
            require('headlines').setup({
               markdown = {
                  headline_highlights = false,
                  dash_string = '─',
                  quote_string = '󱀡',
               },
            })
            require('headlines').refresh()
         end)
      end,
   },

   {
      'gaoDean/autolist.nvim',
      commit = '8d4a26f4f1750641b840fc50b0d867b5c9441aee',
      ft = 'markdown',
      config = function()
         require('autolist').setup()
      end,
   },

   {
      'iamcco/markdown-preview.nvim',
      build = 'cd app && npm install',
      cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
      ft = 'markdown',
      config = function()
         vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<CR>')
      end,
   },
}
