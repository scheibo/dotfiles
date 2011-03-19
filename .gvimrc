" -----------------------------------------------------------
" General
" -----------------------------------------------------------

" Options which differ from vimrc
set title
set number

set antialias
set guifont=Monaco:h12
"set guifont=Bitstream\ Vera\ Sans\ Mono:h14
set lines=60 columns=250
set guioptions=gemrc
winpos 72 1034
set showtabline=2
"set transparency=15
set clipboard+=unnamed
set fuoptions=maxhorz,maxvert

" No ruby support, Cmd-T not an option, lets use PeepOpen
let g:peepopen_quit=1

" Control-Shift-F for Ack
map <C-S-f> :Ack<space>

" -----------------------------------------------------------
" Highlight
" -----------------------------------------------------------

hi NonText guifg=#2B2B2B
hi MatchParen guibg=#454545

hi Delimiter guifg=#E6E1DC
hi StatusLineNC guibg=#333435 gui=NONE

" Make more like Textmate
hi rubyStringSpecial guifg=#519F50
hi rubyInterpolation guifg=#519F50

hi link rubyStringEscape rubyInterpolation
hi link rubyInterpolationDelimiter rubyInterpolation
hi link RubySelf Identifier
hi link rubyStringDelimiter rubyString
hi link rubyRailsMethod Normal
hi link rubyRailsARMethod Type
hi link rubyRailsRenderMethod Type
hi link rubyRailsHelperMethod Type
hi link rubyRailsViewMethod Type
hi link rubyRailsMigrationMethod Type
hi link rubyRailsControllerMethod Type
hi link rubyRailsFilterMethod Type

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

" ---------------------------------------------------------------------------
" NERDTree Extensions (from Janus)
" ---------------------------------------------------------------------------

" Project Tree
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

" Utility functions to create file commands
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif

  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . fnameescape(a:dir)
  let stay = exists("a:1") ? a:1 : 1

  NERDTree

  if !stay
    wincmd p
  endif
endfunction

function Touch(file)
  execute "!touch " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . shellescape(a:file, 1)
  endif

  call s:UpdateNERDTree()
endfunction

function Mkdir(file)
  execute "!mkdir " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

" We don't have ruby support so this Edit function isn't going to work for us

" function Edit(file)
"   if exists("b:NERDTreeRoot")
"     wincmd p
"   endif
"
"  execute "e " . fnameescape(a:file)
"
" ruby << RUBY
"   destination = File.expand_path(VIM.evaluate(%{system("dirname " . shellescape(a:file, 1))}))
"   pwd         = File.expand_path(Dir.pwd)
"   home        = pwd == File.expand_path("~")
"
"   if home || Regexp.new("^" + Regexp.escape(pwd)) !~ destination
"     VIM.command(%{call ChangeDirectory(fnamemodify(a:file, ":h"), 0)})
"   end
" RUBY
" endfunction

" Define the NERDTree-aware aliases
call s:DefineCommand("cd", "ChangeDirectory")
call s:DefineCommand("touch", "Touch")
call s:DefineCommand("rm", "Remove")
"call s:DefineCommand("e", "Edit")
call s:DefineCommand("mkdir", "Mkdir")
