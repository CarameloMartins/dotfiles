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
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-syntastic/syntastic'
Plug 'udalov/kotlin-vim'

call plug#end()

""""""""""
" Themes "
""""""""""
colorscheme gruvbox
set background=dark

let g:gruvbox_contrast_dark = 'hard'
let g:airline_theme='gruvbox'

"""""""""""""""""""""""
" scrooloose/nerdtree "
"""""""""""""""""""""""
nmap <C-n> :NERDTreeToggle<CR>

""""""""""""""""""""""""
" davidhalter/jedi-vim "
""""""""""""""""""""""""
autocmd FileType python setlocal completeopt-=preview

""""""""""""""""""""""""""
" hashivim/vim-terraform "
""""""""""""""""""""""""""
let g:terraform_fmt_on_save=1

""""""""""""""""""""""""""""
" vim-syntastic/syntatistc "
""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""""""""""""""""""""""""
" General Configuration "
"""""""""""""""""""""""""
set number
set mouse=a
set encoding=utf-8
set colorcolumn=120
set autoread
set tabstop=4
set softtabstop=0 
set expandtab 
set shiftwidth=4 
set smarttab


