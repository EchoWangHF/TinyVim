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
