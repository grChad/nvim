-- NOTE: Todavia hay una dependencia de 'lspconfig'
local util = require('lspconfig.util')

local root_file = {
   '.stylelintrc',
   '.stylelintrc.mjs',
   '.stylelintrc.cjs',
   '.stylelintrc.js',
   '.stylelintrc.json',
   '.stylelintrc.yaml',
   '.stylelintrc.yml',
   'stylelint.config.mjs',
   'stylelint.config.cjs',
   'stylelint.config.js',
}

root_file = util.insert_package_json(root_file, 'stylelint')

---@type vim.lsp.Config
return {
   cmd = { 'stylelint-lsp', '--stdio' },
   filetypes = {
      'astro',
      'css',
      'html',
      'less',
      'scss',
      'sugarss',
      'vue',
      'wxss',
   },
   root_markers = root_file,
   settings = {
      stylelintplus = {
         autoFixOnSave = true,
         autoFixOnFormat = true,
         validateOnSave = true,
      },
   },
}
