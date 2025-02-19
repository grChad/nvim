return {
   {
      'neovim/nvim-lspconfig',
      event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
      init = function()
         vim.cmd('silent! do FileType')
      end,
      dependencies = {
         'saghen/blink.cmp',
         { 'j-hui/fidget.nvim', opts = {} }, -- $progress and notify
      },
      opts = require('plugins.lsp.opts_lsp'),

      ---@param opts PluginLspOpts
      config = function(_, opts)
         -- border en la ventana de LspInfo
         require('lspconfig.ui.windows').default_options.border = grvim.ui.border_inset

         require('plugins.lsp.util_lsp').config_diagnostics(opts)
         require('plugins.lsp.on_attach')

         local on_attach = require('plugins.lsp.util_lsp').on_attach
         local on_attach_without_hl = require('plugins.lsp.util_lsp').on_attach_sin_highlight
         local capabilities = require('blink.cmp').get_lsp_capabilities()
         local handlers = require('plugins.lsp.util_lsp').handlers
         local lspconfig = require('lspconfig')

         -- NOTE: configuracion completa de los Servidores LSP
         lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
            settings = require('plugins.lsp.servers.lua_ls'),
         })

         lspconfig.ts_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
            settings = require('plugins.lsp.servers.tsserver'),
         })
         lspconfig.biome.setup({})

         lspconfig.eslint.setup({
            root_dir = lspconfig.util.root_pattern('.eslintrc.*', 'eslintrc.*'),
            on_attach = require('plugins.lsp.servers.eslint').on_attach,
            settings = require('plugins.lsp.servers.eslint').settings,
         })

         lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            handlers = handlers,
            root_dir = lspconfig.util.root_pattern('tailwind.config.*'),
         })

         lspconfig.stylelint_lsp.setup({
            settings = require('plugins.lsp.servers.stylelint').settings,
         })

         lspconfig.pyright.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
            settings = require('plugins.lsp.servers.pyright'),
         })
         lspconfig.ruff.setup({})

         lspconfig.texlab.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
            settings = require('plugins.lsp.servers.tex_lab'),
         })

         for _, lsp in pairs({ 'html', 'cssls', 'jsonls', 'marksman', 'clangd', 'astro', 'yamlls' }) do
            lspconfig[lsp].setup({
               on_attach = on_attach,
               capabilities = capabilities,
               handlers = handlers,
            })
         end
      end,
   },

   {
      'williamboman/mason.nvim',
      cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUpdate' },
      build = ':MasonUpdate',
      keys = require('core.key_plugins').mason,
      opts = {
         ensure_installed = grvim.mason.ensure_installed,
         ui = {
            icons = {
               package_pending = ' ',
               package_installed = '󰄳 ',
               package_uninstalled = ' 󰚌',
            },
            border = grvim.ui.border_inset,
            width = 0.7,
            height = 0.8,
         },
      },
      ---@param opts MasonSettings | {ensure_installed: string[]}
      config = function(_, opts)
         require('mason').setup(opts)

         local mr = require('mason-registry')
         mr:on('package:install:success', function()
            vim.defer_fn(function()
               -- trigger FileType event to possibly load this newly installed LSP server
               require('lazy.core.handler.event').trigger({
                  event = 'FileType',
                  buf = vim.api.nvim_get_current_buf(),
               })
            end, 100)
         end)
         local function ensure_installed()
            for _, tool in ipairs(opts.ensure_installed) do
               local p = mr.get_package(tool)
               if not p:is_installed() then
                  p:install()
               end
            end
         end
         if mr.refresh then
            mr.refresh(ensure_installed)
         else
            ensure_installed()
         end
      end,
   },
}
