local bin_name = 'marksman'
local cmd = { bin_name, 'server' }

---@type vim.lsp.Config
return {
   cmd = cmd,
   filetypes = { 'markdown', 'markdown.mdx' },
   root_markers = { '.marksman.toml', '.git' },
}
