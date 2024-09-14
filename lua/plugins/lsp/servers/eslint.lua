local M = {}

local on_attach = function(client, bufnr)
   vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
   })
end

M.settings = {
   codeAction = {
      disableRuleComment = {
         enable = true,
         location = 'separateLine',
      },
      showDocumentation = {
         enable = true,
      },
   },
   codeActionOnSave = {
      enable = false,
      mode = 'all',
   },
   format = true,
   nodePath = '',
   onIgnoredFiles = 'off',
   problems = {
      shortenToSingleLine = false,
   },
   quiet = false,
   rulesCustomizations = {},
   run = 'onType',
   useESLintClass = false,
   validate = 'on',
   workingDirectory = {
      mode = 'location',
   },
}

M.on_attach = on_attach
return M
