call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'davidhalter/jedi-vim'
Plug 'tweekmonster/impsort.vim'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'

call plug#end()

""""""""""
" Themes "
""""""""""
colorscheme gruvbox
set background=dark

let g:gruvbox_contrast_dark = 'hard'
let g:airline_theme='deus'

"""""""""""""""""""""""
" scrooloose/nerdtree "
"""""""""""""""""""""""
nmap <C-n> :NERDTreeToggle<CR>

""""""""""""""""""""""""
" davidhalter/jedi-vim "
""""""""""""""""""""""""
autocmd FileType python setlocal completeopt-=preview

"""""""""""""""""""""""""
" General Configuration "
"""""""""""""""""""""""""
set number
set mouse=a
set encoding=utf-8
set colorcolumn=120
set autoread
