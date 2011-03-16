" Vim color file
" Name:        darktango.vim
" Author:      Kirk Scheibelhut <kjs@scheibo.com>
" Last Change: 30 Jan 2010
" Version:     2.0
" Notes:       Based on Tango colorscheme

hi clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "darktango"

set background=dark

" ********* General Settings ********* "

" *** Default Colors *** "
hi Normal                         guifg=#EEEEEC   ctermbg=232   ctermfg=231   cterm=none
hi NonText                        guifg=#729FCF   ctermbg=232   ctermfg=111   cterm=none
hi Cursor         guibg=#2E3436                   ctermbg=235                 cterm=none
hi CursorLine     guibg=#2E3436                   ctermbg=235                 cterm=none
hi CursorColumn   guibg=#2E3436                   ctermbg=235                 cterm=none
hi SignColumn                     guifg=#EEEEEC   ctermbg=232   ctermfg=231   cterm=none
hi Directory                      guifg=#729FCF   ctermbg=232   ctermfg=111   cterm=none
hi Title                          guifg=#EEEEEC   ctermbg=232   ctermfg=231   cterm=bold

" *** Syntax Colors *** "
hi Comment                        guifg=#555753   ctermbg=232   ctermfg=240   cterm=none
hi Constant                       guifg=#CC0000   ctermbg=232   ctermfg=160   cterm=none
hi Delimiter                                      ctermbg=232   ctermfg=238   cterm=none
hi Error          guibg=#cc0000   guifg=#EEEEEC   ctermbg=160   ctermfg=231   cterm=none
hi Exception      								guifg=#F57900   ctermbg=232   ctermfg=208   cterm=none
hi Function       								guifg=#0B939B   ctermbg=232   ctermfg=38    cterm=none
hi Macro          								guifg=#00F5E9   ctermbg=232   ctermfg=51    cterm=none
hi PreProc        								guifg=#75507B   ctermbg=232   ctermfg=99    cterm=none
hi Statement      								guifg=#4E9A06   ctermbg=232   ctermfg=70    cterm=none
hi Special        								guifg=#AD7FA8   ctermbg=232   ctermfg=140   cterm=none
hi String         								guifg=#EF2929   ctermbg=232   ctermfg=196   cterm=none
hi Structure      								guifg=#729FCF   ctermbg=232   ctermfg=111   cterm=none
hi ToDo           								guifg=#F57900   ctermbg=232   ctermfg=208   cterm=bold
hi Identifier     								guifg=#0B939B   ctermbg=232   ctermfg=38    cterm=none
hi Ignore         								                ctermbg=232   ctermfg=23    cterm=none
hi MatchParen     								guifg=#D3D7CF   ctermbg=235   ctermfg=253   cterm=none
hi Operator       								guifg=#8AE234   ctermbg=232   ctermfg=118   cterm=none
hi Type           								guifg=#3465A4   ctermbg=232   ctermfg=26    cterm=none

hi link Character Constant
hi link Conditional Statement
hi link Float Number
hi link Number Constant
hi link Debug Exception

" *** Window Elements *** "
hi LineNr                         guifg=#A40000   ctermbg=232   ctermfg=88    cterm=none
hi StatusLine     guibg=#2E3436   guifg=#EEEEEC   ctermbg=235   ctermfg=231   cterm=none
hi StatusLineNC   guibg=#555753   guifg=#D3D7CF   ctermbg=240   ctermfg=253   cterm=none
hi VertSplit      guibg=#555753   guifg=#121212   ctermbg=240   ctermfg=232   cterm=none
hi FoldColumn      								guifg=#0B939B   ctermbg=232   ctermfg=38    cterm=none
hi Folded          								guifg=#0B939B   ctermbg=232   ctermfg=38    cterm=none
hi TabLine        guibg=#555753   guifg=#D3D7CF   ctermbg=240   ctermfg=253   cterm=none
hi TabLineSel     guibg=#2E3436   guifg=#EEEEEC   ctermbg=235   ctermfg=231   cterm=none
hi TabLineFill    guibg=#555753   guifg=#D3D7CF   ctermbg=240   ctermfg=253   cterm=none

" *** Messages *** "
hi! Question                      guifg=#D3D7CF   ctermbg=232   ctermfg=253   cterm=none

hi! link ErrorMsg Error
hi! link WarningMsg Exception
hi! link MoreMsg Question
hi! link ModeMsg Question

" *** Visual Mode *** "
hi Visual         guibg=#2E3436   guifg=#D3D7CF   ctermbg=235   ctermfg=253   cterm=none
hi VisualNOS      guibg=#2E3436   guifg=#D3D7CF   ctermbg=235   ctermfg=253   cterm=none

" *** Search *** "
hi Search         guibg=#FCE94F   guifg=#2E3436   ctermbg=220   ctermfg=235   cterm=none
hi IncSearch      guibg=#FCE94F   guifg=#2E3436   ctermbg=220   ctermfg=235   cterm=none

" ********* Language Specific ********* "

" *** Scheme *** "

hi! link schemeSyntax Statement
hi! link schemeExtSyntax Type

" *** Clojure *** "

hi clojureKeyword guifg=#8AE234 ctermfg=118
hi link clojureFunc PreProc