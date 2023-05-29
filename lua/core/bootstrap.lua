local M = {}

M.echo = function(str)
	vim.cmd('redraw')
	vim.api.nvim_echo({ { str, 'Bold' } }, true, {})
end

M.mason_install = function()
	vim.api.nvim_buf_delete(0, { force = true }) -- close previously opened lazy window

	vim.schedule(function()
		vim.cmd('MasonInstallAll')

		-- Keep track of which mason pkgs get installed
		local packages = table.concat(vim.g.mason_binaries_list, ' ')

		require('mason-registry'):on('package:install:success', function(pkg)
			packages = string.gsub(packages, pkg.name:gsub('%-', '%%-'), '') -- rm package name
		end)
	end)
end

M.lazy = function(install_path)
	M.echo('  Instalando lazy.nvim & plugins ...')
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		install_path,
	})
	vim.opt.rtp:prepend(install_path)

	require('plugins')

	-- se instala los servidores de Mason
	M.mason_install()
end

return M
