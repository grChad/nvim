return {
   {
      'stevearc/conform.nvim',
      event = { 'BufWritePre' },
      cmd = { 'ConformInfo' },
      keys = {
         {
            '<leader>fi',
            function()
               require('conform').format({ async = true, lsp_fallback = true })
            end,
            mode = '',
            desc = 'Format buffer',
         },
      },
      -- opts = {
      --    -- Define your formatters
      --    formatters_by_ft = {
      --       ['javascript'] = { 'prettierd' },
      --       ['javascriptreact'] = { 'prettierd' },
      --       ['typescript'] = { 'prettierd' },
      --       ['typescriptreact'] = { 'prettierd' },
      --       ['vue'] = { 'prettierd' },
      --       ['svelte'] = { 'prettierd' },
      --       ['html'] = { 'prettierd' },
      --       ['json'] = { 'prettierd' },
      --       ['jsonc'] = { 'prettierd' },
      --       ['yaml'] = { 'prettierd' },
      --       ['markdown'] = { 'prettierd' },
      --       ['markdown.mdx'] = { 'prettierd' },
      --       ['graphql'] = { 'prettierd' },
      --       ['handlebars'] = { 'prettierd' },
      --
      --       ['lua'] = { 'stylua' },
      --       ['toml'] = { 'taplo' },
      --       ['python'] = { 'black' },
      --       ['latex'] = { 'latexindent' },
      --    },
      --    format_on_save = { timeout_ms = 500, lsp_fallback = true },
      --    formatters = { -- Customize formatters
      --       shfmt = {
      --          prepend_args = { '-i', '2' },
      --       },
      --       prettierd = {
      --          -- condition = function(ctx)
      --          --    return vim.fs.basename(ctx.filename) ~= 'biome.json'
      --          -- end,
      --          cwd = require('conform.util').root_file({ '.prettierrc.json', 'package.json' }),
      --          require_cwd = true,
      --       },
      --    },
      -- },
      init = function()
         vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      end,
      config = function()
         require('conform').setup({
            formatters_by_ft = {
               ['javascript'] = { { 'biome', 'prettierd' } },
               ['javascriptreact'] = { { 'biome', 'prettierd' } },
               ['typescript'] = { { 'biome', 'prettierd' } },
               ['typescriptreact'] = { { 'biome', 'prettierd' } },
               ['json'] = { { 'biome', 'prettierd' } },
               ['jsonc'] = { { 'biome', 'prettierd' } },
               ['vue'] = { 'prettierd' },
               ['svelte'] = { 'prettierd' },
               ['html'] = { 'prettierd' },
               ['yaml'] = { 'prettierd' },
               ['markdown'] = { 'prettierd' },
               ['markdown.mdx'] = { 'prettierd' },
               ['graphql'] = { 'prettierd' },
               ['handlebars'] = { 'prettierd' },

               ['lua'] = { 'stylua' },
               ['toml'] = { 'taplo' },
               ['python'] = { 'black' },
               ['latex'] = { 'latexindent' },
            },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
            formatters = { -- Customize formatters
               shfmt = {
                  prepend_args = { '-i', '2' },
               },
               prettierd = {
                  cwd = require('conform.util').root_file({
                     '.prettierrc',
                     '.prettierrc.json',
                     '.prettierrc.yml',
                     '.prettierrc.yaml',
                     '.prettierrc.json5',
                     '.prettierrc.js',
                     '.prettierrc.mjs',
                     '.prettierrc.cjs',
                     '.prettierrc.toml',
                     'prettier.config.js',
                     'prettier.config.mjs',
                     'prettier.config.cjs',
                  }),
                  require_cwd = true,
               },
               biome = {
                  cwd = require('conform.util').root_file({ 'biome.json' }),
                  require_cwd = true,
               },
            },
         })
      end,
   },

   {
      'laytan/tailwind-sorter.nvim',
      cmd = {
         'TailwindSort',
         'TailwindSortOnSaveToggle',
      },
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
      build = 'cd formatter && npm i && npm run build',
      config = true,
   },
}
