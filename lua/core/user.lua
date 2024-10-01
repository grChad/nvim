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
   isfloat = true,
   quit_on_open = true, -- Cierra la ventana al seleccionar elemento
   width = 40,
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
      'lua-language-server', 'html-lsp', 'emmet-language-server', 'stylelint-lsp',
      'css-lsp', 'tailwindcss-language-server', 'json-lsp', 'pyright', 'rust-analyzer',
      'marksman', 'yaml-language-server', 'astro-language-server', 'eslint-lsp',
      'texlab',

      -- formatter & Linter
      'stylua', 'prettierd', 'biome', 'taplo', 'latexindent',
      'ruff-lsp', -- linting and formatting for 'python'
      -- 'selene', -- diagnostic for lua
   },
}

grvim.treesitter = {
   -- stylua: ignore
   ensure_installed = {
      'bash', 'diff', 'html', 'css', 'scss', 'javascript', 'json', 'jsdoc', 'jsonc',
      'lua', 'luadoc', 'luap', 'markdown', 'markdown_inline', 'python', 'htmldjango',
      'query', 'regex', 'toml', 'typescript', 'tsx', 'vue', 'vim', 'vimdoc', 'yaml',
      'rust', 'comment', 'gitignore', 'git_config', 'astro', 'sql', 'latex', 'xml',
      'http'
   },
}

grvim.telescope = {
   borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
}
