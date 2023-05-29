local M = {}
local merge_tb = vim.tbl_deep_extend

M.load_mappings = function(section, mapping_opt)
	vim.schedule(function()
		local function set_section_map(section_values)
			if section_values.plugin then
				return
			end

			section_values.plugin = nil

			for mode, mode_values in pairs(section_values) do
				local default_opts = merge_tb('force', { mode = mode }, mapping_opt or {})
				for keybind, mapping_info in pairs(mode_values) do
					-- merge default + user opts
					local opts = merge_tb('force', default_opts, mapping_info.opts or {})

					mapping_info.opts, opts.mode = nil, nil
					opts.desc = mapping_info[2]

					vim.keymap.set(mode, keybind, mapping_info[1], opts)
				end
			end
		end

		local mappings = require('core.mappings')

		if type(section) == 'string' then
			mappings[section]['plugin'] = nil
			mappings = { mappings[section] }
		end

		for _, sect in pairs(mappings) do
			set_section_map(sect)
		end
	end)
end

M.lazy_load = function(plugin)
	vim.api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter', 'BufNewFile' }, {
		group = vim.api.nvim_create_augroup('BeLazyOnFileOpen' .. plugin, {}),
		callback = function()
			local file = vim.fn.expand('%')
			local condition = file ~= 'NvimTree_1' and file ~= '[lazy]' and file ~= ''

			if condition then
				vim.api.nvim_del_augroup_by_name('BeLazyOnFileOpen' .. plugin)

				-- dont defer for treesitter as it will show slow highlighting
				-- This deferring only happens only when we do "nvim filename"
				if plugin ~= 'nvim-treesitter' then
					vim.schedule(function()
						require('lazy').load({ plugins = plugin })

						if plugin == 'nvim-lspconfig' then
							vim.cmd('silent! do FileType')
						end
					end, 0)
				else
					require('lazy').load({ plugins = plugin })
				end
			end
		end,
	})
end

-- +--------------------------------------------------------------------+
-- functions Custom

M.hl_search = function(blinktime)
	local ns = vim.api.nvim_create_namespace('search')
	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

	local search_pat = '\\c\\%#' .. vim.fn.getreg('/')
	local m = vim.fn.matchadd('IncSearch', search_pat)
	vim.cmd('redraw')
	vim.cmd('sleep ' .. blinktime * 1000 .. 'm')

	local sc = vim.fn.searchcount()
	vim.api.nvim_buf_set_extmark(0, ns, vim.api.nvim_win_get_cursor(0)[1] - 1, 0, {
		virt_text = { { '[' .. sc.current .. '/' .. sc.total .. ']', 'Comment' } },
		virt_text_pos = 'eol',
	})

	vim.fn.matchdelete(m)
	vim.cmd('redraw')
end
-- +--------------------------------------------------------------------+

M.spell_toggle = function()
	if vim.o.spell then
		vim.o.spell = false
		vim.notify('  Deshabilitando Spellchecking ... 😭😭')
	else
		vim.o.spell = true
		vim.notify('  Habilitando Spellchecking ... 😃😃')
	end
end
-- +--------------------------------------------------------------------+
local increment_map = {}

local generate = function(loop_list, capitalize)
	local do_capitalize = capitalize or false

	for i = 1, #loop_list do
		local current = loop_list[i]
		local next = loop_list[i + 1] or loop_list[1]

		increment_map[current] = next

		if do_capitalize then
			local capitalized_current = current:gsub('^%l', string.upper)
			local capitalized_next = next:gsub('^%l', string.upper)

			increment_map[capitalized_current] = capitalized_next
		end
	end
end

-- Booleanos
generate({ 'true', 'false' }, true)
generate({ 'yes', 'no' }, true)
generate({ 'on', 'off' }, true)

M.toggle_bool = function()
	local under_cursor = vim.fn.expand('<cword>')
	local match = false or increment_map[under_cursor]

	if match ~= nil then
		return vim.cmd(':normal ciw' .. match)
	end

	return vim.cmd(':normal!' .. vim.v.count .. '')
end

return M
