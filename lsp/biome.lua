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

---@type vim.lsp.Config
return {
   cmd = { 'biome', 'lsp-proxy' },
   filetypes = {
      'astro',
      'css',
      'graphql',
      'javascript',
      'javascriptreact',
      'json',
      'jsonc',
      'svelte',
      'typescript',
      'typescript.tsx',
      'typescriptreact',
      'vue',
   },
   workspace_required = true,
   root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local root_files = { 'biome.json', 'biome.jsonc' }
      root_files = insert_package_json(root_files, 'biome', fname)
      local root_dir = vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1])
      on_dir(root_dir)
   end,
}
