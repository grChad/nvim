-- [left] modules
local file_name = require('custom.statusbar.modules.filename')
local lsp = require('custom.statusbar.modules.lsp')
local modes = require('custom.statusbar.modules.modes')

-- [right] modules
local directory = require('custom.statusbar.modules.directory')
local git = require('custom.statusbar.modules.git')
local ia = require('custom.statusbar.modules.ia')
local position = require('custom.statusbar.modules.cursor_position')
local spell = require('custom.statusbar.modules.spell_check')
local theme = require('custom.statusbar.modules.theme')
local user = require('custom.statusbar.modules.user')

vim.g.s_status_cwd = 0 -- % 3 == 0

---@alias GrConfigModes 'foreground' | 'background'
---@alias GrConfigUser { enabled?: boolean, icon?: string, color_icon?: string, name?: string }

---@alias GrConfigIaCodeium { enabled?: boolean, icon?: string, color_icon?: string }
---@alias GrConfigIaSupermaven { enabled?: boolean, icon?: string, color_icon?: string }
---@alias GrConfigIa { codeium?: GrConfigIaCodeium, supermaven?: GrConfigIaSupermaven }

---@alias GrConfigGit { icon_add?: string, color_add?: string, icon_remove?: string, color_remove?: string, icon_change?: string, color_change?: string, icon_branch?: string, color_branch?: string }

---@alias GrConfigLsp { icon_error?: string, color_error?: string, icon_warning?: string, color_warning?: string, icon_hint?: string, color_hint?: string, icon_info?: string, color_info?: string }

-- ---@class GrConfig
-- ---@field background? string
-- ---@field foreground? string
-- ---@field sub_foreground? string
-- ---@field separator_color? string
-- ---@field mode_style? GrConfigModes
-- ---@field lsp? GrConfigLsp
-- ---@field git? GrConfigGit
-- ---@field user? GrConfigUser
-- ---@field ia? GrConfigIa
--
-- ---@type GrConfig
-- local opts = {}

local M = {}

M.StatusLine = function()
   return table.concat({
      modes(),
      file_name(),
      lsp(),
      '%=',
      '%=',
      git(),
      user(),
      directory(),
      spell(),
      ia(),
      theme(),
      position(),
   })
end

----@param config? GrConfig
M.setup = function()
   -- local count_configs = 0
   --
   -- if type(config) == 'table' and config ~= nil then
   --    for _ in pairs(config) do
   --       count_configs = count_configs + 1
   --    end
   --
   --    if count_configs > 0 then opts = config end
   -- end

   -- require('statusbar.highlights')(opts)

   vim.o.statusline = "%!v:lua.require('custom.statusbar').StatusLine()"
end

return M
