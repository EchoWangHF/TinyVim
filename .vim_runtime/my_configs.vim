" yourself setting

" Colorscheme
set background=dark
colorscheme space-vim-dark
"let g:rehash256 = 1
"colorscheme molokai
"colorscheme peaksea
"let g:solarized_termcolors=256
"colorscheme solarized

set cursorline
set cc=80

" set for bangc code as cpp syntax highlight
augroup filetype
au! BufRead,BufNewFile *.mlu set filetype=cpp
augroup END

" set for .mlisa asm code as .s syntax highlight
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

" set for ctags
set tags=tags;/
map <c-]> g<c-]>
