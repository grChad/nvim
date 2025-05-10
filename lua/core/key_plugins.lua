local mode = {
   insert = 'i',
   select = 's',
   visual = 'v',
   terminal = 't',
   visual_select = 'x',
}

local leader = function(str) return '<Leader>' .. str end
local cmd = function(str) return '<cmd>' .. str .. '<CR>' end

local deleteCustomBuffer = function()
   local api = require('nvim-tree.api')

   -- si es visible ejecutar una serie de comandos
   if api.tree.is_visible() then
      vim.cmd('NvimTreeClose')
      vim.cmd('bdelete')
      vim.cmd('NvimTreeOpen')
      vim.cmd('wincmd l')
   else
      vim.cmd('bdelete')
   end
end

---------------------------------[ Plugin Mappings ]----------------------------------
local MAP = {}

MAP.bufferline = {
   { ',', cmd('BufferLinePick'), desc = 'Pick buffer' },
   -- { leader .. 'x', cmd('bdelete'), desc = 'delete buffer' },
   {
      leader('x'),
      function() deleteCustomBuffer() end,
      desc = 'delete buffer',
   },
   { leader('k'), cmd('BufferLineCycleNext'), desc = 'Next buffer' },
   { leader('j'), cmd('BufferLineCyclePrev'), desc = 'Previous buffer' },
}

MAP.nvimtree = {
   { leader('e'), cmd('NvimTreeToggle'), desc = 'Toggle nvimtree' },
}

MAP.comment = {
   {
      leader('/'),
      function() require('Comment.api').toggle.linewise.current() end,
      desc = 'Toggle comment',
   },
   {
      leader('/'),
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      mode = mode.visual,
      desc = 'Toggle comment',
   },
}

MAP.resty = {
   { leader('rr'), cmd('Resty run'), desc = '[R]esty [R]un request under the cursor' },
}

MAP.markdown_preview = {
   {
      leader('mp'),
      function()
         vim.cmd('MarkdownPreviewToggle')
         vim.notify('Markdown Preview')
      end,
      desc = 'Toggle markdown preview',
   },
}

MAP.img_clip = {
   { leader('pi'), cmd('PasteImage'), desc = 'Paste clipboard image' },
}

MAP.lua_snip = {
   {
      '<Tab>',
      function() return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>' end,
      mode = mode.insert,
   },
   { '<s-tab>', cmd("lua require('luasnip').jump(-1)"), mode = mode.insert },

   { '<tab>', cmd("lua require('luasnip').jump(1)"), mode = mode.select },
   { '<s-tab>', cmd("lua require('luasnip').jump(-1)"), mode = mode.select },
}

-- tratar de reemplazar todo por s de snacks y en flash hacer algo, quizas integrarlo
MAP.snacks = {
   {
      leader('ff'),
      function() Snacks.picker.files({ exclude = { 'node_modules' }, hidden = true, ignored = false }) end,
      desc = 'Find files',
   },
   { leader('fw'), function() Snacks.picker.grep({ exclude = { 'node_modules' } }) end, desc = 'Live grep' },
   { leader('fb'), function() Snacks.picker.buffers() end, desc = 'Buffers' },
   { leader('fh'), function() Snacks.picker.help() end, desc = 'Help Pages' },
   { leader('pp'), function() Snacks.picker.projects() end, desc = 'Projects' },
   { 'ghi', function() Snacks.image.hover() end, desc = 'Show image floating' },
   { leader('km'), function() Snacks.picker.keymaps() end },

   -- git
   { leader('gb'), function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
   { leader('gl'), function() Snacks.picker.git_log() end, desc = 'Git Log' },
   { leader('gs'), function() Snacks.picker.git_status() end, desc = 'Git Status' },
   -- { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
   -- { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
   -- { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
}

MAP.outline = {
   { leader('o'), cmd('Outline'), desc = 'Toggle outline' },
}

MAP.treesitter = {
   { '<c-space>', desc = 'Increment selection' },
   { '<bs>', desc = 'Decrement selection', mode = mode.visual_select },
}

MAP.highlight_colors = {
   { leader('hi'), cmd('HighlightColors Toggle'), desc = 'Toggle highlight colors' },
}

MAP.conform = {
   {
      leader('fi'),
      function() require('conform').format({ async = true, lsp_fallback = true }) end,
      desc = 'Format buffer',
   },
}

MAP.toggleterm = {
   { leader('te'), cmd('ToggleTerm'), desc = 'Toggle terminal' },
   { leader('n'), '<C-\\><C-n>', mode = mode.terminal, desc = 'Toggle terminal' },
   { leader('t'), cmd('ToggleTerm'), mode = mode.terminal, desc = 'Toggle terminal' },
}

MAP.overseer = {
   { leader('co'), cmd('OverseerRun'), desc = 'Run overseer' },
}

MAP.mason = {
   { leader('mm'), cmd('Mason'), desc = 'Open Mason' },
}

return MAP
