" Add call sites and class declarations to Vim's built-in Python syntax.
" These matches stay outside strings and comments because those regions do not
" contain either group.
syn match pythonCall /\<\h\w*\ze\s*(/ contains=NONE
syn keyword pythonClassKeyword class nextgroup=pythonClassName skipwhite
syn match pythonClassName /\h\w*/ contained

hi def link pythonCall Function
hi def link pythonClassKeyword Statement
hi def link pythonClassName Typedef
