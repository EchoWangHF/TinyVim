" set some plugins_config
call plug#begin()
"==============================================================================
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
"==============================================================================


" 模糊文件查找插件：:LeaderfFile 查找当前目录下文件
"Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" 自动生成成对括号插件；
"Plug 'jiangmiao/auto-pairs'

" 自动补全插件，需要clang
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" 状态栏设置插件和主题
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 左侧设置对齐线插件
Plug 'Yggdroot/indentLine'

" 设置空格检查和删除
Plug 'ntpeters/vim-better-whitespace'


"==============================================================================
" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"==============================================================================
call plug#end()
