local M = {}
M.ui = {
   border_inset = { ' ', '▁', ' ', '▏', ' ', '▔', ' ', '▕' },
}

M.mason = {
   -- stylua: ignore
   ensure_installed = {
      'lua-language-server', 'html-lsp', 'emmet-language-server',  'stylelint-lsp',
      'css-lsp', 'tailwindcss-language-server', 'svelte-language-server', 'json-lsp',
      'pyright', 'rust-analyzer', 'marksman', 'yaml-language-server',
      'astro-language-server', 'eslint-lsp', 'sqlls',

      -- formatter & Linter
      'stylua', 'prettierd', 'biome', 'taplo', 'black',
      -- 'selene', -- diagnostic for lua
   },
}

M.treesitter = {
   -- stylua: ignore
   ensure_installed = {
      'bash', 'c', 'diff', 'html', 'css', 'scss', 'javascript', 'json', 'jsdoc', 'jsonc',
      'lua', 'luadoc', 'luap', 'markdown', 'markdown_inline', 'python', 'htmldjango',
      'query', 'regex', 'toml', 'typescript', 'tsx', 'svelte', 'vue', 'vim', 'vimdoc',
      'yaml', 'rust', 'cpp', 'comment', 'gitignore', 'git_config', 'astro',
      'sql'
   },
}

return M
