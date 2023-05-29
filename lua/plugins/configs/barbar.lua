return {
	auto_hide = true, -- Oculta la barra cuando queda solo un buffer
	exclude_ft = { 'qf' }, -- Excluir algun fileType
	exclude_name = {}, -- Excluir algun nombre de buffer
	icons = {
		buffer_index = false, -- Mostrar el indice del buffer
		button = '',
		separator = { left = '', right = '' },
		modified = { button = '' },

		inactive = { separator = { left = '|', right = '' } },
	},
	maximum_padding = 0, -- Padding maximo por buffer
	semantic_letters = true, -- Para establecer letras a los buffers en modo de seleccion
	insert_at_end = true,
}
