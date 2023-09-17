local on_attach = require('plugins.lsp.utils').on_attach
local on_attach_sin_highlight = require('plugins.lsp.utils').on_attach_sin_highlight
local capabilities = require('plugins.lsp.utils').capabilities
local handlers = require('plugins.lsp.utils').handlers
local handlers_ufo = require('plugins.lsp.utils').handler_ufo

local typescript_present, typescript = pcall(require, 'typescript')
local present, lspconfig = pcall(require, 'lspconfig')
if not present then
   return
end

local function border(hl_name)
   return {
      { ' ',   hl_name },
      { '▁', hl_name },
      { ' ',   hl_name },
      { '▏', hl_name },
      { ' ',   hl_name },
      { '▔', hl_name },
      { ' ',   hl_name },
      { '▕', hl_name },
   }
end
require('lspconfig.ui.windows').default_options.border = border('FloatBorder')

-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
if typescript_present then
   typescript.setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false,        -- enable debug logging for commands
      -- LSP Config options
      server = {
         root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
         capabilities = require('plugins.lsp.servers.tsserver').capabilities,
         handlers = require('plugins.lsp.servers.tsserver').handlers,
         on_attach = require('plugins.lsp.servers.tsserver').on_attach,
         settings = require('plugins.lsp.servers.tsserver').settings,
      },
   })
end

lspconfig.lua_ls.setup({
   on_attach = on_attach,
   capabilities = capabilities,
   handlers = handlers,

   root_dir = require('plugins.lsp.servers.sumneko_lua').root_dir,
   settings = require('plugins.lsp.servers.sumneko_lua').settings,
})

lspconfig.tailwindcss.setup({
   root_dir = lspconfig.util.root_pattern('tailwind.config.js', 'tailwind.config.cjs'),
   capabilities = require('plugins.lsp.servers.tailwindcss').capabilities,
   filetypes = require('plugins.lsp.servers.tailwindcss').filetypes,
   handlers = handlers,
   init_options = require('plugins.lsp.servers.tailwindcss').init_options,
   on_attach = require('plugins.lsp.servers.tailwindcss').on_attach,
   settings = require('plugins.lsp.servers.tailwindcss').settings,
})

lspconfig.stylelint_lsp.setup({
   filetypes = { 'css', 'scss', 'vue' },
   on_attach = on_attach,
   capabilities = capabilities,
   handlers = handlers,
   settings = require('plugins.lsp.servers.stylelint').settings,
})

for _, lsp in ipairs({ 'cssls', 'html', 'emmet_ls' }) do
   lspconfig[lsp].setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = on_attach_sin_highlight,
   })
end

local servers = {
   'svelte',
   'jsonls',
   'marksman',
   'pyright',
   'yamlls',
   'rust_analyzer',
   'clangd',
   'texlab',
}

for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      handlers = handlers,
      settings = {
         python = require('plugins.lsp.servers.pyright').settings.python,
         yaml = require('plugins.lsp.servers.yaml').settings.yaml,
         Rust = require('plugins.lsp.servers.rust_analyzer').settings.Rust,
         texlab = require('plugins.lsp.servers.texlab_set'),
      },
   })
end

require('ufo').setup({
   fold_virt_text_handler = handlers_ufo,
   close_fold_kinds = {},
})
