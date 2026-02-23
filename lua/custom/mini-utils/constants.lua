local M = {}

M.list_toggles = {
   -- Booleanos básicos
   { 'true', 'false' },
   { 'yes', 'no' },
   { 'on', 'off' },
   { 'enable', 'disable' },
   { 'active', 'inactive' },
   { 'visible', 'hidden' },
   { 'enabled', 'disabled' },
   { 'checked', 'unchecked' },
   { 'selected', 'unselected' },
   { 'expanded', 'collapsed' },

   -- Visibilidad/Acceso
   { 'public', 'protected', 'private' },
   { 'static', 'instance' },
   { 'internal', 'external' },
   { 'abstract', 'concrete' },

   -- Direcciones y posiciones
   { 'top', 'bottom', 'left', 'right' },
   { 'horizontal', 'vertical' },
   { 'portrait', 'landscape' },
   { 'center', 'start', 'end' },
   { 'flex-start', 'flex-end' },
   { 'ltr', 'rtl' },
   { 'marginHorizontal', 'marginVertical' },
   { 'paddingHorizontal', 'paddingVertical' },
   { 'justifyContent', 'alignItems', 'alignSelf' },
   { 'row', 'column' },
   { 'marginLeft', 'marginRight', 'marginTop', 'marginBottom' },
   { 'paddingLeft', 'paddingRight', 'paddingTop', 'paddingBottom' },

   -- Tamaños y cantidades
   { 'xs', 'sm', 'md', 'lg', 'xl' },
   { 'small', 'medium', 'large' },
   { 'min', 'mid', 'max' },
   { 'low', 'medium', 'high' },

   -- Colores comunes
   { 'red', 'green', 'blue' },
   { 'primary', 'secondary', 'tertiary' },

   -- Tipos de datos
   { 'string', 'number', 'boolean' },
   { 'int', 'float', 'double' },
   { 'array', 'object', 'set', 'map' },
   { 'list', 'tuple', 'dict' },
   { 'var', 'let', 'const', 'val' },

   -- Estructuras de control
   { 'if', 'else' },
   { 'try', 'catch', 'finally' },
   { 'for', 'while' },
   { 'break', 'continue', 'case' },

   -- HTTP y APIs
   { 'GET', 'POST', 'PUT', 'DELETE', 'PATCH' },
   { '200', '201', '400', '401', '403', '404', '500' },

   -- Base de datos
   { 'SELECT', 'INSERT', 'UPDATE', 'DELETE' },
   { 'INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN' },
   { 'ASC', 'DESC' },
   { 'AND', 'OR', 'NOT' },
   { 'NULL', 'NOT NULL' },

   -- Python
   { 'def', 'class' },
   { 'self', 'cls' },
   { '__init__', '__new__', '__call__' },
   { 'try', 'except', 'finally' },
   { 'with', 'as' },

   -- Go
   { 'func', 'method' },
   { 'struct', 'interface' },
   { 'chan', 'go', 'select' },

   -- Kotlin/Android
   { 'dp', 'sp', 'px' },
   { 'data', 'sealed', 'enum', 'annotation' },
}

return M
