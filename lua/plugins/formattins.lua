return {
   {
      'stevearc/conform.nvim',
      event = { 'BufWritePre' },
      cmd = 'ConformInfo',
      keys = require('core.key_plugins').conform,
      init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
      config = function()
         require('conform').setup({
            formatters_by_ft = {
               ['javascript'] = { 'biome', 'prettierd' },
               ['javascriptreact'] = { 'biome', 'prettierd' },
               ['typescript'] = { 'biome', 'prettierd' },
               ['typescriptreact'] = { 'biome', 'prettierd' },
               ['json'] = { 'biome', 'prettierd' },
               ['jsonc'] = { 'biome', 'prettierd' },
               ['vue'] = { 'prettierd' },
               -- ['svelte'] = { 'prettierd' },
               -- ['python'] = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
               ['html'] = { 'prettierd' },
               ['yaml'] = { 'prettierd' },
               ['markdown'] = { 'prettierd' },
               ['markdown.mdx'] = { 'prettierd' },
               ['graphql'] = { 'prettierd' },
               ['handlebars'] = { 'prettierd' },

               ['lua'] = { 'stylua' },
               ['toml'] = { 'taplo' },
               ['typst'] = { 'typstyle' },
            },
            format_on_save = {
               lsp_format = 'fallback',
               timeout_ms = 500,
            },
            formatters = { -- Customize formatters
               prettierd = {
                  cwd = require('conform.util').root_file(grvim.formatter.prettier_cwd),
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
