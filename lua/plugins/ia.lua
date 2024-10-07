return {
   {
      'supermaven-inc/supermaven-nvim',
      event = 'BufEnter',
      config = function()
         require('supermaven-nvim').setup({
            keymaps = {
               accept_suggestion = '<C-y>',
               accept_word = '<C-i>',
            },
            ignore_filetypes = { markdown = true },
         })
      end,
   },

   -- {
   --    'Exafunction/codeium.vim',
   --    event = 'BufEnter',
   --    cmd = 'Codeium',
   --    config = function()
   --       vim.keymap.set('i', '<C-i>', function()
   --          return vim.fn['codeium#Accept']()
   --       end, { expr = true, silent = true })
   --    end,
   -- },
}
