return {
   {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      version = false, -- telescope did only one release, so use HEAD for now
      init = function()
         require('core.utils').load_mappings('telescope')
      end,
      opts = {
         defaults = {
            vimgrep_arguments = {
               'rg',
               '-L',
               '--color=never',
               '--no-heading',
               '--with-filename',
               '--line-number',
               '--column',
               '--smart-case',
            },
            prompt_prefix = '  ',
            selection_caret = ' ',
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
            borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
            color_devicons = true,
            set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
            -- file_previewer = require('telescope.previewers').vim_buffer_cat.new,
            -- grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
            -- qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            -- buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
            -- mappings = {
            -- 	n = { ['q'] = require('telescope.actions').close },
            -- },
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
         signs = {
            add = { text = '┃' },
            change = { text = '┃' },
            delete = { text = '' },
            topdelete = { text = '' },
            changedelete = { text = '~' },
         },
         on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
               vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            -- stylua: ignore start
            map("n", "]h", gs.next_hunk, "Next Hunk")
            map("n", "[h", gs.prev_hunk, "Prev Hunk")
            map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
            map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
            map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
            map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
            map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
            map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
            map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
            map("n", "<leader>ghd", gs.diffthis, "Diff This")
            map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
         end,
      },
   },

   { 'ggandor/lightspeed.nvim', keys = { 's', 'S' } }, -- search words

   -- NOTE: Ver su utilidad
   -- {
   -- 	'NvChad/nvterm',
   -- 	init = function()
   -- 		require('core.utils').load_mappings('nvterm')
   -- 	end,
   -- 	config = true,
   -- },
}
