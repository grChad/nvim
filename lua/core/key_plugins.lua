local mode = {
   insert = 'i',
   select = 's',
   visual = 'v',
   terminal = 't',
   visual_select = 'x',
}

local leader = '<Leader>'

local cmd = function(str)
   return '<cmd>' .. str .. '<CR>'
end

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
      leader .. 'x',
      function()
         deleteCustomBuffer()
      end,
      desc = 'delete buffer',
   },
   { leader .. 'k', cmd('BufferLineCycleNext'), desc = 'Next buffer' },
   { leader .. 'j', cmd('BufferLineCyclePrev'), desc = 'Previous buffer' },
}

MAP.nvimtree = {
   { leader .. 'e', cmd('NvimTreeToggle'), desc = 'Toggle nvimtree' },
}

MAP.comment = {
   {
      leader .. '/',
      function()
         require('Comment.api').toggle.linewise.current()
      end,
      desc = 'Toggle comment',
   },
   {
      leader .. '/',
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      mode = mode.visual,
      desc = 'Toggle comment',
   },
}

MAP.resty = {
   { leader .. 'rr', cmd('Resty run'), desc = '[R]esty [R]un request under the cursor' },
}

MAP.markdown_preview = {
   {
      leader .. 'mp',
      function()
         vim.cmd('MarkdownPreviewToggle')
         vim.notify('Markdown Preview')
      end,
      desc = 'Toggle markdown preview',
   },
}

MAP.img_clip = {
   { leader .. 'pi', cmd('PasteImage'), desc = 'Paste clipboard image' },
}

MAP.lua_snip = {
   {
      '<Tab>',
      function()
         return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
      end,
      mode = mode.insert,
   },
   { '<s-tab>', cmd("lua require('luasnip').jump(-1)"), mode = mode.insert },

   { '<tab>', cmd("lua require('luasnip').jump(1)"), mode = mode.select },
   { '<s-tab>', cmd("lua require('luasnip').jump(-1)"), mode = mode.select },
}

MAP.telescope = {
   { leader .. 'ff', cmd('Telescope find_files'), desc = 'Find files' },
   {
      leader .. 'fa',
      cmd('Telescope find_files follow=true no_ignore=true hidden=true'),
      desc = 'Find all',
   },
   { leader .. 'fw', cmd('Telescope live_grep'), desc = 'Live grep' },
   { leader .. 'fb', cmd('Telescope buffers'), desc = 'Find buffers' },
   { leader .. 'fh', cmd('Telescope help_tags'), desc = 'Help page' },
   { leader .. 'fo', cmd('Telescope oldfiles'), desc = 'Find oldfiles' },

   -- git
   { leader .. 'cm', cmd('Telescope git_commits'), desc = 'Git commits' },
   { leader .. 'gt', cmd('Telescope git_status'), desc = 'Git status' },
}

MAP.outline = {
   { leader .. 'o', cmd('Outline'), desc = 'Toggle outline' },
}

MAP.treesitter = {
   { '<c-space>', desc = 'Increment selection' },
   { '<bs>', desc = 'Decrement selection', mode = mode.visual_select },
}

MAP.highlight_colors = {
   { leader .. 'hi', cmd('HighlightColors Toggle'), desc = 'Toggle highlight colors' },
}

MAP.conform = {
   {
      leader .. 'fi',
      function()
         require('conform').format({ async = true, lsp_fallback = true })
      end,
      desc = 'Format buffer',
   },
}

MAP.toggleterm = {
   { leader .. 'te', cmd('ToggleTerm'), desc = 'Toggle terminal' },
   { leader .. 'n', '<C-\\><C-n>', mode = mode.terminal, desc = 'Toggle terminal' },
   { leader .. 't', cmd('ToggleTerm'), mode = mode.terminal, desc = 'Toggle terminal' },
}

MAP.overseer = {
   { leader .. 'co', cmd('OverseerRun'), desc = 'Run overseer' },
}

MAP.mason = {
   { leader .. 'm', cmd('Mason'), desc = 'Open Mason' },
}

return MAP
