return {
   -- NOTE: -------------------[for typescript]---------------------
   { 'jose-elias-alvarez/typescript.nvim' }, -- for tsserver

   -- NOTE: ----------------------[for dart]------------------------
   {
      'dart-lang/dart-vim-plugin',
      ft = 'dart',
      init = function()
         vim.cmd([[
            let dart_html_in_string=v:true
            let g:dart_style_guide = 2
            let g:dart_format_on_save = 1
            let g:dart_trailing_comma_indent = v:true
         ]])
      end,
   },

   {
      'akinsho/flutter-tools.nvim',
      ft = 'dart',
      config = function()
         require('flutter-tools').setup({
            ui = { border = 'rounded' },
            lsp = {
               color = {
                  -- show the derived colours for dart variables
                  enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
                  background = true,
                  foreground = false,
                  virtual_text = false, -- show the highlight using virtual text
               },
               on_attach = require('config.plugins.lsp.util_lsp').on_attach,
               capabilities = require('config.plugins.lsp.util_lsp').capabilities,
            },
            dev_log = { enabled = true },
         })
      end,
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
      cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
      build = function()
         vim.fn['mkdp#util#install']()
      end,
      keys = {
         {
            '<leader>cp',
            ft = 'markdown',
            '<cmd>MarkdownPreviewToggle<cr>',
            desc = 'Markdown Preview',
         },
      },
      config = function()
         vim.cmd([[do FileType]])
      end,
   },
}
