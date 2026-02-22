local cp = require('custom.gr-theme.palette_manager').get_palette()

local operators = cp.text
local conditional = cp.mauve -- conditionals, loops
local the_numbers = cp.peach

return {

   -- Misc
   ['@error'] = { fg = cp.red },
   ['@preproc'] = { fg = cp.pink }, -- various preprocessor directives & shebangs
   ['@define'] = { fg = cp.pink }, -- preprocessor definition directives
   ['@operator'] = { fg = operators }, -- For any operator: +, but also -> and * in cp.

   -- Punctuation
   ['@punctuation.delimiter'] = { fg = cp.text }, -- For delimiters ie: .
   ['@punctuation.bracket'] = { fg = cp.maroon }, -- For brackets and parenthesis.
   ['@punctuation.special'] = { fg = cp.teal }, -- For special punctutation that does not fall in the catagories before.

   ['@character'] = { fg = cp.teal }, -- character literals
   ['@character.special'] = { fg = cp.pink }, -- special characters (e.g. wildcards)

   ['@boolean'] = { fg = cp.tomato, style = { 'italic' } }, -- For booleans.
   ['@number'] = { fg = the_numbers }, -- For all numbers
   ['@float'] = { fg = the_numbers }, -- For floats.

   -- Functions
   ['@function'] = { fg = cp.blue }, -- For function (calls and definitions).
   ['@function.call'] = { fg = cp.blue }, -- function calls
   ['@function.method'] = { fg = cp.blue }, -- function calls
   ['@function.builtin'] = { fg = cp.blue, style = { 'italic' } }, -- For builtin functions: table.insert in Lua.
   ['@function.macro'] = { fg = cp.teal }, -- For macro defined functions (calls and definitions): each macro_rules in Ruscp.

   ['@method'] = { fg = cp.sky }, -- For method calls and definitions.
   ['@method.call'] = { style = { 'italic' } }, -- method calls

   ['@constructor'] = { fg = cp.yellow }, -- For constructor calls and definitions: = { } in Lua, and Java constructors.
   ['@parameter'] = { fg = cp.textparam, style = { 'italic' } }, -- For parameters of a function.

   -- Keywords
   ['@keyword'] = { fg = cp.pink }, -- For keywords that don't fall in previous categories.
   ['@keyword.coroutine'] = { fg = cp.pink, style = { 'italic' } }, -- async, await
   ['@keyword.type'] = { fg = cp.pink, style = { 'bold' } },
   ['@keyword.repeat'] = { fg = cp.mauve, style = { 'bold' } }, -- loop, for, while ...
   ['@keyword.conditional'] = { fg = cp.pink, style = { 'bold' } },
   ['@keyword.operator'] = { fg = cp.mauve, style = { 'italic' } }, -- or, and, new
   ['@keyword.import'] = { fg = cp.mauve },
   ['@keyword.return'] = { fg = cp.mauve, style = { 'bold' } }, -- for 'return'
   ['@keyword.exception'] = { fg = cp.mauve, style = { 'bold' } }, -- try and catch
   ['@keyword.function'] = { fg = cp.red }, -- For keywords used to define a fuction.

   ['@conditional'] = { fg = conditional }, -- For keywords related to conditionnals.
   ['@repeat'] = { fg = conditional }, -- For keywords related to loops.
   -- @debug            ; keywords related to debugging
   ['@label'] = { fg = cp.sapphire }, -- For labels: label: in C and :label: in Lua.
   ['@include'] = { fg = cp.mauve }, -- For includes: #include in C, use or extern crate in Rust, or require in Lua.
   ['@exception'] = { fg = cp.mauve }, -- For exception related keywords.

   -- [ Types ]
   ['@type'] = { fg = cp.gold }, -- For types.
   ['@type.builtin'] = { fg = cp.rosewater, style = { 'italic' } }, -- For builtin types.
   ['@type.definition'] = { link = '@type' }, -- type definitions (e.g. `typedef` in C)
   ['@type.qualifier'] = { link = '@type' }, -- type qualifiers (e.g. `const`)

   ['@storageclass'] = { link = 'StorageClass' }, -- visibility/life-time/etc. modifiers (e.g. `static`)
   ['@attribute'] = { fg = cp.yellow, style = { 'bold' } }, -- attribute annotations (e.g. Python decorators)
   ['@field'] = { fg = cp.teal }, -- For fields.
   ['@property'] = { fg = cp.sky }, -- Same as TSField.

   -- Identifiers
   ['@variable'] = { fg = cp.textvar }, -- Any variable name that does not have another highlighcp.
   ['@variable.builtin'] = { fg = cp.blue }, -- Variable names that are defined by the languages, like this or self.
   ['@variable.member'] = { fg = cp.sky },

   ['@constant'] = { fg = cp.textvar, style = { 'bold' } }, -- For constants
   ['@constant.builtin'] = { fg = cp.red, style = { 'italic' } }, -- For constant that are built in the language: nil in Lua.
   ['@constant.macro'] = { fg = cp.mauve }, -- For constants that are defined by macros: NULL in cp.

   ['@namespace'] = { fg = cp.blue }, -- For identifiers referring to modules and namespaces.
   ['@symbol'] = { fg = cp.flamingo },

   -- [ Literals ]
   ['@string'] = { fg = cp.green }, -- For strings.
   ['@string.regex'] = { fg = cp.teal }, -- For regexes.
   ['@string.escape'] = { fg = cp.rosewater }, -- For escape characters within a string.
   ['@string.special'] = { fg = cp.blue }, -- other special strings (e.g. dates)
   ['@string.special.url'] = { fg = cp.blue, style = { 'italic', 'undercurl' } }, -- other special strings (e.g. dates)

   -- [ Text ]
   ['@text'] = { fg = cp.text }, -- For strings considerated text in a markup language.
   ['@text.strong'] = { fg = cp.flamingo, style = { 'bold' } }, -- bold
   ['@text.emphasis'] = { fg = cp.flamingo, style = { 'italic' } }, -- italic
   ['@text.underline'] = { link = 'Underline' }, -- underlined text
   ['@text.strike'] = { fg = cp.text, style = { 'strikethrough' } }, -- strikethrough text
   ['@text.title'] = { fg = cp.blue, style = { 'bold' } }, -- titles like: # Example
   ['@text.literal'] = { fg = cp.text }, -- used for inline code in markdown and for doc in python (""")
   ['@text.uri'] = { fg = cp.blue, style = { 'italic', 'underline' } }, -- urls, links and emails
   ['@text.math'] = { fg = cp.teal }, -- math environments (e.g. `$ ... $` in LaTeX)
   ['@text.environment'] = { fg = cp.lavender }, -- text environments of markup languages
   ['@text.environment.name'] = { fg = cp.sky }, -- text indicating the type of an environment
   ['@text.reference'] = { fg = cp.sky }, -- references

   ['@comment'] = { fg = cp.overlay0, style = { 'italic' } }, -- just comments
   ['@comment.todo'] = { fg = cp.mantle, bg = cp.yellow, style = { 'bold' } }, -- todo notes
   ['@comment.note'] = { fg = cp.mantle, bg = cp.sky, style = { 'bold' } },
   ['@comment.warning'] = { fg = cp.mantle, bg = cp.orange, style = { 'bold' } },
   ['@comment.error'] = { fg = cp.mantle, bg = cp.red, style = { 'bold' } },

   ['@text.diff.add'] = { link = 'diffAdd' }, -- added text (for diff files)
   ['@text.diff.delete'] = { link = 'diffDelete' }, -- deleted text (for diff files)

   -- [ Tags HTML ]
   ['@tag'] = { fg = cp.red }, -- title, body, div, p, li, ul, lo, script...
   ['@tag.attribute'] = { fg = cp.pink, style = { 'italic' } }, -- href, id, class, rel, name, charset, lang
   ['@tag.delimiter'] = { fg = cp.tomato }, -- Tag delimiter like < > /
   ['@constant.html'] = { fg = cp.teal, style = { 'bold' } }, -- DOCTYPE html
   ['@markup.math'] = { fg = cp.sky },
   ['@markup.heading.html'] = { fg = cp.blue, style = { 'bold' } }, -- titles for output from ":set all", ":autocmd" etcp.
   ['@markup.heading.1.html'] = { fg = cp.textvar, style = { 'bold' } }, -- titles for output from ":set all", ":autocmd" etcp.
   ['@markup.heading.2.html'] = { fg = cp.textvar, style = { 'bold' } }, -- titles for output from ":set all", ":autocmd" etcp.
   ['@markup.heading.3.html'] = { fg = cp.textvar, style = { 'bold' } }, -- titles for output from ":set all", ":autocmd" etcp.
   ['@markup.heading.4.html'] = { fg = cp.textvar, style = { 'bold' } }, -- titles for output from ":set all", ":autocmd" etcp.
   ['@markup.heading.5.html'] = { fg = cp.textvar, style = { 'bold' } }, -- titles for output from ":set all", ":autocmd" etcp.
   ['@markup.heading.6.html'] = { fg = cp.textvar, style = { 'bold' } }, -- titles for output from ":set all", ":autocmd" etcp.
   ['@string.special.url.html'] = { fg = cp.green, style = { 'italic', 'undercurl' } },
   ['@markup.link.label.html'] = { fg = cp.sky, style = { 'italic' } },

   -- [ Markdown }
   ['@markup.strong'] = { fg = cp.flamingo, style = { 'bold' } }, -- bold
   ['@markup.italic'] = { fg = cp.flamingo, style = { 'italic' } }, -- italic
   ['@markup.quote.markdown'] = { fg = cp.textparam }, -- references
   ['@markup.link.url'] = { fg = cp.sky, style = { 'italic', 'underline' } }, -- urls, links and emails

   ['@markup.list'] = { fg = cp.yellow, style = { 'bold' } },
   ['@markup.list.unchecked'] = { fg = cp.yellow, bg = cp.mantle, style = { 'bold' } },
   ['@markup.list.checked'] = { fg = cp.mantle, bg = cp.yellow, style = { 'bold' } },

   ['@markup.heading.markdown'] = { fg = cp.sky, style = { 'bold' } },
   ['@markup.heading.1'] = { fg = cp.red, style = { 'bold', 'underline' } },
   ['@markup.heading.2'] = { fg = cp.peach, style = { 'bold', 'underline' } },
   ['@markup.heading.3'] = { fg = cp.yellow, style = { 'bold', 'underline' } },
   ['@markup.heading.4'] = { fg = cp.green, style = { 'bold', 'underline' } },
   ['@markup.heading.5'] = { fg = cp.sapphire, style = { 'bold', 'underline' } },
   ['@markup.heading.6'] = { fg = cp.lavender, style = { 'bold', 'underline' } },
   ['@markup.raw.block.markdown'] = { fg = cp.textvar }, -- references

   -- [ Markdown inline }
   ['@markup.link.markdown_inline'] = { fg = cp.rosewater }, -- brackets in url and path
   ['@markup.link.label.markdown_inline'] = { fg = cp.rosewater, style = { 'italic' } }, -- urls, links and emails
   ['@markup.raw.markdown_inline'] = { fg = cp.textvar, bg = cp.mantle, style = { 'bold' } }, -- references

   -- [ lua ]
   ['@constructor.lua'] = { fg = cp.yellow }, -- For constructor calls and definitions: = { } in Lua, and Java constructors.

   -- typescript
   ['@constructor.typescript'] = { fg = cp.lavender },

   -- TSX (Typescript React)
   ['@constructor.tsx'] = { fg = cp.lavender },
   ['@tag.tsx'] = { fg = cp.yellow },
   ['@tag.builtin.tsx'] = { fg = cp.red },
   ['@string.special.url.tsx'] = { fg = cp.green, style = { 'undercurl' } },
   ['@string.special.url.ts'] = { fg = cp.green, style = { 'undercurl' } },
   ['@tag.attribute.tsx'] = { fg = cp.flamingo, style = { 'italic' } },
   ['@markup.heading.1.tsx'] = { fg = 'NONE' },
   ['@markup.heading.2.tsx'] = { fg = 'NONE' },
   ['@markup.heading.3.tsx'] = { fg = 'NONE' },
   ['@markup.heading.4.tsx'] = { fg = 'NONE' },
   ['@markup.heading.5.tsx'] = { fg = 'NONE' },
   ['@markup.heading.6.tsx'] = { fg = 'NONE' },

   -- cpp
   ['@property.cpp'] = { fg = cp.rosewater },
   ['@punctuation.delimiter.cpp'] = { fg = cp.text }, -- For delimiters ie: .

   -- [ yaml ]
   ['@field.yaml'] = { fg = cp.sky }, -- For fields.

   -- Ruby
   ['@symbol.ruby'] = { fg = cp.flamingo },

   -- [ from scss and css ]
   ['@string.scss'] = { fg = cp.text },
   ['@type.scss'] = { fg = cp.mauve },
   ['@punctuation.delimiter.scss'] = { fg = cp.sky },
   ['@function.scss'] = { fg = cp.text },

   ['@type.css'] = { fg = cp.mauve },
   ['@punctuation.delimiter.css'] = { fg = cp.sky },
   ['@function.css'] = { fg = cp.text },

   -- [ bash ]
   ['@variable.parameter.bash'] = { fg = cp.textparam, style = { 'italic' } }, -- For parameters of a function.
}
