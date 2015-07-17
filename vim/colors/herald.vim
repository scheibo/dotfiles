" Vim color file
" Name:       darktango.vim
" Author:     Kirk Scheibelhut <kjs@scheibo.com>
" Version:    0.1.0
" Notes:      Based on Tango colorscheme

hi clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "darktango"

set background=dark

" ********** 256 Color Terminal ********** "

" -> Text; Miscellaneous
hi Normal         ctermbg=234  ctermfg=252   cterm=none
hi SpecialKey     ctermbg=234  ctermfg=176   cterm=none
hi VertSplit      ctermbg=234  ctermfg=227   cterm=none
hi SignColumn     ctermbg=234  ctermfg=141   cterm=none
hi NonText        ctermbg=234  ctermfg=204   cterm=none
hi Directory      ctermbg=234  ctermfg=227   cterm=none 
hi Title          ctermbg=234  ctermfg=84    cterm=bold

" -> Cursor 
hi Cursor         ctermbg=227  ctermfg=234   cterm=none
hi CursorIM       ctermbg=227  ctermfg=234   cterm=none
hi CursorColumn   ctermbg=0                  cterm=none
hi CursorLine     ctermbg=0                  cterm=none

" -> Folding
hi FoldColumn     ctermbg=234  ctermfg=25    cterm=none
hi Folded         ctermbg=234  ctermfg=25    cterm=none

" -> Line info  
hi LineNr         ctermbg=0    ctermfg=241   cterm=none
hi StatusLine     ctermbg=0    ctermfg=241   cterm=none
hi StatusLineNC   ctermbg=237  ctermfg=241   cterm=none

" -> Messages
hi ErrorMsg       ctermbg=124  ctermfg=252   cterm=none
hi Question       ctermbg=234  ctermfg=214   cterm=none
hi WarningMsg     ctermbg=214  ctermfg=0     cterm=none
hi MoreMsg        ctermbg=234  ctermfg=214   cterm=none
hi ModeMsg        ctermbg=234  ctermfg=214   cterm=none

" -> Search 
hi Search         ctermbg=241  ctermfg=227   cterm=none 
hi IncSearch      ctermbg=241  ctermfg=227   cterm=none

" -> Diff
hi DiffAdd        ctermbg=22   ctermfg=208   cterm=none
hi DiffChange     ctermbg=235  ctermfg=130   cterm=none
hi DiffDelete     ctermbg=234  ctermfg=208   cterm=none
hi DiffText       ctermbg=24   ctermfg=208   cterm=underline

" -> Menu
hi Pmenu          ctermbg=0    ctermfg=52    cterm=none
hi PmenuSel       ctermbg=208  ctermfg=52    cterm=none
hi PmenuSbar      ctermbg=52                 cterm=none
hi PmenuThumb     ctermbg=52                 cterm=none
hi PmenuSel       ctermbg=208  ctermfg=52    cterm=none

" -> Tabs
hi TabLine        ctermbg=233  ctermfg=234   cterm=none
hi TabLineFill    ctermbg=0                  cterm=none
hi TabLineSel     ctermbg=234  ctermfg=252   cterm=bold 
"
" -> Visual Mode
hi Visual         ctermbg=0    ctermfg=215   cterm=none 
hi VisualNOS      ctermbg=0    ctermfg=241   cterm=none

" -> Code
hi Comment        ctermbg=234  ctermfg=241   cterm=none
hi Constant       ctermbg=234  ctermfg=84    cterm=none
hi String         ctermbg=234  ctermfg=215   cterm=none
hi Error          ctermbg=234  ctermfg=203   cterm=none
hi Identifier     ctermbg=234  ctermfg=75    cterm=none
hi Function       ctermbg=234  ctermfg=117   cterm=none
hi Ignore         ctermbg=234  ctermfg=234   cterm=none
hi MatchParen     ctermbg=214  ctermfg=234   cterm=none
hi PreProc        ctermbg=234  ctermfg=141   cterm=none
hi Special        ctermbg=234  ctermfg=227   cterm=none
hi Todo           ctermbg=234  ctermfg=203   cterm=bold
hi Underlined     ctermbg=234  ctermfg=203   cterm=underline
hi Statement      ctermbg=234  ctermfg=176   cterm=none
hi Operator       ctermbg=234  ctermfg=204   cterm=none
hi Delimiter      ctermbg=234  ctermfg=204   cterm=none
hi Type           ctermbg=234  ctermfg=227   cterm=none
hi Exception      ctermbg=234  ctermfg=203   cterm=none 

" -> HTML-specific
hi htmlBold                 ctermbg=234  ctermfg=252   cterm=bold
hi htmlBoldItalic           ctermbg=234  ctermfg=252   cterm=bold,italic
hi htmlBoldUnderline        ctermbg=234  ctermfg=252   cterm=bold,underline
hi htmlBoldUnderlineItalic  ctermbg=234  ctermfg=252   cterm=bold,underline,italic
hi htmlItalic               ctermbg=234  ctermfg=252   cterm=italic
hi htmlUnderline            ctermbg=234  ctermfg=252   cterm=underline
hi htmlUnderlineItalic      ctermbg=234  ctermfg=252   cterm=underline,italic

hi! default link bbcodeBold htmlBold
hi! default link bbcodeBoldItalic htmlBoldItalic
hi! default link bbcodeBoldItalicUnderline htmlBoldUnderlineItalic
hi! default link bbcodeBoldUnderline htmlBoldUnderline
hi! default link bbcodeItalic htmlItalic
hi! default link bbcodeItalicUnderline htmlUnderlineItalic
hi! default link bbcodeUnderline htmlUnderline

" Spellcheck formatting
if has("spell")
	hi SpellBad   guisp=#FC4234 gui=undercurl
	hi SpellCap   guisp=#70BDF1 gui=undercurl
	hi SpellLocal guisp=#FFEE68 gui=undercurl
	hi SpellRare  guisp=#6DF584 gui=undercurl
endif
