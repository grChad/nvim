vim.filetype.add({
   extension = {
      mdx = 'mdx',
   },
})

-- NOTE: para arvhivos 'tex'.
-- Define una función para matar el proceso latexmk
local function kill_latexmk()
   vim.cmd('!killall latexmk')
end

-- Crea un comando personalizado que mate el proceso y luego compile
vim.api.nvim_create_user_command('LatexCompile', function()
   kill_latexmk()
   vim.cmd('TexlabBuild')
end, {})
