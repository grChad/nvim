local build_commands = {
	javascript = { command = 'node %' },
	typescript = { command = 'tsc' },
	lua = { command = 'lua-language-server %' },
	rust = { command = 'cargo run' },
	-- rust = { command = 'rustc %' },
	python = { command = 'python3 %' },
}

local function create_autocmds(mapping, commands)
	for lang, data in pairs(commands) do
		local command = string.format('nnoremap <Leader>%s :!%s<CR>', mapping, data.command)
		vim.api.nvim_create_autocmd('FileType', { command = command, pattern = lang })
	end
end

-- commands shortcut
create_autocmds('co', build_commands)
vim.api.nvim_create_autocmd('FileType', { command = 'nnoremap <Leader>lo :!love .', pattern = 'lua' })
