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

local iswin = vim.uv.os_uname().version:match('Windows')

---@param config_files string[]
---@param field string
---@param fname string
local insert_package_json = function(config_files, field, fname)
   local path = vim.fn.fnamemodify(fname, ':h')
   local root_with_package = vim.fs.dirname(vim.fs.find('package.json', { path = path, upward = true })[1])

   if root_with_package then
      -- Solo agregar package.json si contiene el parametro del campo
      local path_sep = iswin and '\\' or '/'
      for line in io.lines(root_with_package .. path_sep .. 'package.json') do
         if line:find(field) then
            config_files[#config_files + 1] = 'package.json'
            break
         end
      end
   end
   return config_files
end

root_file = insert_package_json(root_file, 'stylelint')

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
