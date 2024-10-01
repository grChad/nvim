local ntree = grvim.nvimTree

local function get_current_path()
   local handle = io.popen('pwd')
   if not handle then
      error('No se pudo ejecutar el comando "pwd"')
   end

   local current_path = handle:read('*l')
   handle:close()
   return current_path
end

local function count_files_and_directories()
   local path = get_current_path()
   local total_files = 0
   local total_dirs = 0

   -- Usa 'ls' para listar todos los archivos, excepto '.' y '..' y 'ocultos'
   local p = io.popen('ls ' .. path)
   if not p then
      error('No se pudo ejecutar el comando "ls"')
   end
   local output = p:read('*all')
   p:close()

   -- Contar archivos y directorios
   for file in output:gmatch('[^\n]+') do
      local attr = io.popen('test -d ' .. path .. '/' .. file .. ' && echo directory || echo file'):read('*l')
      if attr == 'directory' then
         total_dirs = total_dirs + 1
      else
         total_files = total_files + 1
      end
   end

   return total_files + total_dirs
end

return {
   {
      'nvim-tree/nvim-tree.lua',
      version = '*',
      cmd = { 'NvimTreeToggle', 'NvimTreeClose' },
      keys = require('core.key_plugins').nvimtree,
      config = function()
         local present, nvimtree = pcall(require, 'nvim-tree')

         if not present then
            return
         end

         if vim.filetype == 'NvimTree' then
            vim.opt_local.loaded_netrw = 1
            vim.opt_local.loaded_netrwPlugin = 1
         end

         local floatHeigh = function()
            local height_editor = vim.api.nvim_get_option_value('lines', {})
            local total_files = count_files_and_directories()
            local margin = 2
            local min_files = 25

            if height_editor <= total_files then
               return height_editor - margin
            elseif total_files <= min_files then
               return min_files + margin
            else
               return total_files + margin
            end
         end

         -- +--------------------------------------------------------------------+

         local options = {
            hijack_cursor = true, -- para tener el cursor un espacio después del nombre
            sort_by = 'case_sensitive', -- Como se ordena en directorio: 'name', 'case_sensitive', 'modification_time', 'extension'
            sync_root_with_cwd = true, -- Cambiar el directorio raiz del arbol en DirChanged
            respect_buf_cwd = true, -- Cambiar el CWD de NvimTree al nuevo buffer al abrir NvimTree

            view = {
               width = ntree.width,
               side = ntree.position,
               float = {
                  enable = ntree.isfloat,
                  open_win_config = {
                     border = grvim.ui.border_inset,
                     width = ntree.width,
                     height = floatHeigh() - 2,
                     row = (vim.api.nvim_list_uis()[1].height - floatHeigh()) * 0.5,
                     col = (vim.api.nvim_list_uis()[1].width - ntree.width) * 0.5,
                  },
               },
            },

            renderer = {
               add_trailing = true, -- Agrega '/' al final de los directorios
               -- group_empty = false, -- Compactar Carpetas que solo tienen una carpeta, Problema al agregar o renombrar, default = false
               highlight_git = true, -- Habilitar el resaltado de Git.
               highlight_opened_files = 'name', -- Resaltado del archivo si este esta abierto. 'none', 'icon', 'name', 'all'
               root_folder_label = function(path)
                  local tail = vim.fn.fnamemodify(path, ':p:h:t')
                  local parent = vim.fn.fnamemodify(path, ':p:h:h:t')
                  return string.format('  ../%s/%s/  ', parent, tail)
               end,
               indent_width = 3,
               indent_markers = {
                  enable = true,
                  icons = ntree.indent_markers_icon,
               },
               icons = {
                  -- Iconos de carpetas y diagnosticos de Git
                  show = {
                     folder_arrow = false, -- "" open directory or "" closed
                  },
                  glyphs = { git = ntree.git_icons },
               },
               special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md', 'package.json', '.env' },
            },

            update_focused_file = {
               enable = true, -- Actualizar el archivo enfocado en 'BufEnter'
               update_root = true,
               -- ignore_list = {},
            },

            diagnostics = ntree.diagnostics,

            filters = {
               dotfiles = true, -- No mostrar archivos ocultos, Alternar con 'H' -> toggle_dotfiles
               git_ignored = false, -- no muestra archivos de .gitignore
               -- stylua: ignore
               custom = {           -- Filtra archivos o ficheros
                  '.swp', '.pyc', 'node_modules', '.watchmanconfig',
                  '.ruby-version', 'Gemfile', '.flowconfig', 'buckconfig', '.bundle',
                  '__tests__', 'style.css.map', '.vscode',
               },
               -- exclude = { '.gitignore' },
            },

            actions = {
               change_dir = {
                  global = false, -- change directory
               },
               file_popup = {
                  open_win_config = { border = 'rounded' },
               },
               open_file = {
                  quit_on_open = ntree.quit_on_open, -- Cierra la ventana de NvimTree al seleccionar un elemento
                  window_picker = {
                     -- todas estas opciones estan por default, habilitar si se quiere cambiar
                     -- exclude = {
                     -- 	filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
                     -- 	buftype = { 'nofile', 'terminal', 'help' },
                     -- },
                  },
               },
            },

            trash = {
               cmd = 'trash', -- Comando para eliminal elementos, default=>'gio trash'
            },
         }

         nvimtree.setup(options)

         -- para cambiar el tamaño NvimTree al redimensionar la ventana
         _G.nvim_tree_view = require('nvim-tree.view').View.float.open_win_config

         vim.api.nvim_create_autocmd('VimResized', {
            pattern = '*',
            callback = function()
               nvim_tree_view.row = (vim.api.nvim_get_option_value('lines', {}) - floatHeigh()) * 0.5
               nvim_tree_view.col = (vim.api.nvim_get_option_value('columns', {}) - ntree.width) * 0.5
            end,
         })
      end,
   },
}
