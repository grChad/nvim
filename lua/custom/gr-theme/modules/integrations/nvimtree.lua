local cp = require('custom.gr-theme.palette_manager').get_palette()

return {
   -- Standard: >
   NvimTreeNormal = { fg = cp.text, bg = cp.mantle }, -- background
   NvimTreeWinSeparator = { fg = cp.base },
   NvimTreeSignColumn = { bg = cp.mantle },
   NvimTreeCursorColumn = { bg = cp.red },
   NvimTreeCursorLine = { bg = cp.selected },

   -- File Text: >
   NvimTreeSpecialFile = { fg = cp.teal, style = { 'bold' } },
   NvimTreeImageFile = { fg = cp.sapphire },
   NvimTreeSymlink = { fg = cp.mauve, style = { 'italic' } },
   NvimTreeExecFile = { fg = cp.text },

   --    Folder Text: >
   NvimTreeRootFolder = { fg = cp.mantle, bg = cp.blue, style = { 'bold' } },
   NvimTreeFolderName = { fg = cp.gold },
   NvimTreeEmptyFolderName = { fg = cp.gold },
   NvimTreeOpenedFolderName = { fg = cp.gold },
   NvimTreeSymlinkFolderName = { fg = cp.gold },

   -- File Icons: >
   NvimTreeSymlinkIcon = { fg = cp.pink },
   -- NvimTreeFileIcon            NvimTreeNormal

   -- Folder Icons: >
   NvimTreeFolderIcon = { fg = cp.gold },
   -- NvimTreeFolderArrowClosed   NvimTreeIndentMarker
   -- NvimTreeFolderArrowOpen     NvimTreeIndentMarker

   -- Indent: >
   NvimTreeIndentMarker = { fg = cp.overlay0 },

   -- Picker: >
   NvimTreeWindowPicker = { fg = cp.text, bg = cp.blue },

   -- Opened: >
   NvimTreeOpenedHL = { fg = cp.blue, style = { 'bold' } },

   -- Git File File Highlight: >
   NvimTreeGitFileDeletedHL = { fg = '#f26359' },
   NvimTreeGitFileDirtyHL = { fg = cp.yellow },
   NvimTreeGitFileIgnoredHL = { fg = cp.overlay1 },
   NvimTreeGitFileMergeHL = { fg = cp.peach },
   NvimTreeGitFileNewHL = { fg = cp.green },
   NvimTreeGitFileRenamedHL = { fg = cp.textparam, style = { 'italic' } },
   NvimTreeGitFileStagedHL = { fg = cp.peach },

   -- Git Folder Folder Highlight: >
   NvimTreeGitFolderDeletedHL = { fg = cp.gold },
   NvimTreeGitFolderDirtyHL = { fg = cp.gold },
   NvimTreeGitFolderIgnoredHL = { fg = cp.gold },
   NvimTreeGitFolderMergeHL = { fg = cp.gold },
   NvimTreeGitFolderNewHL = { fg = cp.gold },
   NvimTreeGitFolderRenamedHL = { fg = cp.gold },
   NvimTreeGitFolderStagedHL = { fg = cp.gold },

   -- Opened: >
   NvimTreeOpenedFile = { fg = cp.blue, style = { 'bold' } },

   -- Diagnostics Icon: >
   NvimTreeDiagnosticErrorIcon = { fg = cp.red },
   NvimTreeDiagnosticWarnIcon = { fg = cp.yellow },
   NvimTreeDiagnosticInfoIcon = { fg = cp.sky },
   NvimTreeDiagnosticHintIcon = { fg = cp.teal },

   -- Git Icon: >
   NvimTreeGitDeletedIcon = { fg = cp.red },
   NvimTreeGitDirtyIcon = { fg = cp.yellow },
   NvimTreeGitNewIcon = { fg = cp.green },
}
