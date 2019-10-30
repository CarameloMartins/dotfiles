call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'davidhalter/jedi-vim'
Plug 'tweekmonster/impsort.vim'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'

call plug#end()

colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'

"""""""""""""""""""""""
" scrooloose/nerdtree "
"""""""""""""""""""""""
nmap <C-n> :NERDTreeToggle<CR>

"""""""""""""""""""""""""
" General Configuration "
"""""""""""""""""""""""""
set number
set mouse=a
