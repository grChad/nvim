---@type vim.lsp.Config
return {
   cmd = { 'typstyle' },
   filetypes = { 'typst' },
   root_markers = { '.git', '.typ' },
   -- init_options = {
   --    settings = {
   --       lint = { enable = false },
   --    },
   -- },
   -- settings = {},
}
