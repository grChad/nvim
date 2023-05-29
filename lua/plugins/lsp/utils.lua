local U = {}

-- NOTE: On Attach ------------------------------------------------------------
U.on_attach = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_document_highlight' })
		vim.api.nvim_create_autocmd('CursorHold', {
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = 'lsp_document_highlight',
			desc = 'Document Highlight',
		})
		vim.api.nvim_create_autocmd('CursorMoved', {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = 'lsp_document_highlight',
			desc = 'Clear All the References',
		})
	end

	client.server_capabilities.semanticTokensProvider = nil
	client.server_capabilities.documentFormattingProvider = true
	client.server_capabilities.documentRangeFormattingProvider = true
end

U.on_attach_sin_highlight = function(client, _)
	client.server_capabilities.semanticTokensProvider = nil
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

-- NOTE: Capabilities ---------------------------------------------------------
U.capabilities = require('cmp_nvim_lsp').default_capabilities()
U.capabilities = vim.lsp.protocol.make_client_capabilities()
U.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { 'markdown', 'plaintext' },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			'documentation',
			'detail',
			'additionalTextEdits',
		},
	},
}
U.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

-- NOTE: Handlers -------------------------------------------------------------
U.handlers = {
	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', title = ' Hover ' }),
	['textDocument/signatureHelp'] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = 'rounded', title = ' Help ' }
	),
	['textDocument/publishDiagnostics'] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ virtual_text = true }
	),
}

-- NOTE: Handlers para plugin Ufo ---------------------------------------------
U.handler_ufo = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (' ... %d Hidden Lines '):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0

	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end

	vim.api.nvim_set_hl(0, 'Msg_Fold', { fg = '#E7E4E0', italic = true })

	table.insert(newVirtText, { suffix, 'Msg_Fold' })

	return newVirtText
end

return U
