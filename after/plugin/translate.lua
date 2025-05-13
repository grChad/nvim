-- Gracias al repositorio de Kokecoco
-- https://github.com/Kokecoco/translate.nvim
--
-- Idioma de destino predeterminado
local target_language = 'es'

-- Funcion de traducción
local translate_text = function(text, target_lang)
   if not text or text == '' then return nil, 'Texto vacío' end

   -- Escapar comillas y sanitizar
   local sanitized_text = text:gsub('"', '\\"')

   -- Comando confirmado que funciona en tu terminal
   local cmd = string.format('crow -b -t "%s" "%s"', target_lang or target_language, sanitized_text)

   local handle = io.popen(cmd)
   if not handle then return nil, 'Error al ejecutar crow-translate' end

   local result = handle:read('*a')
   handle:close()
   return result and result:gsub('\n$', '') or nil
end

-- Guardar el resultado de la traducción en un archivo
local save_translation_history = function(original, translated)
   if not original or not translated then return end

   local history_file = vim.fn.expand('~/.translate_history_nvim')
   local file, err = io.open(history_file, 'a')
   if not file then
      vim.notify('Error al abrir archivo de historial: ' .. (err or 'unknown'), vim.log.levels.ERROR)
      return
   end

   file:write(
      string.format('Original: %s\nTranslated: %s\n---\n', original:gsub('\n', '\\n'), translated:gsub('\n', '\\n'))
   )
   file:close()
end

-- Traducir el texto de entrada
local translate_input = function()
   local text = vim.fn.input('Texto a traducir: ')
   if text == '' then
      vim.notify('Texto vacío', vim.log.levels.ERROR)
      return
   end

   local result, err = translate_text(text, target_language)
   if not result then
      vim.notify('Error: ' .. (err or 'unknown'), vim.log.levels.ERROR)
      return
   end

   save_translation_history(text, result)
   vim.notify('Traducción: ' .. result)
end

-- Insertar el resultado de la traducción
local translate_and_insert = function()
   local text = vim.fn.input('Texto a traducir: ')
   if text == '' then
      vim.notify('Texto vacío', vim.log.levels.ERROR)
      return
   end

   local result, err = translate_text(text, target_language)
   if not result then
      vim.notify('Error: ' .. (err or 'unknown'), vim.log.levels.ERROR)
      return
   end

   save_translation_history(text, result)
   vim.api.nvim_put({ result }, 'c', true, true)
end

-- Cambiar el idioma de destino
local change_target_language = function()
   local new_language = vim.fn.input('Nuevo idioma destino (' .. target_language .. '): ')
   if new_language == '' then
      vim.notify('Idioma no cambiado', vim.log.levels.WARN)
      return
   end
   target_language = new_language
   vim.notify('Idioma destino cambiado a: ' .. new_language)
end

-- Keymaps corregidas
vim.keymap.set('n', '<Leader>ti', translate_input, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>ta', translate_and_insert, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>tl', change_target_language, { noremap = true, silent = true })
