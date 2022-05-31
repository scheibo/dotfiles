" ===========================================================================
" .vimrc
" ===========================================================================

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

silent! if plug#begin('~/.vim/plugged')

Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'ziglang/zig.vim'

call plug#end()
endif

" ---------------------------------------------------------------------------
" Plugin Bindings
" ---------------------------------------------------------------------------

" can't map <C-/>, however, '/' sends an '_' so we can be sneaky
map <C-_> <plug>NERDCommenterToggle<CR>

nmap <C-p> :GFiles<CR>

" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

set nocompatible
set history=100
set cf               " error files / jumping
set ffs=unix,dos,mac " support these files
set isk+=_,$,@,%,#,- " none word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline
set autoread
set tabpagemax=50
set hidden
set mouse=a
set backspace=indent,eol,start
set autowrite
set completeopt=longest,menu
set pumheight=10
set laststatus=2
set nomousehide
set shortmess+=r
set novisualbell
set splitright
set splitbelow
set showmode
set lcs=tab:»·   " show tabs
set lcs+=trail:· " show trailing spaces
set notitle

" ---------------------------------------------------------------------------
" Colors / Theme
" ---------------------------------------------------------------------------

syntax on
filetype plugin indent on

set t_Co=256
colorscheme darktango

function! HighlightTooLongLines()
  highlight def link RightMargin Error
  if &textwidth != 0
    exec ('match RightMargin /\%>' . &textwidth . 'v.\+/')
  endif
endfunction

augroup filetypedetect
au WinEnter,BufNewFile,BufRead * call HighlightTooLongLines()
augroup END

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" ----------------------------------------------------------------------------
"  Backups
" ----------------------------------------------------------------------------

set nobackup                           " do not keep backups after close
set nowritebackup                      " do not keep a backup while working
set noswapfile                         " don't keep swp files either
set backupdir=$HOME/.vim/backup        " store backups under ~/.vim/backup
set backupcopy=yes                     " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap,~/tmp,.      " keep swp files under ~/.vim/swap

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                  " show the cursor position all the time
set noshowcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
set wildmenu               " turn on wild menu
set wildmode=list:longest,full

set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling

" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch
set mat=5
set incsearch
set laststatus=2
set smartcase
set hlsearch
set visualbell
set vb t_vb=

" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------

set autoindent
set smartindent
set nowrap
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
set nosmarttab
set smarttab
set formatoptions+=n       " support for numbered/bullet lists
set virtualedit=block

" ----------------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------------

" remap <LEADER> to ' ' (instead of '\')
let mapleader      = ' '
let maplocalleader = ' '

" emacs movement keybindings in insert mode
imap <C-a> <C-o>0
imap <C-e> <C-o>$
map <C-e> $
map <C-a> 0

" reflow paragraph with Q in normal and visual mode
nnoremap Q gqap
vnoremap Q gq

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" do not menu with left / right in command line
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>

" unmap annoying keys
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" fix the accident of typing Q instead of q!
cnoremap Q q
cnoremap qq qa

" quicker window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" save the current file as root and reload
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" toggle various modes via the same interface
function MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

" F2 is CTags
MapToggle <F3> number
MapToggle <F4> spell
MapToggle <F5> list
MapToggle <F6> hlsearch
MapToggle <F7> paste
MapToggle <F8> wrap

"swap functionality
nnoremap ' `
nnoremap ` '

vnoremap <C-w> :Align = <CR>

vmap > >gv
vmap < <gv

vmap > >gv
vmap < <gv

"make Y consistent with C and D
nnoremap Y y$

" Ctrl-N to disable search match highlight
nmap <silent> <C-n> :silent noh<CR>

" ----------------------------------------------------------------------------
"  Auto Commands
" ----------------------------------------------------------------------------

" jump to last position of buffer when opening
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif

" don't use cindent for javascript
au FileType javascript setlocal nocindent

" strip whitespace on save
"au BufWritePre * :%s/\s\+$//e

function ModeChange()
  if getline(1) =~ "^#!.*/bin/*"
      silent !chmod u+x <afile>
  endif
endfunction
au BufWritePost * call ModeChange()

au FileType make  set noexpandtab
au FileType go  set noexpandtab

" ---------------------------------------------------------------------------
" File Types
" ---------------------------------------------------------------------------

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <leader>pr :Mm <CR>
endfunction

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()
au BufRead,BufNewFile *.txt call s:setupWrapping()

au BufRead,BufNewFile *.rkt        set ft=scheme
au BufRead,BufNewFile *.god        set ft=ruby
au BufRead,BufNewFile *.svg        set ft=svg
au BufRead,BufNewFile *.haml       set ft=haml
au BufRead,BufNewFile *.md         set ft=mkd tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.markdown   set ft=mkd tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.ronn       set ft=mkd tw=80 ts=2 sw=2 expandtab

au Filetype gitcommit set tw=68  spell
au Filetype ruby      set tw=80  ts=2

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python    set tw=79 ts=4 sw=4 expandtab

" for school
" au FileType c set tw=80 ts=2 sw=2 noexpandtab

au Filetype sh,bash set ts=4 sts=4 sw=4 expandtab
let g:is_bash = 1

" ---------------------------------------------------------------------------
" File Type Syntax Highlighting
" ---------------------------------------------------------------------------

let g:is_mzscheme=1
let g:python_highlight_all=1
let g:hs_highlight_delimiters = 1
let g:hs_highlight_boolean = 1
let g:hs_highlight_types = 1
let g:hs_highlight_more_types = 1
let g:hs_highlight_debug = 1
let g:ruby_operators = 1

" -----------------------------------------------------------
" Highlight
" -----------------------------------------------------------

hi link rubyStringEscape rubyInterpolation
hi link rubyInterpolationDelimiter rubyInterpolation
hi link RubySelf Identifier
hi link rubyStringDelimiter rubyString
hi link rubyRailsMethod Normal
hi link erubyRailsMethod Normal
hi link erubyRailsRenderMethod Type
hi link rubyRailsARMethod Type
hi link rubyRailsRenderMethod Type
hi link rubyRailsHelperMethod Type
hi link rubyRailsViewMethod Type
hi link rubyRailsMigrationMethod Type
hi link rubyRailsControllerMethod Type
hi link rubyRailsFilterMethod Type
hi link javascriptBraces Normal
hi link javaScriptThis Identifier
hi link javaScriptIdentifier Keyword
hi link javaScriptNull Constant
hi link javaScriptFunction Keyword
hi link javaScript Normal

" ---------------------------------------------------------------------------
" Misc
" ---------------------------------------------------------------------------

" backspace in Visual mode deletes selection
vnoremap <BS> d

noremap <C-s>  :update<CR>
vnoremap <C-s> <C-c>:update<CR>
imap <C-s> <ESC><C-s>

command! -nargs=+ G execute 'silent grep! -R <args> .' | copen | execute 'redraw!'
