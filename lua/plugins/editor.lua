return {
   {
      'lewis6991/gitsigns.nvim',
      lazy = false,
      opts = {
         signs = grvim.gitsigns.icons,
         signs_staged = grvim.gitsigns.icons,
         current_line_blame = true,
      },
   },

   { 'ggandor/lightspeed.nvim', keys = { 's', 'S' } }, -- search words
}
