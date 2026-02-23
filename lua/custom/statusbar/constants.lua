local M = {}

M.hl_groups = {
   modes = {
      normal = 'S_NormalMode',
      insert = 'S_InsertMode',
      visual = 'S_VisualMode',
      replace = 'S_ReplaceMode',
      select = 'S_SelectMode',
      command = 'S_CommandMode',
      confirm = 'S_ConfirmMode',
      terminal = 'S_TerminalMode',
   },
   file_name = {
      separator = 'S_Separator',
      text = 'S_Text',
      subText = 'S_SubText',
      iconFtColor = 'S_iconColor',
   },
   lsp = {
      lspIcon = 'S_IconLsp',
      lspError = 'S_DiagnosticSignError',
      lspWarning = 'S_DiagnosticSignWarn',
      lspInfo = 'S_DiagnosticSignInfo',
      lspHint = 'S_DiagnosticSignHint',
   },
   git = {
      gitIcon = 'S_GitIcon',
      gitAdd = 'S_GitSignsAdd',
      gitRemove = 'S_GitSignsDelete',
      gitChange = 'S_GitSignsChange',
   },
   user = { userIcon = 'S_UserIcon', text = 'S_Text' },
   directory = { cwdIcon = 'S_CwdIcon', text = 'S_Text' },
   spell_check = { spell = 'S_SpellCheck', subText = 'S_SubText' },
   ia = { subText = 'S_SubText', assistant = 'S_IaAssistant' },
   cursor_position = { textBold = 'S_TextBold', iconPositionBar = 'S_PositionIconBar' },
}

return M
