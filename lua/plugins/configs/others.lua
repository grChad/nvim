local M = {}
local utils = require('core.utils')

M.autopairs = function()
   local present1, autopairs = pcall(require, 'nvim-autopairs')
   local present2, cmp = pcall(require, 'cmp')

   if not (present1 and present2) then
      return
   end

   local Rule = require('nvim-autopairs.rule')

   local options = {
      fast_wrap = {},
      disable_filetype = { 'TelescopePrompt', 'vim' },
      enable_check_bracket_line = false,
   }
   autopairs.setup(options)

   autopairs.add_rules({
      Rule('*', '*', 'markdown'),
      Rule('_', '_', 'markdown'):with_pair(function(opts)
         if opts.line:match('_.*_$') then
            -- estamos dentro de un par de _, no agregar otro
            return false
         end
      end):with_move(),
   })

   local cmp_autopairs = require('nvim-autopairs.completion.cmp')
   cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

M.mini_surround = {
   mappings = {
      add = 'as', -- Add surrounding in Normal and Visual modes
      delete = 'ds', -- Delete surrounding
      replace = 'cs', -- Change surrounding
      find = '',
      find_left = '',
      highlight = '',
      update_n_lines = '',

      suffix_last = '',
      suffix_next = '',
   },
}

M.indent_mini = function()
   vim.api.nvim_create_autocmd('FileType', {
      pattern = {
         'help',
         'alpha',
         'neo-tree',
         'NvimTree',
         'noice',
         'lazy',
         'lspinfo',
         'html',
         'lua',
         'c',
         'cpp',
         'json',
         'dart',
         'python',
         'svelte',
         'javascript',
         'javascriptreact',
         'typescript',
         'typescriptreact',
         'rust',
         '',
      },
      callback = function()
         vim.b.miniindentscope_disable = true
      end,
   })

   require('mini.indentscope').setup({
      draw = {
         delay = 50,
         animation = function(_, _)
            return 10
         end,
      },
      options = { try_as_border = true },
      symbol = '▏',
   })
end

M.blankline = {
   indentLine_enabled = 1,
   filetype_exclude = {
      'help',
      'terminal',
      'alpha',
      'lazy',
      'lspinfo',
      'TelescopePrompt',
      'TelescopeResults',
      'mason',
      'nvdash',
      'nvcheatsheet',
      'css',
      'scss',
      '',
   },
   char = '▏',
   buftype_exclude = { 'terminal' },
   show_trailing_blankline_indent = false,
   show_current_context = true,
   show_current_context_start = true,
}

M.colorizer = function()
   local present, colorizer = pcall(require, 'colorizer')

   if not present then
      return
   end

   local options = {
      filetypes = {
         '*',
         css = { names = true },
         scss = { names = true },
         svelte = { names = true },
      },
      user_default_options = {
         RGB = true, -- #RGB hex codes
         RRGGBB = true, -- #RRGGBB hex codes
         names = false, -- "Name" codes like Blue
         RRGGBBAA = true, -- #RRGGBBAA hex codes
         rgb_fn = true, -- CSS rgb() and rgba() functions
         hsl_fn = true, -- CSS hsl() and hsla() functions
         css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
         css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn

         -- Available modes: foreground, background, virtualtext
         mode = 'background',
         tailwind = true,
      },
   }

   colorizer.setup(options)

   -- execute colorizer as soon as possible
   vim.defer_fn(function()
      require('colorizer').attach_to_buffer(0)
   end, 0)
end

M.comment = function()
   local present, nvim_comment = pcall(require, 'Comment')

   if not present then
      return
   end

   local options = {
      ---@type boolean
      padding = true,

      ---Lines to be ignored while comment/uncomment.
      ---Could be a regex string or a function that returns a regex string.
      ---Example: Use '^$' to ignore empty lines
      ---@type string|function
      ignore = nil,

      ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
      ---@type table
      mappings = {
         ---operator-pending mapping
         ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
         basic = true,
         ---extra mapping
         ---Includes `gco`, `gcO`, `gcA`
         extra = true,
         ---extended mapping
         ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
         extended = false,
      },

      ---LHS of toggle mapping in NORMAL + VISUAL mode
      ---@type table
      toggler = {
         line = 'gcc',
         block = 'gbc',
      },

      ---LHS of operator-pending mapping in NORMAL + VISUAL mode
      ---@type table
      opleader = {
         line = 'gc',
         block = 'gb',
      },

      ---Pre-hook, called before commenting the line
      ---@type function|nil
      ---@param ctx Ctx
      pre_hook = function(ctx)
         return require('ts_context_commentstring.internal').calculate_commentstring()
      end,
      -- pre_hook = function(ctx)
      -- 	return require('Comment.jsx').calculate(ctx)
      -- end,

      ---Post-hook, called after commenting is done
      ---@type function|nil
      post_hook = nil,
   }
   nvim_comment.setup(options)
end

M.luasnip = function(opts)
   require('luasnip').config.set_config(opts)

   -- vscode format
   require('luasnip.loaders.from_vscode').lazy_load()
   require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets/' })

   vim.api.nvim_create_autocmd('InsertLeave', {
      callback = function()
         if
             require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
             and not require('luasnip').session.jump_active
         then
            require('luasnip').unlink_current()
         end
      end,
   })
end

M.gitsigns = {
   signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
   },
   on_attach = function(bufnr)
      utils.load_mappings('gitsigns', { buffer = bufnr })
   end,
}

return M
