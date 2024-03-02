local M = {}

M.lua_ls = {
   settings = {
      Lua = {
         runtime = {
            version = 'LuaJIT',
         },
         diagnostics = {
            globals = { 'vim', 'require' },
            disable = { 'incomplete-signature-doc', 'trailing-space' },
            -- enable = false,
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
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
            maxPreload = 100000,
            preloadFileSize = 10000,
         },
         hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = 'Disable',
            semicolon = 'Disable',
            arrayIndex = 'Disable',
         },
         type = {
            castNumberToInteger = true,
         },
         completion = { workspaceWord = true, callSnippet = 'Both' },
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
