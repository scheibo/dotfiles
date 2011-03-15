" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

set nocompatible
set history=100
set cf               " error files / jumping
set ffs=unix,dos,mac " support these files
set isk+=_,$,@,%,#,- " none word dividers
set viminfo='1000,f1,:100,@100,/20
set modeline         " make sure modeline support is enabled
set autoread
set tabpagemax=50
set hidden
set mouse=a
set backspace=indent,eol,start
set autowrite
set completeopt=longest
set laststatus=2
set nomousehide
set wrap
set shortmess+=r
set novisualbell
set splitright
set splitbelow
set showmode
set lcs=tab:»·   " show tabs
set lcs+=trail:· " show trailing spaces

set notitle

" set the window title in screen
if $STY != ""
    set t_ts=k
    set t_fs=\
endif

" ---------------------------------------------------------------------------
" Colors / Theme
" ---------------------------------------------------------------------------

syntax on
filetype plugin indent on

set t_Co=256
colorscheme darktango

" ---------------------------------------------------------------------------
"  Highlight
" ---------------------------------------------------------------------------

" highlight Comment         ctermfg=DarkGrey guifg=#444444
" highlight StatusLineNC    ctermfg=Black ctermbg=DarkGrey cterm=bold
" highlight StatusLine      ctermbg=Black ctermfg=LightGrey

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
set ignorecase
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
set tabstop=4
set expandtab
set nosmarttab
set smarttab
set formatoptions+=n       " support for numbered/bullet lists
set textwidth=80           " wrap at 80 chars by default
set virtualedit=block

" ----------------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------------

" remap <LEADER> to ',' (instead of '\')
let mapleader = ","

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

" F1 is NERDTree
" F2 is CTags
MapToggle <F3> number
MapToggle <F4> spell
MapToggle <F5> list
MapToggle <F6> hlsearch
MapToggle <F7> paste
MapToggle <F8> wrap
" F9 is strip white space

"swap functionality
nnoremap ' `
nnoremap ` '

vnoremap <C-W> :Align = <CR>

vmap > >gv
vmap < <gv

" ----------------------------------------------------------------------------
"  Auto Commands
" ----------------------------------------------------------------------------

" jump to last position of buffer when opening
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif

" don't use cindent for javascript
autocmd FileType javascript setlocal nocindent

" strip whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" ----------------------------------------------------------------------------
"  PATH on MacOS X
" ----------------------------------------------------------------------------

if system('uname') =~ 'Darwin'
  let $PATH = $HOME .
    \ '/usr/local/bin:/usr/local/sbin:' .
    \ '/usr/pkg/bin:' .
    \ '/opt/local/bin:/opt/local/sbin:' .
    \ $PATH
endif

" ---------------------------------------------------------------------------
"  sh config
" ---------------------------------------------------------------------------

au Filetype sh,bash set ts=4 sts=4 sw=4 expandtab
let g:is_bash = 1

" ---------------------------------------------------------------------------
"  Misc mappings
" ---------------------------------------------------------------------------

map ,f :tabnew <cfile><CR>
map ,d :e %:h/<CR>
map ,dt :tabnew %:h/<CR>
map ,rd :execute "!raco docs ".shellescape(expand("<cword>"),1)<CR><CR>

"map <f9> :w<CR>:!python %<CR>

" ---------------------------------------------------------------------------
"  Open URL on current line in browser
" ---------------------------------------------------------------------------

function! Browser ()
    let line0 = getline (".")
    let line = matchstr (line0, "http[^ )]*")
    let line = escape (line, "#?&;|%")
    exec ':silent !open ' . "\"" . line . "\""
endfunction
map <leader>w :call Browser ()<CR>

" ---------------------------------------------------------------------------
"  Strip all trailing whitespace in file
" ---------------------------------------------------------------------------

function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map <leader>s :call StripWhitespace ()<CR>

nnoremap <silent> <F9> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" ---------------------------------------------------------------------------
" astrails bonuses
" ---------------------------------------------------------------------------

"make Y consistent with C and D
nnoremap Y y$

" <s>Ctrl-E</s><b>,b</b> to switch between 2 last buffers
nmap <leader>b :b#<CR>

" ,e to fast finding files. just type beginning of a name and hit TAB
nmap <leader>e :e **/

" Ctrl-N to disable search match highlight
nmap <silent> <C-N> :silent noh<CR>

" ---------------------------------------------------------------------------
" File Types
" ---------------------------------------------------------------------------

au BufRead,BufNewFile *.rkt        set ft=scheme
au BufRead,BufNewFile *.god        set ft=ruby
au BufRead,BufNewFile *.svg        set ft=svg
au BufRead,BufNewFile *.haml       set ft=haml
au BufRead,BufNewFile *.md         set ft=mkd tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.markdown   set ft=mkd tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.ronn       set ft=mkd tw=80 ts=2 sw=2 expandtab

au Filetype gitcommit set tw=68  spell
au Filetype ruby      set tw=80  ts=2
au Filetype html,xml,xsl,rhtml source $HOME/.vim/scripts/closetag.vim

" ---------------------------------------------------------------------------
" File Type Syntax Highlighting
" ---------------------------------------------------------------------------

let is_mzscheme=1
let python_highlight_all=1
let hs_highlight_delimiters = 1
let hs_highlight_boolean = 1
let hs_highlight_types = 1
let hs_highlight_more_types = 1
let hs_highlight_debug = 1

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
"let NERDTreeWinPos=right
let NERDTreeWinSize=32

nnoremap <silent> <F1> :NERDTreeToggle<CR>
nnoremap <silent> <F2> :TlistToggle<CR>

" nerdcommenter
" ,/ to invert comment on the current line/selection
nmap <leader>/ :call NERDComment(0, "invert")<cr>
vmap <leader>/ :call NERDComment(0, "invert")<cr>


" ---------------------------------------------------------------------------
" Textmate mode
" ---------------------------------------------------------------------------

" we can't map <C-[> to the reverse since its used for ESC
noremap <leader>] <C-]>
noremap <leader>t <C-T>
map <C-]> >

" can't map <C-/>, however, '/' sends an '_' so we can be sneaky
nmap <C-_> :call NERDComment(0, "invert")<cr>
vmap <C-_> :call NERDComment(0, "invert")<cr>

" ---------------------------------------------------------------------------
" Windows Mode
" ---------------------------------------------------------------------------

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q> <C-V>
" backspace in Visual mode deletes selection
vnoremap <BS> d
" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> d
vnoremap <S-Del> d
" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> y
vnoremap <C-Insert> y
" CTRL-V and SHIFT-Insert are Paste
map <C-V> p
map <S-Insert> p
" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u
" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>
" Use CTRL-S for saving, also in Insert mode
noremap <C-S>  :update<CR>
vnoremap <C-S> <C-C>:update<CR>
imap <C-S> <ESC><C-S>

" ---------------------------------------------------------------------------
" X Clipboard
" ---------------------------------------------------------------------------

" Copy to X CLIPBOARD
map <leader>c :w !xsel -i -b<CR><CR>
"map <leader>cp :w !xsel -i -p<CR>
" Paste from X CLIPBOARD
"map <leader>p :r !xsel -b<CR>
"map <leader>pp :r!xsel -p<CR>

function! XClipboardPaste ()
    exec ':set paste'
    exec ':r !xsel -b'
    exec ':set nopaste'
endfunction
map <leader>p :call XClipboardPaste ()<CR>
