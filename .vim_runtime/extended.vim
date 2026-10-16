" airline set start ======================
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
"let g:airline_theme='simple'
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
" airline set end ======================

"vim-better-whitespace start ==================
"let g:better_whitespace_ctermcolor='yellow'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:current_line_whitespace_disabled_hard=0
let g:current_line_whitespace_disabled_soft=0
"vim-better-whitespace end ==================

" C/C++ language server. vim-lsp-settings finds clangd on PATH or in its
" managed server directory; asyncomplete-lsp provides automatic suggestions.
let g:lsp_settings_filetype_c = ['clangd']
let g:lsp_settings_filetype_cpp = ['clangd']
let g:lsp_settings_servers_dir = expand('~/.vim/lsp-servers')

function! s:TinyVimLspBuffer() abort
  setlocal omnifunc=lsp#complete
  nnoremap <silent><buffer> gd <Plug>(lsp-definition)
  nnoremap <silent><buffer> gr <Plug>(lsp-references)
  nnoremap <silent><buffer> K <Plug>(lsp-hover)
endfunction

augroup tinyvim_lsp
  autocmd!
  autocmd User lsp_buffer_enabled call s:TinyVimLspBuffer()
augroup END
