local present, flu_tools = pcall(require, 'flutter-tools')

if not present then
   return
end

flu_tools.setup({
   ui = {
      border = 'rounded',
   },
   lsp = {
      color = {
         -- show the derived colours for dart variables
         enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
         background = true,
         foreground = false,
         virtual_text = false, -- show the highlight using virtual text
      },
      on_attach = require('plugins.lsp.utils').on_attach,
      capabilities = require('plugins.lsp.utils').capabilities,
   },
   dev_log = {
      enabled = true,
   },
})
