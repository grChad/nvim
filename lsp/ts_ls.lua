---@type vim.lsp.Config
return {
   init_options = { hostInfo = 'neovim' },
   cmd = { 'typescript-language-server', '--stdio' },
   filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
   },
   root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
   single_file_support = true, -- Funciona en archivos individuales, sin root_markers
   settings = {
      typescript = {
         format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
         },
      },
      javascript = {
         format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
         },
      },
      completions = {
         completeFunctionCalls = true,
      },
   },
}
