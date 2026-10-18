" Common Options
set nocompatible
filetype on

set number
set cursorline
set smarttab
set wildmenu wildoptions=pum
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmatch
set hlsearch
set history=1000
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Plug-vim install
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'w0rp/ale'
Plug 'lervag/vimtex'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'Chiel92/vim-autoformat'
Plug 'lifepillar/vim-mucomplete'
Plug 'tpope/vim-sensible'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/indentpython.vim'
Plug 'alvan/vim-closetag'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'flazz/vim-colorschemes'
Plug 'sheerun/vim-polyglot'
Plug 'dracula/vim'
call plug#end()

" Markdown
set nofoldenable

" Light line plugin
set laststatus=2
set noshowmode

let g:lightline = { 'colorscheme': 'one' }

"Colorscheme
colorscheme onedark

" Some stuff
syntax on
filetype plugin on
filetype indent on

"Ale Plugin
set omnifunc=ale#completion#OmniFunc
set completeopt+=menuone
set completeopt+=noselect

"mu-complete
let g:mucomplete#enable_auto_at_startup = 1

"My mapping
augroup filetype_py
    autocmd!
    :autocmd FileType python noremap <leader>c :w<CR>:!python %<CR>
augroup end

augroup filetype_tex
    autocmd!
    :autocmd FileType tex noremap <leader>c :VimtexCompile<CR>
    :autocmd FileType tex noremap <leader>m <esc>:w!<cr>:make<cr>
    :autocmd FileType markdown noremap <leader>m <esc>:w!<cr>:make<cr>
    let g:vimtex_compiler_latexmk = {'executable' : 'latexmk', 'options' : [ '-xelatex', '-file-line-error', '-synctex=1', '-interaction=nonstopmode', ], }
    let g:vimtex_quickfix_enabled = 0
    let g:vimtex_compiler_latexmk_engines = {'_' : '-xelatex',}
augroup end


"My mapping
noremap <space> :

let mapleader = " "
let g:mapleader = " "

nnoremap <leader>b :b<space>
nnoremap <leader>e :edit<space>
nnoremap <leader>f :Files<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>s :%s/
nnoremap <leader>v :vs<cr>
nnoremap <leader>w :w!<cr>
nnoremap <leader>d "_dd

nnoremap <M-up> :m .-2<CR>==
nnoremap <M-down> :m .+1<CR>==
inoremap <M-up> <Esc>:m .-2<CR>==gi
inoremap <M-down> <Esc>:m .+1<CR>==gi
vnoremap <M-up> :m '<-2<CR>gv=gv
vnoremap <M-down> :m '>+1<CR>gv=gv

nnoremap <C-S-M-down> :t.<CR>
nnoremap <C-S-M-up> yyP

nnoremap <C-k> "_dd
nnoremap <C-S-i> :Autoformat<CR>


