vim.api.nvim_set_hl(0, 'FoldSignsOpen', { fg = '#EEFFFF', bg = '#292C3C' })
vim.api.nvim_set_hl(0, 'FoldSignsClosed', { fg = '#a5adce', bg = '#292C3C' })

local M = {}

-- +--------------------------------------------------------------------+

-- -@alias Sign {name:string, text:string, texthl:string, priority:number}

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
