-- :7 'neovim/nvim-lspconfig',
-- :156 'williamboman/mason.nvim',

return {
   -- lspconfig
   {
      'neovim/nvim-lspconfig',
      event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
      init = function()
         vim.cmd('silent! do FileType')
      end,
      dependencies = {
         { 'j-hui/fidget.nvim', opts = {} }, -- $progress and notify
      },
      opts = require('plugins.lsp.opts_lsp'),
      config = function(_, opts)
         require('plugins.lsp.util_lsp').config_diagnostics(opts)
         require('plugins.lsp.on_attach')

         -- local capabilities = vim.lsp.protocol.make_client_capabilities()
         -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

         -- local on_attach = require('plugins.lsp.util_lsp').on_attach
         local on_attach_sin_highlight = require('plugins.lsp.util_lsp').on_attach_sin_highlight
         local capabilities = require('plugins.lsp.util_lsp').capabilities
         local handlers = require('plugins.lsp.util_lsp').handlers
         --
         local lspconfig = require('lspconfig')

         -- configuracion completa de los diagnosticos

         lspconfig.lua_ls.setup({
            -- on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
            settings = require('plugins.lsp.servers.lua_ls'),
         })

         -- lspconfig.tsserver.setup({
         --    on_attach = on_attach,
         --    capabilities = capabilities,
         --    handlers = require('config.plugins.lsp.servers.tsserver').handlers,
         --    settings = require('config.plugins.lsp.servers.tsserver').settings,
         -- })
         lspconfig.biome.setup({})
         --
         lspconfig.eslint.setup({
            -- root_dir = lspconfig.util.root_pattern('.eslintrc.*', 'eslintrc.*'),
            on_attach = require('plugins.lsp.servers.eslint').on_attach,
            settings = require('plugins.lsp.servers.eslint').settings,
         })
         --
         lspconfig.tailwindcss.setup({
            capabilities = require('plugins.lsp.servers.tailwindcss').capabilities,
            handlers = handlers,

            root_dir = lspconfig.util.root_pattern('tailwind.config.*'),
            filetypes = require('plugins.lsp.servers.tailwindcss').filetypes,
            init_options = require('plugins.lsp.servers.tailwindcss').init_options,
            settings = require('plugins.lsp.servers.tailwindcss').settings,
         })
         --
         lspconfig.stylelint_lsp.setup({
            filetypes = { 'css', 'scss', 'vue' },
            -- on_attach = on_attach,
            -- capabilities = capabilities,
            -- handlers = handlers,
            settings = require('plugins.lsp.servers.stylelint').settings,
         })
         --
         for _, lsp in ipairs({ 'html' }) do
            lspconfig[lsp].setup({
               capabilities = capabilities,
               handlers = handlers,
               on_attach = on_attach_sin_highlight,
            })
         end
         lspconfig.emmet_language_server.setup({
            -- filetypes = { 'html', 'htmldjango', 'css', 'scss', 'vue' },
         })
         --
         lspconfig.cssls.setup({
            capabilities = require('plugins.lsp.util_lsp').capabilitiesCss,
            settings = {
               css = {
                  validate = true,
               },
               less = {
                  validate = true,
               },
               scss = {
                  validate = true,
               },
            },
         })

         -- formater and linter for 'Python', made in Rust
         lspconfig.ruff_lsp.setup({})

         -- stylua: ignore
         local servers = {
            'jsonls', 'marksman', 'pyright', 'yamlls', 'rust_analyzer',
            'clangd', 'astro', 'texlab',
         }

         for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
               -- on_attach = on_attach,
               capabilities = capabilities,
               handlers = handlers,
               settings = {
                  python = require('plugins.lsp.servers.pyright').settings.python,
                  yaml = require('plugins.lsp.servers.yaml').settings.yaml,
                  Rust = require('plugins.lsp.servers.rust_analyzer').settings.Rust,
                  texlab = require('plugins.lsp.servers.tex_lab'),
               },
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
