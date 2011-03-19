" Vim color file
" Name:        darktango.vim
" Author:      Kirk Scheibelhut <kjs@scheibo.com>
" Last Change: 14 March 2011
" Version:     3.0
" Notes:       Based on Tango colorscheme

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "darktango"

" ********* General Settings ********* "

" *** Default Colors *** "
hi Normal         guibg=#080808  guifg=#EEEEEC  ctermbg=232  ctermfg=15  cterm=none
hi NonText        guibg=#080808  guifg=#729FCF  ctermbg=232  ctermfg=12  cterm=none
hi Cursor         guibg=#2E3436                 ctermbg=0                cterm=none
hi CursorLine     guibg=#2E3436                 ctermbg=0                cterm=none
hi CursorColumn   guibg=#2E3436                 ctermbg=0                cterm=none
hi SignColumn     guibg=#080808  guifg=#EEEEEC  ctermbg=232  ctermfg=15  cterm=none
hi Directory      guibg=#080808  guifg=#729FCF  ctermbg=232  ctermfg=12  cterm=none
hi Title          guibg=#080808  guifg=#EEEEEC  ctermbg=232  ctermfg=15  cterm=bold

" *** Syntax Colors *** "
hi Comment        guibg=#080808  guifg=#555753  ctermbg=232  ctermfg=8    cterm=none
hi Constant       guibg=#080808  guifg=#CC0000  ctermbg=232  ctermfg=1    cterm=none
hi Delimiter      guibg=#080808  guifg=#444444  ctermbg=232  ctermfg=238  cterm=none
hi Error          guibg=#cc0000  guifg=#EEEEEC  ctermbg=1    ctermfg=15   cterm=none
hi Exception      guibg=#080808  guifg=#F57900  ctermbg=232  ctermfg=208  cterm=none
hi Function       guibg=#080808  guifg=#0B939B  ctermbg=232  ctermfg=6    cterm=none
hi Macro          guibg=#080808  guifg=#00F5E9  ctermbg=232  ctermfg=14   cterm=none
hi PreProc        guibg=#080808  guifg=#75507B  ctermbg=232  ctermfg=5    cterm=none
hi Statement      guibg=#080808  guifg=#4E9A06  ctermbg=232  ctermfg=2    cterm=none
hi Special        guibg=#080808  guifg=#AD7FA8  ctermbg=232  ctermfg=13   cterm=none
hi String         guibg=#080808  guifg=#EF2929  ctermbg=232  ctermfg=9    cterm=none
hi Structure      guibg=#080808  guifg=#729FCF  ctermbg=232  ctermfg=12   cterm=none
hi ToDo           guibg=#080808  guifg=#F57900  ctermbg=232  ctermfg=208  cterm=bold
hi Identifier     guibg=#080808  guifg=#0B939B  ctermbg=232  ctermfg=6    cterm=none
hi Ignore         guibg=#080808  guifg=#005f00  ctermbg=232  ctermfg=23   cterm=none
hi MatchParen     guibg=#2E3436  guifg=#D3D7CF  ctermbg=0    ctermfg=7    cterm=none
hi Operator       guibg=#080808  guifg=#8AE234  ctermbg=232  ctermfg=10   cterm=none
hi Type           guibg=#080808  guifg=#3465A4  ctermbg=232  ctermfg=4    cterm=none

hi link Character Constant
hi link Conditional Statement
hi link Float Number
hi link Number Constant
hi link Debug Exception

" *** Diff *** "
hi DiffAdd        guibg=#080808  guifg=#8AE234  ctermbg=232  ctermfg=2    cterm=bold
hi DiffChange     guibg=#080808                 ctermbg=232
hi DiffDelete     guibg=#080808  guifg=#EF2929  ctermbg=232  ctermfg=1    cterm=bold
hi DiffText       guibg=#080808  guifg=#FCE94F  ctermbg=232  ctermfg=11   cterm=none

" *** Spelling *** "
hi SpellBad       guibg=#EF2929  guifg=#EEEEEC  ctermbg=9    ctermfg=15
hi SpellCap       guibg=#0B939B  guifg=#EEEEEC  ctermbg=6    ctermfg=15
hi SpellRare      guibg=#4A9A06  guifg=#080808  ctermbg=2    ctermfg=232
hi SpellLocal     guibg=#0B939B  guifg=#EEEEEC  ctermbg=6    ctermfg=15

" *** Window Elements *** "
hi LineNr         guibg=#080808  guifg=#A40000  ctermbg=232  ctermfg=88   cterm=none  gui=NONE
hi StatusLine     guibg=#2E3436  guifg=#EEEEEC  ctermbg=0    ctermfg=15   cterm=none  gui=NONE
hi StatusLineNC   guibg=#555753  guifg=#D3D7CF  ctermbg=8    ctermfg=7    cterm=none  gui=NONE
hi VertSplit      guibg=#555753  guifg=#121212  ctermbg=8    ctermfg=232  cterm=none  gui=NONE
hi FoldColumn     guibg=#080808  guifg=#0B939B  ctermbg=232  ctermfg=6    cterm=none  gui=NONE
hi Folded         guibg=#080808  guifg=#0B939B  ctermbg=232  ctermfg=6    cterm=none  gui=NONE
hi TabLine        guibg=#555753  guifg=#D3D7CF  ctermbg=8    ctermfg=7    cterm=none
hi TabLineSel     guibg=#2E3436  guifg=#EEEEEC  ctermbg=0    ctermfg=15   cterm=none
hi TabLineFill    guibg=#555753  guifg=#D3D7CF  ctermbg=8    ctermfg=7    cterm=none

" *** Messages *** "
hi! Question      guibg=#080808  guifg=#D3D7CF  ctermbg=232  ctermfg=7    cterm=none

hi! link ErrorMsg Error
hi! link WarningMsg Exception
hi! link MoreMsg Question
hi! link ModeMsg Question

" *** Visual Mode *** "
hi Visual         guibg=#2E3436  guifg=#D3D7CF  ctermbg=0    ctermfg=7    cterm=none
hi VisualNOS      guibg=#2E3436  guifg=#D3D7CF  ctermbg=0    ctermfg=7    cterm=none

" *** Search *** "
hi Search         guibg=#FCE94F  guifg=#2E3436  ctermbg=11   ctermfg=0    cterm=none
hi IncSearch      guibg=#FCE94F  guifg=#2E3436  ctermbg=11   ctermfg=0    cterm=none


" ********* Language Specific ********* "

" *** Scheme *** "

hi! link schemeSyntax Statement
hi! link schemeExtSyntax Type

" *** Clojure *** "

hi clojureKeyword   guifg=#8AE234  ctermfg=10
hi link clojureFunc PreProc
