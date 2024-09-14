local M = {}

---@param plugin string
function M.has(plugin)
   return require('lazy.core.config').spec.plugins[plugin] ~= nil
end

---@param fn fun()
function M.on_very_lazy(fn)
   vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
         fn()
      end,
   })
end

function M.deprecate(old, new)
   M.warn(('`%s` is deprecated. Please use `%s` instead'):format(old, new), {
      title = 'LazyVim',
      once = true,
      stacktrace = true,
      stacklevel = 6,
   })
end

return M
