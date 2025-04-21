return {
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
      build = 'cd app && npm install',
      ft = { 'markdown' },
      keys = require('core.key_plugins').markdown_preview,
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
