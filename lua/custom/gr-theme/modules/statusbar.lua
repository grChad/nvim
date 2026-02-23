local cp = require('custom.gr-theme.palette_manager').get_palette()

return {
   -- special
   S_Separator = { fg = cp.textparam, bg = cp.crust },
   S_Text = { fg = cp.textvar, bg = cp.crust },
   S_SubText = { fg = cp.subtext0, bg = cp.crust },
   S_TextBold = { fg = cp.text, bg = cp.crust, style = { 'bold' } },

   -- Modes nvim
   S_NormalMode = { fg = cp.crust, bg = cp.gold, style = { 'bold' } },
   S_InsertMode = { fg = cp.crust, bg = cp.blue, style = { 'bold' } },
   S_VisualMode = { fg = cp.crust, bg = cp.teal, style = { 'bold' } },
   S_ReplaceMode = { fg = cp.crust, bg = cp.tomato, style = { 'bold' } },
   S_SelectMode = { fg = cp.crust, bg = cp.orange, style = { 'bold' } },
   S_CommandMode = { fg = cp.crust, bg = cp.green, style = { 'bold' } },
   S_ConfirmMode = { fg = cp.crust, bg = cp.sky, style = { 'bold' } },
   S_TerminalMode = { fg = cp.crust, bg = cp.mauve, style = { 'bold' } },

   -- Lsp
   S_IconLsp = { fg = cp.blue, bg = cp.crust },
   S_DiagnosticSignError = { fg = cp.red, bg = cp.crust },
   S_DiagnosticSignWarn = { fg = cp.yellow, bg = cp.crust },
   S_DiagnosticSignInfo = { fg = cp.sky, bg = cp.crust },
   S_DiagnosticSignHint = { fg = cp.teal, bg = cp.crust },

   -- Git
   S_GitIcon = { fg = '#f26359', bg = cp.crust },
   S_GitSignsAdd = { fg = cp.green, bg = cp.crust },
   S_GitSignsDelete = { fg = cp.red, bg = cp.crust },
   S_GitSignsChange = { fg = cp.yellow, bg = cp.crust },

   -- User
   S_UserIcon = { fg = '#51A2DA', bg = cp.crust },

   -- Directory
   S_CwdIcon = { fg = cp.gold, bg = cp.crust },

   -- Spell check
   S_SpellCheck = { fg = cp.mauve, bg = cp.crust },

   -- Ia
   S_IaAssistant = { fg = cp.teal, bg = cp.crust },

   -- icon theme
   GrBarThemeLight = { fg = cp.sky },
   GrBarThemeDark = { fg = cp.yellow },

   -- Cursor position
   S_PositionIconBar = { fg = cp.green, bg = cp.crust },
}
