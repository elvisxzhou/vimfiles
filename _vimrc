set nocompatible

let mapleader = ","
let g:mapleader = ","

" Make a simple "search" text object.
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  close
  1
endfunction

"Fast saving
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

if has("win32")
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set guifont=courier_new:h10:cANSI
endif
"
"Fast reloading of the .vimrc
map <leader>s :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <leader>e :e! ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

filetype plugin indent on
set ruler
set scrolloff=0
set lazyredraw
set mouse=a
set guitablabel=%{tabpagenr()}.%t\ %m
"autocmd GUIEnter * simalt ~x
set number
syntax enable
set expandtab
set tabstop=4
set cindent shiftwidth=4
set hlsearch
set foldcolumn=4
set foldmethod=syntax
set foldlevelstart=99
set noswapfile
set guioptions+=b
set shortmess+=A
set directory=$VIMRUNTIME/tmp

autocmd FileType make setlocal noexpandtab

color desert

"set encoding=chinese
"set fileencoding=chinese
"set termencoding=chinese
set fileencodings=ucs-bom,utf-8,chinese,taiwan,latin1  

"internationalization
"I only work in Win2k Chinese version
"if has("multi_byte")
"set termencoding=chinese
"set encoding=utf-8
"set fileencodings=utf-8,chinese,ucs-bom
"endif

"if you use vim in tty,
"'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
"if exists("&ambiwidth")
"set ambiwidth=double
"endif

if has('gui_running') && has("win32")
    au GUIEnter * simalt ~x
endif

set hid

set tags=~/tags/stdc.tag,tags

"set browsedir=buffer
set history=500
set showtabline=2
set wildmenu
set novisualbell
set noerrorbells

set laststatus=2

  function! CurDir()
     let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
     return curdir
  endfunction

set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c/%p%%\ \ \ \ FMT:%{&ff}\ [%Y]\ \ \ ASCII[%02.4BH]\

set incsearch
set ignorecase
set smartcase
set matchtime=3
set backspace=indent,eol,start
set cinoptions=:0g0t0(sus
set cinwords=if,elseif,else,for,while,try,except,finally,def,class        
set formatoptions+=mM

""""""""""""""""""""""""""""""
" Vim Grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn'
let Grep_Cygwin_Find = 1


""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

"Map space to / and c-space to ?
map <space> /
map <c-space> ?

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
try
  set switchbuf=usetab
  set stal=2
catch
endtry

"Switch to current dir
map <leader>cd :cd %:p:h<cr>

if has("autocmd")
    autocmd FileType python set complete+=kD:/bin/pydiction iskeyword+=.,(
endif " has("autocmd")

:nnoremap <silent> <F5> :!start cmd /c "%:p:t:r:s,$,.exe," & pause<CR>
noremap <F6> <ESC><ESC>:w!<CR> :!start cmd /c "dmd -unittest -main -m64 -wi %" & pause<CR>
noremap <silent> <F7> :Tlist<CR> 
noremap <F8> :FSHere<CR>

"noremap <F6> :make<CR>
"noremap <S-F6> :make clean;make<CR>

noremap <F1> <C-o>
noremap <F2>  <Tab>
noremap <F3> <C-W>gf<CR>

noremap <C-s> :w<CR>
noremap! <C-s> <ESC><ESC>:w<CR>a

noremap <C-o> :browse tabnew<CR>:cd %:p:h<CR>

"noremap <Tab> <C-W>w:cd %:p:h<CR>:<CR>
"noremap <S-Tab> <C-W>W:cd %:p:h<CR>:<CR>

noremap <C-c> "+y
noremap <C-v> "+p

noremap! <C-c> <ESC><ESC>"+y
noremap! <C-v> <ESC><ESC>"+p

"map <F12> :Project<CR>

let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Exit_OnlyWindow  = 1
let Tlist_Show_One_File = 0
let Tlist_Process_File_Always = 1
let Tlist_Close_On_Select = 0
let proj_flags="cgFims"
