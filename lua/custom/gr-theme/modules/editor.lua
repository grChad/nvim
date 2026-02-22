local cp = require('custom.gr-theme.palette_manager').get_palette()

return {
   ColorColumn = { bg = cp.selected }, -- used for the columns set with 'colorcolumn'
   Conceal = { fg = cp.overlay1, bg = cp.red }, -- placeholder characters substituted for concealed text (see 'conceallevel')
   Cursor = { fg = cp.textparam, bg = cp.mauve }, -- character under the cursor
   lCursor = { fg = cp.textparam, bg = cp.mauve }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
   CursorIM = { fg = cp.textparam, bg = cp.mauve }, -- like Cursor, but used when in IME mode |CursorIM|
   CursorColumn = { bg = cp.surface2 }, -- columna del cursor, configurar en settings
   CursorLine = { bg = cp.selected }, -- Linea horizontal del cursor

   Directory = { fg = cp.blue }, -- directory names (and other special names in listings)
   EndOfBuffer = { fg = cp.subtext1 }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
   ErrorMsg = { fg = cp.red, style = { 'bold' } }, -- error messages on the command line
   VertSplit = { fg = cp.surface1 }, -- the column separating vertically split windows
   Folded = { fg = cp.lavender, bg = cp.mantle, style = { 'italic' } }, -- line used for closed folds
   FoldColumn = { fg = cp.base }, -- 'foldcolumn'
   SignColumn = { bg = cp.base }, -- column where |signs| are displayed
   SignColumnSB = { bg = cp.base }, -- column where |signs| are displayed
   Substitute = { fg = cp.mantle, bg = cp.sky }, -- |:substitute| replacement text highlighting
   LineNr = { fg = cp.overlay1, bg = cp.base }, -- column numbers and fold signs
   CursorLineNR = { fg = cp.orange, bg = cp.base, style = { 'bold' } }, -- Numero en la posicion del cursor
   MatchParen = { fg = cp.text, bg = cp.maroon, style = { 'bold' } }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
   ModeMsg = { fg = cp.teal, style = { 'bold' } }, -- 'showmode' message (e.g., "-- INSERT -- ")
   -- MsgArea = { fg = cp.text }, -- Area for messages and cmdline
   MsgSeparator = { fg = cp.blue }, -- Separator for scrolled messages, `msgsep` flag of 'display'
   MoreMsg = { fg = cp.text }, -- |more-prompt|
   NonText = { fg = cp.overlay1 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.

   Normal = { fg = cp.text, bg = cp.base }, -- background color of the current buffer
   NormalNC = { fg = cp.text, bg = cp.base }, -- normal text in non-current windows
   NormalSB = { fg = cp.text, bg = cp.mantle }, -- normal text in non-current windows
   NormalFloat = { fg = cp.text, bg = cp.mantle }, -- Normal text in floating windows.
   NormalFloatSelect = { bg = cp.selected },
   FloatBorder = { fg = cp.blue, bg = cp.base }, -- lo uso en [ cmp ]
   FloatTitle = { fg = cp.base, bg = cp.blue, style = { 'bold' } }, -- Title of floating windows
   FloatShadow = { bg = cp.overlay0 },
   FloatShadowThrough = { bg = cp.overlay0 },

   Pmenu = { bg = cp.surface0 }, -- Popup menu: normal item.
   PmenuSel = { bg = cp.selected }, -- Popup menu: selected item.
   PmenuMatch = { fg = cp.text, style = { 'bold' } }, -- Popup menu: matching text.
   PmenuMatchSel = { style = { 'bold' } }, -- Popup menu: matching text in selected item; is combined with |hl-PmenuMatch| and |hl-PmenuSel|.
   PmenuSbar = { bg = cp.mantle }, -- Popup menu: scrollbar.
   PmenuThumb = { bg = cp.blue }, -- Popup menu: Thumb of the scrollbar.
   PmenuExtra = { fg = cp.overlay0 }, -- Popup menu: normal item extra text.
   PmenuExtraSel = { fg = cp.overlay0, bg = cp.surface0, style = { 'bold' } }, -- Popup menu: selected item extra text.

   ComplMatchIns = { link = 'PreInsert' }, -- Matched text of the currently inserted completion.
   PreInsert = { fg = cp.overlay2 }, -- Text inserted when "preinsert" is in 'completeopt'.
   ComplHint = { fg = cp.subtext0 }, -- Virtual text of the currently selected completion.
   ComplHintMore = { link = 'Question' }, -- The additional information of the virtual text.
   Question = { fg = cp.blue }, -- |hit-enter| prompt and yes/no questions
   QuickFixLine = { bg = cp.base, style = { 'bold' } }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
   Search = { fg = cp.base, bg = cp.yellow }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand oucp.
   IncSearch = { fg = cp.crust, bg = cp.gold }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
   CurSearch = { fg = cp.crust, bg = cp.red }, -- 'cursearch' highlighting: highlights the current search you're on differently
   SpecialKey = { link = 'NonText' }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' textspace. |hl-Whitespace|

   SpellBad = { sp = cp.red, style = { 'undercurl' } }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
   SpellCap = { sp = cp.yellow, style = { 'undercurl' } }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
   SpellLocal = { sp = cp.blue, style = { 'undercurl' } }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
   SpellRare = { sp = cp.green, style = { 'undercurl' } }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.

   StatusLine = { fg = cp.text, bg = cp.crust }, -- status line of current window
   StatusLineNC = { fg = cp.surface1, bg = cp.crust }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
   TabLine = { fg = cp.overlay2, bg = cp.crust }, -- tab pages line, not active tab page label
   TabLineFill = { bg = cp.crust }, -- barra de pestañas o buffers
   TabLineSel = { link = 'Normal' }, -- tab pages line, active tab page label
   TermCursor = { fg = cp.base, bg = cp.rosewater }, -- cursor in a focused terminal
   TermCursorNC = { fg = cp.base, bg = cp.overlay2 }, -- cursor in unfocused terminals
   Title = { fg = cp.base, bg = cp.blue, style = { 'bold' } }, -- titles for output from ":set all", ":autocmd" etcp.
   Visual = { bg = cp.surface1 }, -- Visual mode selection
   VisualNOS = { bg = cp.surface1 }, -- Visual mode selection when vim is "Not Owning the Selection".
   WarningMsg = { fg = cp.yellow }, -- warning messages
   Whitespace = { fg = cp.overlay0 }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
   WildMenu = { bg = cp.overlay0 }, -- current match in 'wildmenu' completion
   WinBar = { fg = cp.rosewater },
   WinBarNC = { link = 'WinBar' },
   WinSeparator = { fg = cp.text }, -- window separator :vsp and :sp
}
