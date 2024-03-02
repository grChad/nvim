vim.api.nvim_set_hl(0, 'FoldSignsOpen', { fg = '#EEFFFF', bg = '#292C3C' })
vim.api.nvim_set_hl(0, 'FoldSignsClosed', { fg = '#a5adce', bg = '#292C3C' })

local M = {}
local merge_tb = vim.tbl_deep_extend

M.load_mappings = function(section, mapping_opt)
   vim.schedule(function()
      local function set_section_map(section_values)
         -- Los plugins no se cargaran automaticamente.
         if section_values.plugin then
            return
         end

         section_values.plugin = nil

         for mode, mode_values in pairs(section_values) do
            local default_opts = merge_tb('force', { mode = mode }, mapping_opt or {})
            for keybind, mapping_info in pairs(mode_values) do
               -- merge default + user opts
               local opts = merge_tb('force', default_opts, mapping_info.opts or {})

               mapping_info.opts, opts.mode = nil, nil

               if type(mapping_info[2]) == 'string' then
                  opts.desc = mapping_info[2]
               else
                  opts.desc = '' -- Asigna una cadena vacía si mapping_info[2] no es una cadena válida.
               end

               vim.keymap.set(mode, keybind, mapping_info[1], opts)
            end
         end
      end

      local mappings = require('core.mappings')

      if type(section) == 'string' then
         mappings[section]['plugin'] = nil
         mappings = { mappings[section] }
      end

      for _, sect in pairs(mappings) do
         set_section_map(sect)
      end
   end)
end

M.lazy_load = function(plugin)
   vim.api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter', 'BufNewFile' }, {
      group = vim.api.nvim_create_augroup('BeLazyOnFileOpen' .. plugin, {}),
      callback = function()
         local file = vim.fn.expand('%')
         local condition = file ~= 'NvimTree_1' and file ~= '[lazy]' and file ~= ''

         if condition then
            vim.api.nvim_del_augroup_by_name('BeLazyOnFileOpen' .. plugin)

            -- dont defer for treesitter as it will show slow highlighting
            -- This deferring only happens only when we do "nvim filename"
            if plugin ~= 'nvim-treesitter' then
               vim.schedule(function()
                  require('lazy').load({ plugins = plugin })

                  if plugin == 'nvim-lspconfig' then
                     vim.cmd('silent! do FileType')
                  end
               end, 0)
            else
               require('lazy').load({ plugins = plugin })
            end
         end
      end,
   })
end

-- +--------------------------------------------------------------------+
-- functions Custom

M.hl_search = function(blinktime)
   local ns = vim.api.nvim_create_namespace('search')
   vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

   local search_pat = '\\c\\%#' .. vim.fn.getreg('/')
   local m = vim.fn.matchadd('IncSearch', search_pat)
   vim.cmd('redraw')
   vim.cmd('sleep ' .. blinktime * 1000 .. 'm')

   local sc = vim.fn.searchcount()
   vim.api.nvim_buf_set_extmark(0, ns, vim.api.nvim_win_get_cursor(0)[1] - 1, 0, {
      virt_text = {
         { ' ' .. vim.fn.getreg('/') .. ' [ ' .. sc.current .. '/' .. sc.total .. ' ] ', 'HlSearchCustom' },
      },
      virt_text_pos = 'eol',
   })

   vim.fn.matchdelete(m)
   vim.cmd('redraw')
end

M.clear_search = function()
   local ns = vim.api.nvim_create_namespace('search')
   vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

-- +--------------------------------------------------------------------+

M.spell_toggle = function()
   if vim.o.spell then
      vim.o.spell = false
      vim.notify('  Deshabilitando Spellchecking ... 😭😭')
   else
      vim.o.spell = true
      vim.notify('  Habilitando Spellchecking ... 😃😃')
   end
end
-- +--------------------------------------------------------------------+
local increment_map = {}

local generate = function(loop_list, capitalize)
   local do_capitalize = capitalize or false

   for i = 1, #loop_list do
      local current = loop_list[i]
      local next = loop_list[i + 1] or loop_list[1]

      increment_map[current] = next

      if do_capitalize then
         local capitalized_current = current:gsub('^%l', string.upper)
         local capitalized_next = next:gsub('^%l', string.upper)

         increment_map[capitalized_current] = capitalized_next
      end
   end
end

-- Booleanos
generate({ 'true', 'false' }, true)
generate({ 'yes', 'no' }, true)
generate({ 'on', 'off' }, true)

M.toggle_bool = function()
   local under_cursor = vim.fn.expand('<cword>')
   local match = false or increment_map[under_cursor]

   if match ~= nil then
      return vim.cmd(':normal ciw' .. match)
   end

   return vim.cmd(':normal!' .. vim.v.count .. '')
end

-- +--------------------------------------------------------------------+
---@alias Sign {name:string, text:string, texthl:string, priority:number}

-- Returns a list of regular and extmark signs sorted by priority (low to high)
---@return Sign[]
---@param buf number
---@param lnum number
M.get_signs = function(buf, lnum)
   -- Get regular signs
   ---@type Sign[]
   local signs = vim.tbl_map(function(sign)
      ---@type Sign
      local ret = vim.fn.sign_getdefined(sign.name)[1]
      ret.priority = sign.priority
      return ret
   end, vim.fn.sign_getplaced(buf, { group = '*', lnum = lnum })[1].signs)

   -- Get extmark signs
   local extmarks = vim.api.nvim_buf_get_extmarks(
      buf,
      -1,
      { lnum - 1, 0 },
      { lnum - 1, -1 },
      { details = true, type = 'sign' }
   )
   for _, extmark in pairs(extmarks) do
      signs[#signs + 1] = {
         name = extmark[4].sign_hl_group or '',
         text = extmark[4].sign_text,
         texthl = extmark[4].sign_hl_group,
         priority = extmark[4].priority,
      }
   end

   -- Sort by priority
   table.sort(signs, function(a, b)
      return (a.priority or 0) < (b.priority or 0)
   end)

   return signs
end

---@param sign? Sign
---@param len? number
function M.icon(sign, len)
   sign = sign or {}
   len = len or 2
   local text = vim.fn.strcharpart(sign.text or '', 0, len) ---@type string
   text = text .. string.rep(' ', len - vim.fn.strchars(text))
   return sign.texthl and ('%#' .. sign.texthl .. '#' .. text .. '%*') or text
end

---@return Sign?
---@param buf number
---@param lnum number
function M.get_mark(buf, lnum)
   local marks = vim.fn.getmarklist(buf)
   vim.list_extend(marks, vim.fn.getmarklist())
   for _, mark in ipairs(marks) do
      if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match('[a-zA-Z]') then
         return { text = mark.mark:sub(2), texthl = 'DiagnosticHint' }
      end
   end
end

M.statuscolumn = function()
   local win = vim.g.statusline_winid
   local buf = vim.api.nvim_win_get_buf(win)
   local is_file = vim.bo[buf].buftype == ''
   local show_signs = vim.wo[win].signcolumn ~= 'no'

   local components = { '', '', '' } -- left, middle, right

   if show_signs then
      ---@type Sign?,Sign?,Sign?
      local left, right, fold
      for _, s in ipairs(M.get_signs(buf, vim.v.lnum)) do
         if s.name and s.name:find('GitSign') then
            right = s
         else
            left = s
         end
      end
      if vim.v.virtnum ~= 0 then
         left = nil
      end
      vim.api.nvim_win_call(win, function()
         if vim.fn.foldclosed(vim.v.lnum) >= 0 then
            fold = { text = vim.opt.fillchars:get().foldclose or '', texthl = 'FoldSignsOpen' }
         end
      end)
      -- Left: mark or non-git sign
      components[1] = M.icon(M.get_mark(buf, vim.v.lnum) or left)

      -- Right: fold icon or git sign (only if file)
      components[3] = is_file and M.icon(fold or right) or ''
   end

   -- Numbers in Neovim are weird
   -- They show when either number or relativenumber is true
   local is_num = vim.wo[win].number
   local is_relnum = vim.wo[win].relativenumber

   if is_num and is_relnum then
      components[2] = '%=%{v:relnum?(v:virtnum>0?"":v:relnum):(v:virtnum>0?"":v:lnum)} '
   elseif is_num and not is_relnum then
      components[2] = '%=%{v:virtnum>0?"":v:lnum} '
   elseif is_relnum and not is_num then
      components[2] = '%=%{v:virtnum>0?"":v:relnum} '
   else
      components[2] = ''
   end

   return table.concat(components, '')
end

function M.get_signss()
   local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
   return vim.tbl_map(function(sign)
      return vim.fn.sign_getdefined(sign.name)[1]
   end, vim.fn.sign_getplaced(buf, { group = '*', lnum = vim.v.lnum })[1].signs)
end

M.status_column = function()
   local win = vim.g.statusline_winid

   vim.api.nvim_set_hl(0, 'FoldSignsOpen', { fg = '#EEFFFF', bg = '#292C3C' })
   vim.api.nvim_set_hl(0, 'FoldSignsClosed', { fg = '#a5adce', bg = '#292C3C' })

   local sign, git_sign
   for _, s in ipairs(M.get_signss()) do
      if s.name:find('GitSign') then
         git_sign = s
      else
         sign = s
      end
   end

   local column_num = function()
      local is_num = vim.wo[win].number
      local is_relnum = vim.wo[win].relativenumber

      if is_num and is_relnum then
         return '%=%{v:relnum?(v:virtnum>0?"":v:relnum):(v:virtnum>0?"":v:lnum)} '
      elseif is_num and not is_relnum then
         return '%=%{v:virtnum>0?"":v:lnum} '
      elseif is_relnum and not is_num then
         return '%=%{v:virtnum>0?"":v:relnum} '
      else
         return ''
      end
   end

   local column_fold = function()
      if vim.fn.eval('foldlevel(v:lnum) > foldlevel(v:lnum - 1)') == 1 then
         if vim.fn.eval('foldclosed(v:lnum) == -1') == 1 then
            return '%#FoldSignsClosed# %T'
         elseif vim.fn.eval('foldclosed(v:lnum) != -1') == 1 then
            return '%#FoldSignsOpen# %T'
         end
      else
         return '  %T'
      end
   end

   return table.concat({
      -- sign and ('%#' .. sign.texthl .. '#' .. sign.text .. '%*%T') or '  %T',
      -- [[%=]],
      -- [[%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''} ]],
      -- git_sign and ('%#' .. git_sign.texthl .. '#' .. git_sign.text .. '%*') or '  ',
      '%s%=%T',
      column_num(),
      column_fold(),
   })
end

return M
