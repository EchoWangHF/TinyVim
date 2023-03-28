" yourself setting

" Colorscheme
set background=dark
"colorscheme gruvbox
"colorscheme space-vim-dark
"let g:rehash256 = 1
"colorscheme molokai
"colorscheme peaksea
"let g:solarized_termcolors=256
colorscheme solarized

set cursorline
set cc=80

" add some set c/cpp syntax with syntax/cpp.vim and syntax/c.vim
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1
""" this is may be some bugs
let g:cpp_experimental_simple_template_highlight = 1

" set for cambricon bangc code as cpp syntax highlight
augroup filetype
au! BufRead,BufNewFile *.mlu set filetype=cpp
augroup END

" set for camricon mlisa asm code as .s syntax highlight
augroup filetype
au! BufRead,BufNewFile *.mlisa set filetype=asm
augroup END

" Enable syntax highlighting for LLVM files. To use, copy
" utils/vim/syntax/llvm.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" Enable syntax highlighting for tablegen files. To use, copy
" utils/vim/syntax/tablegen.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END

" Enable syntax highlighting for reStructuredText files. To use, copy
" rest.vim (http://www.vim.org/scripts/script.php?script_id=973)
" to ~/.vim/syntax .
augroup filetype
 au! BufRead,BufNewFile *.rst     set filetype=rest
augroup END

augroup filetype
 au! BufRead,BufNewFile *.mlir     set filetype=mlir
augroup END

" set for ctags
set tags=tags;/
map <c-]> g<c-]>
