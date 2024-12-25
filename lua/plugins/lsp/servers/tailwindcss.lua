local M = {}

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.colorProvider = { dynamicRegistration = false }
-- capabilities.textDocument.foldingRange = {
--    dynamicRegistration = false,
--    lineFoldingOnly = true,
-- }

-- Settings
local filetypes = {
   'html',
   'mdx',
   'javascript',
   'javascriptreact',
   'typescript',
   'typescriptreact',
   'vue',
   'svelte',
   'astro',
}

local settings = {
   tailwindCSS = {
      lint = {
         cssConflict = 'warning',
         invalidApply = 'error',
         invalidConfigPath = 'error',
         invalidScreen = 'error',
         invalidTailwindDirective = 'error',
         invalidVariant = 'error',
         recommendedVariantOrder = 'warning',
      },
      experimental = {
         classRegex = {
            'tw`([^`]*)',
            'tw="([^"]*)',
            'tw={"([^"}]*)',
            'tw\\.\\w+`([^`]*)',
            'tw\\(.*?\\)`([^`]*)',
            { 'clsx\\(([^)]*)\\)', "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { 'classnames\\(([^)]*)\\)', "'([^']*)'" },
            { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
         },
      },
      validate = true,
   },
}

M.filetypes = filetypes
M.capabilities = capabilities
M.settings = settings
M.init_options = init_options

return M
