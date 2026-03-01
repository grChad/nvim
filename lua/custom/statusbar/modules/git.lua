local icons = grvim.statusbar.icons
local hl = require('custom.statusbar.constants').hl_groups.git
local texthl = require('custom.statusbar.utils').texthl
local button = require('custom.statusbar.utils').on_click
local gitStatusAndPad = require('custom.statusbar.utils').gitStatusAndPad
local trimAndPad = require('custom.statusbar.utils').trimAndPad
local separator = require('custom.statusbar.utils').separator()

--------------------------------- [ btn onclick function ] ---------------------------
vim.cmd([[
   function! ShowBranchName(a,b,c,d)
      lua require('custom.statusbar.function_btn').showBranchName()
   endfunction
]])

------------------------------------ [ functions ] ------------------------------------
---@return string
local diagnostics = function(status, add, remove, change)
   add = gitStatusAndPad(add, status.added)
   remove = gitStatusAndPad(remove, status.removed)
   change = gitStatusAndPad(change, status.changed)

   local show_diagnostics = add == '' and change == '' and remove == ''

   local caret_left = icons.separator.arrow.left
   if show_diagnostics then caret_left = '' end

   -- add highlight group
   add = texthl(hl.gitAdd, add)
   remove = texthl(hl.gitRemove, remove)
   change = texthl(hl.gitChange, change)
   caret_left = texthl(hl.gitIcon, caret_left)

   return add .. remove .. change .. caret_left
end

return function()
   local i_add = icons.git.add
   local i_remove = icons.git.remove
   local i_change = icons.git.change
   local branch_icon = icons.git.branch

   if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then return '' end

   local git_status = vim.b.gitsigns_status_dict
   local get_diagnostics = diagnostics(git_status, i_add, i_remove, i_change)

   local branch_name = git_status.head

   -- add highlight group
   branch_icon = texthl(hl.gitIcon, trimAndPad(branch_icon, 2))
   branch_name = texthl(hl.gitIcon, branch_name)

   ---@type string
   local str
   if vim.g.s_show_name_branch then
      str = get_diagnostics .. branch_icon .. branch_name
   else
      str = get_diagnostics .. branch_icon
   end

   return button(str, 'ShowBranchName') .. separator
end
