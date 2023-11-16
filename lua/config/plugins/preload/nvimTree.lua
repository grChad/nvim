return {
   {
      'nvim-tree/nvim-tree.lua',
      cmd = 'NvimTreeToggle',
      init = function()
         require('core.utils').load_mappings('nvimtree')
      end,
      config = function()
         local present, nvimtree = pcall(require, 'nvim-tree')
         local icons = require('i-nvim').git

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
            windows_float = true,
            width = 40,
            height = calculate_height(),
            position = 'left', -- if windows_float = false: => 'left' and 'right'
         }
         -- +--------------------------------------------------------------------+

         local nvimtree_icons = {
            git = {
               unstaged = icons.modifier,
               staged = icons.check,
               unmerged = icons.icon_branch,
               untracked = icons.add,
               deleted = icons.remove,
               ignored = icons.ignored,
            },
         }

         local options = {
            hijack_cursor = true,       -- para tener el cursor un espacio después del nombre
            sort_by = 'case_sensitive', -- Como se ordena en directorio: 'name', 'case_sensitive', 'modification_time', 'extension'
            sync_root_with_cwd = true,  -- Cambiar el directorio raiz del arbol en DirChanged
            respect_buf_cwd = true,     -- Cambiar el CWD de NvimTree al nuevo buffer al abrir NvimTree

            view = {
               width = config.width,
               side = config.position, -- El lado del panel NvimTree
               float = {
                  enable = config.windows_float,
                  open_win_config = {
                     border = { ' ', '▁', ' ', '▏', ' ', '▔', ' ', '▕' },
                     width = config.width,
                     height = config.height - 2,
                     row = (vim.api.nvim_list_uis()[1].height - config.height) * 0.5,
                     col = (vim.api.nvim_list_uis()[1].width - config.width) * 0.5,
                  },
               },
            },

            renderer = {
               add_trailing = true,             -- Agrega '/' al final de los directorios
               -- group_empty = false, -- Compactar Carpetas que solo tienen una carpeta, Problema al agregar o renombrar, default = false
               highlight_git = true,            -- Habilitar el resaltado de Git.
               highlight_opened_files = 'name', -- Resaltado del archivo si este esta abierto. 'none', 'icon', 'name', 'all'
               root_folder_label = function(path)
                  local tail = vim.fn.fnamemodify(path, ':p:h:t')
                  local parent = vim.fn.fnamemodify(path, ':p:h:h:t')
                  return string.format('  ../%s/%s/  ', parent, tail)
               end,
               indent_width = 3,
               indent_markers = {
                  -- Indentado
                  enable = true, -- Habilitar el indentado
                  icons = {      -- Iconos para el indentado Custom
                     corner = '╰',
                  },
               },
               icons = {
                  -- Iconos de carpetas y diagnosticos de Git
                  show = {
                     folder_arrow = false, -- "" si el folder esta abierto o "" cerrado
                  },
                  glyphs = {
                     git = nvimtree_icons.git,
                     -- git = {
                     --    unstaged = '',
                     --    staged = '',
                     --    unmerged = '',
                     --    untracked = '',
                     --    deleted = '',
                     -- },
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
               enable = true,
               icons = { hint = '󰋗' },
            },

            filters = {
               dotfiles = true, -- No mostrar archivos ocultos, Alternar con 'H' -> toggle_dotfiles
               custom = {       -- Filtra archivos o ficheros
                  '.swp',
                  '.pyc',
                  'node_modules',
                  '.cache',
                  '.watchmanconfig',
                  '.ruby-version',
                  'Gemfile',
                  '.flowconfig',
                  'buckconfig',
                  '.bundle',
                  '__tests__',
                  'style.css.map',
                  '.git',
               },
               exclude = { '.gitignore' },
            },

            git = {
               ignore = false, -- Ignora los archivos dentro de '.gitignore' require git.enable = true
            },

            actions = {
               change_dir = {
                  global = false, -- cambiar de directorio con :cd
               },
               file_popup = {
                  open_win_config = { border = 'rounded' },
               },
               open_file = {
                  quit_on_open = true, -- Cierra la ventana de NvimTree al seleccionar un elemento
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
