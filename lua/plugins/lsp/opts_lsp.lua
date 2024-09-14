return {
   ---@type vim.diagnostic.Opts
   diagnostics = {
      underline = true,
      virtual_text = { spacing = 4, source = 'if_many', prefix = '●' },
      signs = true,
      update_in_insert = false,
      float = {
         border = 'rounded',
         max_width = 90,
         source = true,
         title = ' Diagnostic ',
      },
      severity_sort = true,
   },
   inlay_hints = { enabled = true },
   -- TODO: ver como usar o que es 'dodelens'
   -- codelens = { enabled = true },
   document_highlight = { enabled = true }, -- lsp cursor word highlighting
   -- format = { formatting_options = nil, timeout_ms = nil },

   -- add any global capabilities here
   -- capabilities = {
   --    workspace = {
   --       fileOperations = {
   --          didRename = true,
   --          willRename = true,
   --       },
   --    },
   -- },
}
