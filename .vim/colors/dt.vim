" Vim color file
" Name:        darktango.vim
" Author:      Kirk Scheibelhut <kjs@scheibo.com>
" Last Change: 30 Jan 2010
" Version:     1.0
" Notes:       Based on Tango colorscheme

hi clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "darktango"

set background=dark

" ********* General Settings ********* "

" *** Default Colors *** "
hi Normal         ctermbg=232  ctermfg=15   cterm=none
hi NonText        ctermbg=232  ctermfg=12   cterm=none
hi Cursor         ctermbg=0                 cterm=none
hi CursorLine     ctermbg=0                 cterm=none
hi CursorColumn   ctermbg=0                 cterm=none
hi SignColumn     ctermbg=232  ctermfg=15   cterm=none
hi Directory      ctermbg=232  ctermfg=12   cterm=none
hi Title          ctermbg=232  ctermfg=15   cterm=bold

" *** Syntax Colors *** "
hi Comment        ctermbg=232  ctermfg=8    cterm=none
hi Constant       ctermbg=232  ctermfg=1    cterm=none
hi Delimiter      ctermbg=232  ctermfg=238  cterm=none
hi Error          ctermbg=1    ctermfg=15   cterm=none
hi Exception      ctermbg=232  ctermfg=208  cterm=none
hi Function       ctermbg=232  ctermfg=6    cterm=none
hi Macro          ctermbg=232  ctermfg=14   cterm=none
hi PreProc        ctermbg=232  ctermfg=5    cterm=none
hi Statement      ctermbg=232  ctermfg=2    cterm=none
hi Special        ctermbg=232  ctermfg=13   cterm=none
hi String         ctermbg=232  ctermfg=9    cterm=none
hi Structure      ctermbg=232  ctermfg=12   cterm=none
hi ToDo           ctermbg=232  ctermfg=208  cterm=bold
hi Identifier     ctermbg=232  ctermfg=6    cterm=none
hi Ignore         ctermbg=232  ctermfg=23   cterm=none
hi MatchParen     ctermbg=0    ctermfg=7    cterm=none
hi Operator       ctermbg=232  ctermfg=10   cterm=none
hi Type           ctermbg=232  ctermfg=4    cterm=none

hi link Character Constant
hi link Conditional Statement
hi link Float Number
hi link Number Constant
hi link Debug Exception

" *** Window Elements *** "
hi LineNr         ctermbg=232  ctermfg=88   cterm=none
hi StatusLine     ctermbg=0    ctermfg=15   cterm=none
hi StatusLineNC   ctermbg=8    ctermfg=7    cterm=none
hi VertSplit      ctermbg=8    ctermfg=232  cterm=none
hi FoldColumn     ctermbg=232  ctermfg=6    cterm=none
hi Folded         ctermbg=232  ctermfg=6    cterm=none
hi TabLine        ctermbg=8    ctermfg=7    cterm=none
hi TabLineSel     ctermbg=0    ctermfg=15    cterm=none
hi TabLineFill    ctermbg=8    ctermfg=7    cterm=none

" *** Messages *** "
hi! Question       ctermbg=232  ctermfg=7   cterm=none

hi! link ErrorMsg Error
hi! link WarningMsg Exception
hi! link MoreMsg Question
hi! link ModeMsg Question

" *** Visual Mode *** "
hi Visual         ctermbg=0    ctermfg=7    cterm=none
hi VisualNOS      ctermbg=0    ctermfg=7    cterm=none

" *** Search *** "
hi Search         ctermbg=11  ctermfg=0     cterm=none
hi IncSearch      ctermbg=11  ctermfg=0     cterm=none

" ********* Language Specific ********* "

" *** Scheme *** "

hi! link schemeSyntax Statement
hi! link schemeExtSyntax Type

" *** Clojure *** "

hi clojureKeyword   ctermfg=10
hi link clojureFunc PreProc
