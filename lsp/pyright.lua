---@brief
---
--- https://github.com/microsoft/pyright
---
--- `pyright`, a static type checker and language server for python

local function set_python_path(path)
   local clients = vim.lsp.get_clients({
      bufnr = vim.api.nvim_get_current_buf(),
      name = 'pyright',
   })
   for _, client in ipairs(clients) do
      if client.settings then
         client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
      else
         client.config.settings =
            vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
      end
      client.notify('workspace/didChangeConfiguration', { settings = nil })
   end
end

---@type vim.lsp.Config
return {
   cmd = { 'pyright-langserver', '--stdio' },
   filetypes = { 'python' },
   root_markers = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyrightconfig.json',
      '.git',
   },
   settings = {
      python = {
         analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'workspace',
            typeCheckingMode = 'basic',
         },
      },
   },
   on_attach = function(client, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
         desc = 'Reconfigure pyright with the provided python path',
         nargs = 1,
         complete = 'file',
      })

      vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightRestart', function()
         if client == nil then
            vim.api.nvim_exec_autocmds('FileType', { group = 'MyLsp', buffer = bufnr })
            return
         end
         vim.lsp.stop_client(client.id, true)
         vim.defer_fn(function() vim.lsp.enable('pyright') end, 600)
      end, { desc = 'Restart pyright' })
   end,
}
