local present, cmp = pcall(require, 'cmp')
local types = require('cmp.types')

if not present then
	return
end

local icons = {
	Text = ' ',
	Method = ' ',
	Function = '󰡱 ',
	Constructor = ' ',
	Field = 'ﰠ ',
	Variable = '󰫧 ',
	Class = 'ﴯ ',
	Interface = ' ',
	Module = ' ',
	Property = 'ﰠ ',
	Unit = '塞 ',
	Value = ' ',
	Enum = ' ',
	Keyword = ' ',
	Snippet = ' ',
	Color = ' ',
	File = ' ',
	Reference = ' ',
	Folder = ' ',
	EnumMember = ' ',
	Constant = ' ',
	Struct = 'פּ ',
	Event = ' ',
	Operator = ' ',
	TypeParameter = ' ',
	Copilot = ' ',
	Codeium = ' ',
}

vim.o.completeopt = 'menu,menuone,noselect'

local function border(hl_name)
	return {
		{ '╭', hl_name },
		{ '─', hl_name },
		{ '╮', hl_name },
		{ '│', hl_name },
		{ '╯', hl_name },
		{ '─', hl_name },
		{ '╰', hl_name },
		{ '│', hl_name },
	}
end

local function limit_lsp_types(entry, ctx)
	local kind = entry:get_kind()
	local line = ctx.cursor.line
	local col = ctx.cursor.col
	local char_before_cursor = string.sub(line, col - 1, col - 1)
	local char_after_dot = string.sub(line, col, col)

	if char_before_cursor == '.' and char_after_dot:match('[a-zA-Z]') then
		return kind == types.lsp.CompletionItemKind.Method
			or kind == types.lsp.CompletionItemKind.Field
			or kind == types.lsp.CompletionItemKind.Property
	elseif kind == types.lsp.CompletionItemKind.File or kind == types.lsp.CompletionItemKind.Folder then
		return false
	elseif string.match(line, '^%s+%w+$') then
		return kind == types.lsp.CompletionItemKind.Function or kind == types.lsp.CompletionItemKind.Variable
	else
		return true
	end
end

local buffer_option = {
	-- Complete from all visible buffers (splits)
	get_bufnrs = function()
		local bufs = {}
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			bufs[vim.api.nvim_win_get_buf(win)] = true
		end
		return vim.tbl_keys(bufs)
	end,
}

local cmp_window = require('cmp.utils.window')

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
	local info = self:info_()
	info.scrollable = false
	return info
end

local options = {
	window = {
		completion = {
			border = border('FloatBorder'),
			winhighlight = 'Normal:CmpItemMenu,CursorLine:PmenuSel,Search:None',
		},
		documentation = {
			border = border('FloatBorder'),
			winhighlight = 'Normal:None,Search:None',
		},
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)
			return vim_item
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require('luasnip').expand_or_jumpable() then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true),
					''
				)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require('luasnip').jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
			else
				fallback()
			end
		end, { 'i', 's' }),

		['<C-l>'] = cmp.mapping(function(fallback)
			if require('luasnip').expandable() then
				require('luasnip').expand()
			elseif require('luasnip').expand_or_jumpable() then
				require('luasnip').expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<C-h>'] = cmp.mapping(function(fallback)
			if require('luasnip').jumpable(-1) then
				require('luasnip').jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'async_path', priority = 10 },
		{ name = 'nvim_lsp', priority = 9, entry_filter = limit_lsp_types },
		{ name = 'luasnip', priority = 8, max_item_count = 5 },
		{ name = 'codeium', priority = 7, max_item_count = 3 },
		{
			name = 'buffer',
			priority = 6,
			keyword_length = 3,
			option = buffer_option,
			max_item_count = 5,
		},
		{ name = 'nvim_lua', priority = 5 },
		{ name = 'emoji', priority = 4, option = { insert = true } },
	},
	-- sorting = {
	-- 	priority_weight = 2,
	-- 	comparators = {
	-- 		require('copilot_cmp.comparators').prioritize,
	--
	-- 		-- Below is the default comparitor list and order for nvim-cmp
	-- 		cmp.config.compare.offset,
	-- 		-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
	-- 		cmp.config.compare.exact,
	-- 		cmp.config.compare.score,
	-- 		cmp.config.compare.recently_used,
	-- 		cmp.config.compare.locality,
	-- 		cmp.config.compare.kind,
	-- 		cmp.config.compare.sort_text,
	-- 		cmp.config.compare.length,
	-- 		cmp.config.compare.order,
	-- 	},
	-- },
	experimental = {
		ghost_text = true,
	},
}

cmp.setup(options)
