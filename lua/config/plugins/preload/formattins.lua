return {
   {
      'jose-elias-alvarez/null-ls.nvim',
      lazy = false,
      config = function()
         local status, null_ls = pcall(require, 'null-ls')

         if not status then
            return
         end

         local augroup_format = vim.api.nvim_create_augroup('Format', { clear = true })

         null_ls.setup({
            debug = false,

            sources = {
               null_ls.builtins.diagnostics.eslint_d.with({
                  -- stylua: ignore
                  condition = function(utils)
                     return utils.root_has_file({
                        '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json',
                     })
                  end,
               }),

               null_ls.builtins.formatting.eslint_d.with({
                  -- stylua: ignore
                  condition = function(utils)
                     return utils.root_has_file({
                        '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json',
                     })
                  end,
               }),
               null_ls.builtins.formatting.stylua,
               null_ls.builtins.formatting.prettierd.with({
                  -- stylua: ignore
                  filetypes = {
                     'html', 'yaml', 'markdown', 'json', 'javascript', 'javascriptreact',
                     'typescript', 'typescriptreact', 'svelte', 'vue',
                  },
                  env = {
                     PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(
                        '~/.config/nvim/lua/config/static/prettierrc.json'
                     ),
                  },
               }),
               null_ls.builtins.formatting.taplo,
               null_ls.builtins.formatting.black,
               null_ls.builtins.formatting.latexindent,
            },

            on_attach = function(client, _)
               if client.server_capabilities.documentFormattingProvider then
                  vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
                  vim.api.nvim_create_autocmd('BufWritePre', {
                     group = augroup_format,
                     buffer = 0,
                     callback = function()
                        vim.lsp.buf.format({ timeout_ms = 2000 })
                     end,
                  })
               end
            end,
         })
      end,
   },
}
