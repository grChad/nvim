return {
   Lua = {
      runtime = {
         version = 'LuaJIT',
      },
      diagnostics = {
         -- enable = false,
         globals = { 'vim', 'require' },
         -- incomplete-signature-doc: avisa de documentacion de firma incompleta
         -- trailing-space: avisa de espacios en el final de una sentencia
         -- no-unknown: avisa de variables no definidas
         disable = { 'incomplete-signature-doc', 'trailing-space', 'no-unknown' },
         groupSeverity = {
            strong = 'Warning',
            strict = 'Warning',
         },
         groupFileStatus = {
            ['ambiguity'] = 'Opened',
            ['await'] = 'Opened',
            ['codestyle'] = 'None',
            ['duplicate'] = 'Opened',
            ['global'] = 'Opened',
            ['luadoc'] = 'Opened',
            ['redefined'] = 'Opened',
            ['strict'] = 'Opened',
            ['strong'] = 'Opened',
            ['type-check'] = 'Opened',
            ['unbalanced'] = 'Opened',
            ['unused'] = 'Opened',
         },
         unusedLocalExclude = { '_*' },
      },
      workspace = {
         -- Make the server aware of Neovim runtime files
         -- library = vim.api.nvim_get_runtime_file('', true),
         library = {
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
            vim.fn.stdpath('data') .. '/lazy/ui/nvchad_types',
            vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy',
            '${3rd}/luv/library',
         },
         checkThirdParty = false,
         maxPreload = 100000,
         preloadFileSize = 10000,
      },
      codeLens = { enable = true },
      hint = {
         enable = true,
         setType = false,
         paramType = true,
         -- paramName = 'Disable',
         -- semicolon = 'Disable',
         -- arrayIndex = 'Disable',
      },
      doc = {
         privateName = { '^_' },
      },

      type = {
         castNumberToInteger = true,
      },
      completion = { workspaceWord = true, callSnippet = 'Both' },
      telemetry = { enable = false },
   },
}
