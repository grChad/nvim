-- n, v, i, t = mode names
function Cmd(str)
	return '<cmd>' .. str .. '<CR>'
end

local silent = { silent = true }
-- local noremap = { noremap = true }
local opts = { noremap = true, silent = true }

local M = {}

M.general = {
	i = {
		-- go to  beginning and end
		['<C-b>'] = { '<ESC>^i', 'Beginning of line' },
		['<C-e>'] = { '<End>', 'End of line' },

		-- Espacar del modo insertar
		['kj'] = { '<esc>', 'Escap', silent },
		['KJ'] = { '<esc>', 'Escap', silent },

		-- Move current line / block with Alt-j/k ala vscode.
		['<A-j>'] = { '<Esc>:m .+1<CR>==gi' },
		-- Move current line / block with Alt-j/k ala vscode.
		['<A-k>'] = { '<Esc>:m .-2<CR>==gi' },

		-- detele arrows
		['<up>'] = { '<Nop>', silent },
		['<down>'] = { '<Nop>', silent },
		['<left>'] = { '<Nop>', silent },
		['<right>'] = { '<Nop>', silent },

		-- navigate within insert mode
		['<C-h>'] = { '<Left>', 'Move left' },
		['<C-l>'] = { '<Right>', 'Move right' },
		['<C-j>'] = { '<Down>', 'Move down' },
		['<C-k>'] = { '<Up>', 'Move up' },
	},

	n = {
		['<leader>w'] = { Cmd('write'), 'Save file' },
		['m'] = { Cmd('nohl'), 'no highlight', silent },
		['<leader>q'] = { Cmd('quit'), 'Quit NVim' },
		['<leader>y'] = { Cmd('%y+'), 'copy whole file' },

		-- switch between windows
		['<C-h>'] = { '<C-w>h', 'Window left' },
		['<C-l>'] = { '<C-w>l', 'Window right' },
		['<C-j>'] = { '<C-w>j', 'Window down' },
		['<C-k>'] = { '<C-w>k', 'Window up' },

		-- Resize with arrows
		['<A-S-Up>'] = { ':resize -2<CR>' },
		['<A-S-Down>'] = { ':resize +2<CR>' },
		['<A-S-Left>'] = { ':vertical resize -2<CR>' },
		['<A-S-Right>'] = { ':vertical resize +2<CR>' },

		-- Move current line / block with Alt-j/k a la vscode.
		['<A-j>'] = { ':m .+1<CR>==' },
		['<A-k>'] = { ':m .-2<CR>==' },

		-- moverse mas rapido up an down
		['<Up>'] = { '<ScrollWheelUp>' },
		['<Down>'] = { '<ScrollWheelDown>' },

		-- detele arrows
		['<Left>'] = { '<Nop>', silent },
		['<Right>'] = { '<Nop>', silent },

		-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
		-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
		-- empty mode is same as using <cmd> :map
		-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
		['j'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },
		['k'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
	},

	t = {
		['<C-x>'] = { vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true), 'Escape terminal mode' },
	},

	v = {
		-- detele arrows
		['<up>'] = { '<Nop>', silent },
		['<down>'] = { '<Nop>', silent },
		['<left>'] = { '<Nop>', silent },
		['<right>'] = { '<Nop>', silent },

		-- Better indenting
		['<'] = { '<gv' },
		['>'] = { '>gv' },
	},

	x = {
		['j'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },
		['k'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		['p'] = { 'p:let @+=@0<CR>:let @"=@0<CR>', 'Dont copy replaced text', opts = { silent = true } },

		-- Move current line / block with Alt-j/k ala vscode.
		['<A-j>'] = { ":m '>+1<CR>gv-gv" },
		['<A-k>'] = { ":m '<-2<CR>gv-gv" },
	},
}

M.barbar = {
	plugin = true,
	n = {
		['<leader>x'] = { Cmd('BufferClose'), 'Delete Buffer', opts },
		['<leader>k'] = { Cmd('BufferNext'), 'Next Buffer', opts },
		['<leader>j'] = { Cmd('BufferPrevious'), 'Previous Buffer', opts },
		[','] = { Cmd('BufferPick'), opts },
	},
}

M.comment = {
	plugin = true,

	-- toggle comment in both modes
	n = {
		['<leader>/'] = {
			function()
				require('Comment.api').toggle.linewise.current()
			end,
			'Toggle comment',
		},
	},

	v = {
		['<leader>/'] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			'Toggle comment',
		},
	},
}

M.nvimtree = {
	plugin = true,
	n = {
		-- toggle
		['<leader>e'] = { '<cmd> NvimTreeToggle <CR>', 'Toggle nvimtree' },
	},
}

M.telescope = {
	plugin = true,

	n = {
		-- find
		['<leader>ff'] = { '<cmd> Telescope find_files <CR>', 'Find files' },
		['<leader>fa'] = {
			'<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>',
			'Find all',
		},
		['<leader>fw'] = { '<cmd> Telescope live_grep <CR>', 'Live grep' },
		['<leader>fb'] = { '<cmd> Telescope buffers <CR>', 'Find buffers' },
		['<leader>fh'] = { '<cmd> Telescope help_tags <CR>', 'Help page' },
		['<leader>fo'] = { '<cmd> Telescope oldfiles <CR>', 'Find oldfiles' },
		['<leader>fz'] = { '<cmd> Telescope current_buffer_fuzzy_find <CR>', 'Find in current buffer' },

		-- git
		['<leader>cm'] = { '<cmd> Telescope git_commits <CR>', 'Git commits' },
		['<leader>gt'] = { '<cmd> Telescope git_status <CR>', 'Git status' },

		-- pick a hidden term
		['<leader>pt'] = { '<cmd> Telescope terms <CR>', 'Pick hidden term' },

		-- theme switcher
		['<leader>th'] = { '<cmd> Telescope themes <CR>', 'Nvchad themes' },

		['<leader>ma'] = { '<cmd> Telescope marks <CR>', 'telescope bookmarks' },
	},
}

M.nvterm = {
	plugin = true,

	t = {
		-- toggle in terminal mode
		['<A-i>'] = {
			function()
				require('nvterm.terminal').toggle('float')
			end,
			'Toggle floating term',
		},

		['<A-h>'] = {
			function()
				require('nvterm.terminal').toggle('horizontal')
			end,
			'Toggle horizontal term',
		},

		['<A-v>'] = {
			function()
				require('nvterm.terminal').toggle('vertical')
			end,
			'Toggle vertical term',
		},
	},

	n = {
		-- toggle in normal mode
		['<A-i>'] = {
			function()
				require('nvterm.terminal').toggle('float')
			end,
			'Toggle floating term',
		},

		['<leader>h'] = {
			function()
				require('nvterm.terminal').toggle('horizontal')
			end,
			'Toggle horizontal term',
		},

		['<leader>v'] = {
			function()
				require('nvterm.terminal').toggle('vertical')
			end,
			'Toggle vertical term',
		},
	},
}

M.blankline = {
	plugin = true,

	n = {
		['<leader>cc'] = {
			function()
				local ok, start = require('indent_blankline.utils').get_current_context(
					vim.g.indent_blankline_context_patterns,
					vim.g.indent_blankline_use_treesitter_scope
				)

				if ok then
					vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
					vim.cmd([[normal! _]])
				end
			end,

			'Jump to current context',
		},
	},
}

M.gitsigns = {
	plugin = true,

	n = {
		-- Navigation through hunks
		[']c'] = {
			function()
				if vim.wo.diff then
					return ']c'
				end
				vim.schedule(function()
					require('gitsigns').next_hunk()
				end)
				return '<Ignore>'
			end,
			'Jump to next hunk',
			opts = { expr = true },
		},

		['[c'] = {
			function()
				if vim.wo.diff then
					return '[c'
				end
				vim.schedule(function()
					require('gitsigns').prev_hunk()
				end)
				return '<Ignore>'
			end,
			'Jump to prev hunk',
			opts = { expr = true },
		},

		-- Actions
		['<leader>rh'] = {
			function()
				require('gitsigns').reset_hunk()
			end,
			'Reset hunk',
		},

		['<leader>ph'] = {
			function()
				require('gitsigns').preview_hunk()
			end,
			'Preview hunk',
		},

		['<leader>gb'] = {
			function()
				package.loaded.gitsigns.blame_line()
			end,
			'Blame line',
		},

		['<leader>td'] = {
			function()
				require('gitsigns').toggle_deleted()
			end,
			'Toggle deleted',
		},
	},
}

M.treesitter_playground = {
	n = {
		['<leader>mo'] = { Cmd('TSHighlightCapturesUnderCursor'), 'view groups highlight' },
	},
}

M.special = {
	n = {
		-- Toggle para habilitar 'spell'
		['<F9>'] = { Cmd("lua require('core.utils').spell_toggle()") },

		-- Numero de coincidencias seleccionadas
		['n'] = { 'nzz' .. Cmd("lua require('core.utils').hl_search(0.1)") },
		['N'] = { 'Nzz' .. Cmd("lua require('core.utils').hl_search(0.1)") },

		-- Toggle para booleanos: true|false, on|off, yes|no
		['<leader>b'] = { Cmd("lua require('core.utils').toggle_bool()") },
	},
}

return M
