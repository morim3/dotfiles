" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

let g:dein#auto_recache=1
" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}


let s:watch_files = ['~/.config/nvim/init.vim', '~/.config/nvim/dein.toml', '~/.config/nvim/dein_lazy.toml']


" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, s:watch_files)

  " .toml file
  let s:rc_dir = expand('~/.config/nvim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif

  let s:toml = s:rc_dir . '/dein.toml'
  let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}


"End dein Scripts-------------------------

set fenc=utf-8
set nobackup
set noswapfile
set nowritebackup
set viminfo=
set autoread
set hidden
set showcmd

set list
set number
set cursorline
set virtualedit=all
set smartindent

" set showmatch
" set matchtime=1
" let g:loaded_matchparen = 1

set wildmode=list:longest
set wildmenu
set splitright
set splitbelow

set mouse-=a

" Tab系
set expandtab
set tabstop=2
set shiftwidth=2


" 検索系
set ignorecase
set smartcase
set incsearch
set inccommand=split
set wrapscan
set hlsearch
set backspace=3

if has('persistent_undo')
set undodir=~/.cache/vim_undo
set undofile
endif

let g:python3_host_prog = '/usr/bin/python3'

" シンタックスハイライトの有効化
syntax enable
colorscheme carbonfox
let g:molokai_original = 1
hi CocErrorFloat ctermbg=None ctermfg=177

"マウスの無効化
set mouse = 


" key mapping
let mapleader = "\<Space>"

inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * startinsert

nmap <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap tm :vsp <ENTER> :set nonumber<CR>:terminal <ENTER> 
nnoremap <Space>o :<C-u>call append(expand('.'), '')<Cr>j
nnoremap Y y$

nnoremap <Space>v <C-v>
nnoremap <Space>rc :vsp ~/.config/nvim/init.vim<CR>
nnoremap <Space>plug :vsp ~/.config/nvim/dein.toml<CR>
nnoremap <Space>plugl :vsp ~/.config/nvim/dein_lazy.toml<CR>
nnoremap <Space>zrc :vsp ~/.zshrc<CR> 
nnoremap <Space>atc :cd %:h<CR> :vsp<CR> :set nonumber<CR> :term<CR> g++ -std=c++17 main.cpp -I ~/repos/atcoder/library/ac-library/ && ~/repos/atcoder/.venv/bin/oj t<CR>
inoremap { {}<LEFT>
inoremap {<Enter> {}<Left><CR><ESC><S-o>




""" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    auto_install = true,
    highlight = {
        enable = true,
        disable = { 'vim', 'swift' },
    },
    indent = {
        enable = true,
    },
    additional_vim_regex_highlighting = false,
 }
EOF
