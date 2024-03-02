return {
   {
      'stevearc/conform.nvim',
      event = { 'BufWritePre' },
      cmd = { 'ConformInfo' },
      keys = {
         {
            -- Customize or remove this keymap to your liking
            '<leader>fi',
            function()
               require('conform').format({ async = true, lsp_fallback = true })
            end,
            mode = '',
            desc = 'Format buffer',
         },
      },
      -- Everything in opts will be passed to setup()
      opts = {
         -- Define your formatters
         formatters_by_ft = {
            ['javascript'] = { 'prettierd' },
            ['javascriptreact'] = { 'prettierd' },
            ['typescript'] = { 'prettierd' },
            ['typescriptreact'] = { 'prettierd' },
            ['vue'] = { 'prettierd' },
            ['svelte'] = { 'prettierd' },
            ['html'] = { 'prettierd' },
            ['json'] = { 'prettierd' },
            ['jsonc'] = { 'prettierd' },
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
         -- Set up format-on-save
         format_on_save = { timeout_ms = 500, lsp_fallback = true },
         -- Customize formatters
         formatters = {
            shfmt = {
               prepend_args = { '-i', '2' },
            },
            eslint_d = {
               condition = function(ctx)
                  return vim.fs.find({
                     '.eslintrc.js',
                     '.eslintrc.cjs',
                     '.eslintrc.yaml',
                     '.eslintrc.yml',
                     '.eslintrc.json',
                  }, { path = ctx.filename, upward = true })[1]
               end,
            },
         },
      },
      init = function()
         vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      end,
   },
}
