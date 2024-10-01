return {
   {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      event = 'VimEnter',
      version = false, -- telescope did only one release, so use HEAD for now
      keys = require('core.key_plugins').telescope,
      opts = {
         defaults = {
            -- stylua: ignore
            vimgrep_arguments = {
               'rg', '-L', '--color=never', '--no-heading', '--with-filename',
               '--line-number', '--column', '--smart-case',
            },
            prompt_prefix = '  ',
            selection_caret = ' ',
            entry_prefix = '  ',
            initial_mode = 'insert',
            selection_strategy = 'reset',
            sorting_strategy = 'ascending',
            layout_strategy = 'horizontal',
            layout_config = {
               horizontal = {
                  prompt_position = 'top',
                  preview_width = 0.55,
                  results_width = 0.8,
               },
               vertical = {
                  mirror = false,
               },
               width = 0.87,
               height = 0.80,
               preview_cutoff = 120,
            },
            -- file_sorter = require('telescope.sorters').get_fuzzy_file,
            file_ignore_patterns = { 'node_modules' },
            -- generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
            path_display = { 'truncate' },
            winblend = 0,
            border = {},
            borderchars = grvim.telescope.borderchars,
            color_devicons = true,
            set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
            get_selection_window = function()
               local wins = vim.api.nvim_list_wins()
               table.insert(wins, 1, vim.api.nvim_get_current_win())
               for _, win in ipairs(wins) do
                  local buf = vim.api.nvim_win_get_buf(win)
                  if vim.bo[buf].buftype == '' then
                     return win
                  end
               end
               return 0
            end,
         },
      },
   },

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
