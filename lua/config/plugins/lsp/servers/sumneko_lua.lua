local M = {}

M.lua_ls = {
   settings = {
      Lua = {
         workspace = {
            checkThirdParty = false,
            maxPreload = 100000,
            preloadFileSize = 10000,
         },
         completion = { callSnippet = 'Replace' },
         telemetry = { enable = false },
      },
   },
}

local root_dir = require('lspconfig').util.root_pattern(
   '.luarc.json',
   '.luacheckrc',
   '.stylua.toml',
   'stylua.toml',
   'selene.toml',
   '.git'
)

M.root_dir = root_dir

return M
