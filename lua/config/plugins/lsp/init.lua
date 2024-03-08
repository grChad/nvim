-- :7 'neovim/nvim-lspconfig',
--      :17 'folke/neoconf.nvim'
--      :18 'folke/neodev.nvim'
-- :156 'williamboman/mason.nvim',

local Util = require('config.util')
local user = require('core.user')

return {
   -- lspconfig
   {
      'neovim/nvim-lspconfig',
      event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
      init = function()
         vim.cmd('silent! do FileType')
      end,
      dependencies = {
         { 'folke/neoconf.nvim', cmd = 'Neoconf', config = false, dependencies = { 'nvim-lspconfig' } },
         { 'folke/neodev.nvim', opts = {} },
      },
      opts = {
         diagnostics = {
            underline = true,
            update_in_insert = false,
            signs = true,
            virtual_text = { spacing = 4, source = 'if_many', prefix = '●' },
            float = {
               border = 'rounded',
               max_width = 90,
               source = 'always',
               title = ' Diagnostic ',
            },
            severity_sort = true,
         },
         inlay_hints = { enabled = false },
         format = { formatting_options = nil, timeout_ms = nil },
      },
      config = function(_, opts)
         if Util.has('neoconf.nvim') then
            local plugin = require('lazy.core.config').spec.plugins['neoconf.nvim']
            require('neoconf').setup(require('lazy.core.plugin').values(plugin, 'opts', false))
         end

         local on_attach = require('config.plugins.lsp.util_lsp').on_attach
         local on_attach_sin_highlight = require('config.plugins.lsp.util_lsp').on_attach_sin_highlight
         local capabilities = require('config.plugins.lsp.util_lsp').capabilities
         local handlers = require('config.plugins.lsp.util_lsp').handlers

         local lspconfig = require('lspconfig')

         -- configuracion completa de los diagnosticos
         require('config.plugins.lsp.util_lsp').config_diagnostics(opts)

         lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,

            root_dir = require('config.plugins.lsp.servers.sumneko_lua').root_dir,
            settings = require('config.plugins.lsp.servers.sumneko_lua').settings,
         })

         -- lspconfig.tsserver.setup({
         --    on_attach = on_attach,
         --    capabilities = capabilities,
         --    handlers = require('config.plugins.lsp.servers.tsserver').handlers,
         --    settings = require('config.plugins.lsp.servers.tsserver').settings,
         -- })
         lspconfig.biome.setup({})

         lspconfig.eslint.setup({
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern('.eslintrc.*', 'eslintrc.*'),
            on_attach = require('config.plugins.lsp.servers.eslint').on_attach,
            settings = require('config.plugins.lsp.servers.eslint').settings,
         })

         lspconfig.tailwindcss.setup({
            on_attach = require('config.plugins.lsp.servers.tailwindcss').on_attach,
            capabilities = require('config.plugins.lsp.servers.tailwindcss').capabilities,
            handlers = handlers,

            root_dir = lspconfig.util.root_pattern('tailwind.config.*'),
            filetypes = require('config.plugins.lsp.servers.tailwindcss').filetypes,
            init_options = require('config.plugins.lsp.servers.tailwindcss').init_options,
            settings = require('config.plugins.lsp.servers.tailwindcss').settings,
         })

         lspconfig.stylelint_lsp.setup({
            filetypes = { 'css', 'scss', 'vue' },
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers,
            settings = require('config.plugins.lsp.servers.stylelint').settings,
         })

         for _, lsp in ipairs({ 'html' }) do
            lspconfig[lsp].setup({
               capabilities = capabilities,
               handlers = handlers,
               on_attach = on_attach_sin_highlight,
            })
         end
         lspconfig.emmet_language_server.setup({
            filetypes = { 'html', 'htmldjango', 'css', 'scss', 'vue' },
         })

         lspconfig.cssls.setup({
            capabilities = require('config.plugins.lsp.util_lsp').capabilitiesCss,
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

         -- stylua: ignore
         local servers = {
            'svelte', 'jsonls', 'marksman', 'pyright',
            'yamlls', 'rust_analyzer', 'clangd', 'texlab', 'astro'
         }

         for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
               on_attach = on_attach,
               capabilities = capabilities,
               handlers = handlers,
               settings = {
                  python = require('config.plugins.lsp.servers.pyright').settings.python,
                  yaml = require('config.plugins.lsp.servers.yaml').settings.yaml,
                  Rust = require('config.plugins.lsp.servers.rust_analyzer').settings.Rust,
                  texlab = require('config.plugins.lsp.servers.texlab_set'),
               },
            })
         end

         require('ufo').setup({
            fold_virt_text_handler = require('config.plugins.lsp.util_lsp').handler_ufo,
            close_fold_kinds = {},
         })
      end,
   },

   {
      'williamboman/mason.nvim',
      cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUpdate' },
      build = ':MasonUpdate',
      keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
      opts = {
         ensure_installed = user.mason.ensure_installed,
         PATH = 'skip',
         ui = {
            icons = {
               package_pending = ' ',
               package_installed = '󰄳 ',
               package_uninstalled = ' 󰚌',
            },
            border = user.ui.border_inset,
            width = 0.7,
            height = 0.8,
         },
         max_concurrent_installers = 5,
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
