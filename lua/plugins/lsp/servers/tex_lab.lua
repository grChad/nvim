return {
   texlab = {
      auxDirectory = '.',
      bibtexFormatter = 'texlab',
      build = {
         args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f', '-pvc' },
         executable = 'latexmk',
         forwardSearchAfter = false,
         onSave = false,
      },
      chktex = {
         onEdit = false,
         onOpenAndSave = false,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
         args = {},
      },
      latexFormatter = 'latexindent',
      latexindent = {
         modifyLineBreaks = true,
      },
   },
}
