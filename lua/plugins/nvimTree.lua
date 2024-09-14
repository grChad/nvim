local ctree = grvim.nvimTree
local icons = grvim.ui.icons.git

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

         local calculate_height = function()
            local height_editor = vim.api.nvim_get_option('lines')

            if height_editor <= 30 then
               return height_editor - 2
            end

            return 28
         end

         local config = {
            windows_float = ctree.windows_float,
            width = ctree.width,
            height = calculate_height(),
            position = ctree.position, -- if windows_float = false: => 'left' and 'right'
         }
         -- +--------------------------------------------------------------------+

         local git_icons = {
            unstaged = icons.modifier,
            staged = icons.check,
            unmerged = icons.icon_branch,
            untracked = icons.add,
            deleted = icons.remove,
            ignored = icons.ignored,
         }

         local options = {
            hijack_cursor = true, -- para tener el cursor un espacio después del nombre
            sort_by = 'case_sensitive', -- Como se ordena en directorio: 'name', 'case_sensitive', 'modification_time', 'extension'
            sync_root_with_cwd = true, -- Cambiar el directorio raiz del arbol en DirChanged
            respect_buf_cwd = true, -- Cambiar el CWD de NvimTree al nuevo buffer al abrir NvimTree

            view = {
               width = config.width,
               side = config.position, -- El lado del panel NvimTree
               float = {
                  enable = config.windows_float,
                  open_win_config = {
                     border = grvim.ui.border_inset,
                     width = config.width,
                     height = config.height - 2,
                     row = (vim.api.nvim_list_uis()[1].height - config.height) * 0.5,
                     col = (vim.api.nvim_list_uis()[1].width - config.width) * 0.5,
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
                  icons = {
                     corner = grvim.ui.icons.separators.corners.curve_bottom_left,
                  },
               },
               icons = {
                  -- Iconos de carpetas y diagnosticos de Git
                  show = {
                     folder_arrow = false, -- "" open directory or "" closed
                  },
                  glyphs = {
                     git = git_icons,
                  },
               },
               special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md', 'package.json', '.env' },
            },

            update_focused_file = {
               enable = true, -- Actualizar el archivo enfocado en 'BufEnter'
               update_root = true,
               -- ignore_list = {},
            },

            diagnostics = {
               -- Diagnosticos LSP
               enable = true, -- default 'false'
               icons = { hint = '󰋗' },
            },

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
                  quit_on_open = ctree.quit_on_open, -- Cierra la ventana de NvimTree al seleccionar un elemento
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
               local view = _G.nvim_tree_view
               local height_editor = vim.api.nvim_get_option('lines')
               local new_height = 25

               if height_editor <= 30 then
                  new_height = height_editor - 2
               else
                  new_height = 28
               end

               view.row = (vim.api.nvim_get_option('lines') - new_height) * 0.5
               view.col = (vim.api.nvim_get_option('columns') - 41) * 0.5

               view.height = new_height - 2
            end,
         })
      end,
   },
}
