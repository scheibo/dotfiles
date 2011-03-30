" -----------------------------------------------------------
" General
" -----------------------------------------------------------

" Options which differ from vimrc
set title
set number

set guioptions=gemrc
set showtabline=2
set clipboard+=unnamed
set fuoptions=maxhorz,maxvert

" No ruby support, Cmd-T not an option, lets use PeepOpen
let g:peepopen_quit=1

" Control-Shift-F for Ack
map <C-S-f> :Ack<space>

" -----------------------------------------------------------
" Colorscheme Changer
" -----------------------------------------------------------

" default for darktango
set noantialias
set guifont=Terminus:h16
set lines=60 columns=219
winpos 75 1034

function ChangedColorscheme()
  if g:colors_name == 'railscasts'
    set guifont=Monaco:h12
    "set guifont=Bitstream\ Vera\ Sans\ Mono:h14
    set antialias
    set lines=60 columns=250
    winpos 72 1034

    hi NonText guifg=#2B2B2B
    hi MatchParen guibg=#454545

    hi Delimiter guifg=#E6E1DC
    hi StatusLineNC guibg=#333435 gui=NONE

    " Make more like Textmate
    hi rubyStringSpecial guifg=#519F50
    hi rubyInterpolation guifg=#519F50

    hi link htmlArg htmlTag
    hi link htmlSpecialTagName htmlTag
    hi link erubyDelimiter Normal
    hi link htmlSpecialChar Constant
  else
    " darktango stuff
    set noantialias
    set guifont=Terminus:h16
    set lines=60 columns=219
    winpos 75 1034
  endif
endfunction
au ColorScheme * call ChangedColorscheme()

function ToggleColorscheme()
  if g:colors_name == 'railscasts'
    colorscheme darktango
  else
    colorscheme railscasts
  endif
endfunction
map <leader>x :call ToggleColorscheme ()<CR>

" -----------------------------------------------------------
" Tabs
" -----------------------------------------------------------

" C-TAB and C-SHIFT-TAB cycle tabs forward and backward
nmap <C-tab> :tabnext<CR>
imap <C-tab> <C-o>:tabnext<CR>
vmap <C-tab> <C-o>:tabnext<CR>
nmap <C-S-tab> :tabprevious<CR>
imap <C-S-tab> <C-o>:tabprevious<CR>
vmap <C-S-tab> <C-o>:tabprevious<CR>

" D-# switches to tab
nmap <D-1> 1gt
nmap <D-2> 2gt
nmap <D-3> 3gt
nmap <D-4> 4gt
nmap <D-5> 5gt
nmap <D-6> 6gt
nmap <D-7> 7gt
nmap <D-8> 8gt
nmap <D-9> 9gt
