return {
   -- NOTE: -------------------[for typescript]---------------------
   {
      'pmizio/typescript-tools.nvim',
      event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
      dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
      opts = {
         -- on_attach = function(client, bufnr)
         --    client.server_capabilities.semanticTokensProvider = nil
         -- end,
         handlers = require('plugins.lsp.util_lsp').handlers,
         settings = {
            tsserver_locale = 'es',
            separate_diagnostic_server = true,
            tsserver_file_preferences = {
               quotePreference = 'single',
               includeCompletionsForModuleExports = true,
               includeCompletionsForImportStatements = true,

               includeInlayParameterNameHints = 'literals', -- 'none' | 'literals' | 'all'
               includeInlayParameterNameHintsWhenArgumentMatchesName = true, --'boolean'
               includeInlayFunctionParameterTypeHints = true, -- 'boolean'
               includeInlayVariableTypeHints = true, -- 'boolean'
               includeInlayVariableTypeHintsWhenTypeMatchesName = true, -- 'boolean'
               includeInlayPropertyDeclarationTypeHints = true, -- 'boolean'
               includeInlayFunctionLikeReturnTypeHints = true, -- 'boolean'
               includeInlayEnumMemberValueHints = true, -- 'boolean'
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

   -- TODO: Probar si se puede reeemplazar por live-preview
   -- {
   --    'iamcco/markdown-preview.nvim',
   --    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
   --    build = 'cd app && yarn install',
   --    ft = 'markdown',
   --    keys = require('core.key_plugins').markdown_preview,
   -- },
   {
      'brianhuster/live-preview.nvim',
      ft = { 'markdown', 'html' },
      config = function()
         require('live-preview').setup({})
      end,
   },

   {
      'HakonHarnes/img-clip.nvim',
      cmd = 'PasteImage',
      ft = 'markdown',
      opts = {},
      keys = require('core.key_plugins').img_clip,
   },

   -- NOTE: -------------------[for Rest API]---------------------
   {
      'lima1909/resty.nvim',
      cmd = 'Resty',
      keys = require('core.key_plugins').resty,
      dependencies = { 'nvim-lua/plenary.nvim' },
   },
}
