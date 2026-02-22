_G.grvim = {}

---@alias UiHiglightStyle 'background'|'foreground'|'virtual'

grvim.ui = {
   border_inset = { ' ', '▁', ' ', '▏', ' ', '▔', ' ', '▕' },
   border_rounded = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
   ---@type {style: UiHiglightStyle, tailwind: boolean}
   hig_colors = {
      style = 'virtual',
      tailwind = true,
   },
   icons = {
      kinds = {
         Array = ' ',
         Boolean = '󰨙 ',
         Class = ' ',
         Control = ' ',
         Collapsed = ' ',
         Constant = '󰏿 ',
         Constructor = ' ',
         Enum = ' ',
         EnumMember = ' ',
         Event = ' ',
         Field = '󰜢 ',
         File = '󰈙 ',
         Folder = '󰉋 ',
         Function = '󰊕 ',
         Interface = ' ',
         Key = ' ',
         Keyword = '󰌋 ',
         Method = '󰊕 ',
         Module = ' ',
         Namespace = '󰦮 ',
         Null = ' ',
         Number = '󰎠 ',
         Object = ' ',
         Operator = '󰆕 ',
         Package = ' ',
         Property = ' ',
         Reference = ' ',
         Snippet = ' ',
         String = ' ',
         Struct = '󰆼 ',
         Text = '󰉿 ',
         TypeParameter = ' ',
         Unit = '󰑭 ',
         Value = ' ',
         Variable = '󰀫 ',
         Color = '󰏘 ',
         Tailwind = '󰝤󰝤󰝤󰝤󰝤󰝤󰝤',

         -- IA autocompletion
         TabNine = '󰏚 ',
         Copilot = ' ',
         Codeium = ' ',
         Supermaven = ' ',
      },
   },
}

grvim.gitsigns = {
   icons = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '' },
      topdelete = { text = '' },
   },
}

grvim.lsp = {
   signs = { Error = ' ', Warn = ' ', Hint = '󰌵 ', Info = ' ' },
}

grvim.formatter = {
   -- stylua: ignore
   prettier_cwd = {
      '.prettierrc', '.prettierrc.json', '.prettierrc.yml', '.prettierrc.yaml',
      '.prettierrc.json5', '.prettierrc.js', '.prettierrc.cjs', '.prettierrc.mjs',
      '.prettierrc.toml', 'prettier.config.js', 'prettier.config.cjs', 'prettier.config.mjs',
   },
}

grvim.nvimTree = {
   isfloat = false, -- default true
   quit_on_open = false, -- Cierra la ventana al seleccionar elemento
   width = 32, -- default 40
   ---@type 'left' | 'right'
   position = 'left',
   diagnostics = {
      enable = true,
      icons = { hint = '󰌵', info = '', warning = '', error = '' },
   },
   -- stylua: ignore
   git_icons = { unstaged = '', staged = '', unmerged = '', untracked = '', deleted = '', ignored = '󱥸' },
   indent_markers_icon = { corner = '╰' },
   bottom = '─',
}

grvim.mason = {
   -- stylua: ignore
   ensure_installed = {
      'lua-language-server', 'html-lsp', 'stylelint-lsp', 'css-lsp', 'tailwindcss-language-server',
      'json-lsp', 'pyrefly', 'pyright', 'marksman', 'astro-language-server', 'eslint-lsp',
      'typescript-language-server', 'tinymist',

      -- formatter & Linter
      'prettierd', 'biome', 'taplo',
      'ruff', -- linting and formatting for 'python'
      'stylua', -- formatter for 'lua'
      'typstyle' -- formatter for 'typst'
   },
}

grvim.treesitter = {
   -- stylua: ignore
   ensure_installed = {
      'bash', 'diff', 'html', 'css', 'scss', 'javascript', 'json', 'jsdoc', 'jsonc',
      'lua', 'luadoc', 'luap', 'markdown', 'markdown_inline', 'python', 'htmldjango',
      'query', 'regex', 'toml', 'typescript', 'tsx', 'vue', 'vim', 'vimdoc', 'yaml',
      'comment', 'gitignore', 'git_config', 'astro', 'sql', 'xml', 'go', 'kotlin',
      'http', 'typst'
   },
}
