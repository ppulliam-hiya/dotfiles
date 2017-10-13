" Initialize the Pathogen package management system
"call pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Enable file-type specific formatting
filetype plugin indent on

" Allow changing buffers without first saving
set hidden

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color syntax highlighting
syntax on

set background=dark

" Always show current position
set ruler

" Always show the full status bar
set laststatus=2

" highlights characters greater than column 80
autocmd FileType c,cpp,vim let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)
"autocmd BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)
":match ErrorMsg '\%>80v.\+'
"  let's test it here and see if it does --> -->                                xxxxxxxxxxxxxxxxxxxxx

" highlight trailing whitespace
autocmd FileType c,cpp,vim let w:m2=matchadd('Search', '\s\+$', -1)
" let's test it here:        
        

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab

" affects what happens when you press >>, << or ==. It also affects how
" automatic indentation works.
set shiftwidth=4

" affects what happens when you press the <TAB> or <BS> keys. Its default value
" is the same as the value of 'tabstop', but when using indentation without
" hard tabs or mixed indentation, you want to set it to the same value as
" 'shiftwidth'. If 'expandtab' is unset, and 'tabstop' is different from
" 'softtabstop', the <TAB> key will minimize the amount of spaces inserted by
" using multiples of TAB characters. For instance, if 'tabstop' is 8, and the
" amount of consecutive space inserted is 20, two TAB characters and four
" spaces will be used.
set softtabstop=4

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Ignore case when searching
set ignorecase

"case-sensitive if search contains an uppercase character
set smartcase

"Highlight search things
set hlsearch

"Make search act like search in modern browsers
"set incsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags=./tags;/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Taglist
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Close_On_Select = 1 "close taglist window once we selected something
let Tlist_Exit_OnlyWindow = 1 "if taglist window is the only window left, exit vim
let Tlist_Show_Menu = 1 "show Tags menu in gvim
let Tlist_Show_One_File = 1 "show tags of only one file
let Tlist_GainFocus_On_ToggleOpen = 1 "automatically switch to taglist window
let Tlist_Highlight_Tag_On_BufEnter = 1 "highlight current tag in taglist window
let Tlist_Process_File_Always = 1 "even without taglist window, create tags file, required for displaying tag in statusline
"let Tlist_Use_Right_Window = 1 "display taglist window on the right
let Tlist_Display_Prototype = 1 "display full prototype instead of just function name
"let Tlist_Ctags_Cmd = /path/to/exuberant/ctags
nnoremap <F5> :TlistToggle
nnoremap <F6> :TlistShowPrototype
"set statusline=[%n]\ %<%f\ %([%1*%M%*%R%Y]%)\ \ \ [%{Tlist_Get_Tagname_By_Line()}]\ %=%-19(\LINE\ [%l/%L]\ COL\ [%02c%03V]%)\ %P

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-T
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" files to ignore
set wildignore+=*.o,*.d

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctrlp settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let &t_ti.="\e[1 q"
"let &t_SI.="\e[5 q"
"let &t_EI.="\e[1 q"
"let &t_te.="\e[0 q"

"let &t_ti.="\eP\e[1 q\e\\"
"let &t_te.="\eP\e[0 q\e\\"
"let &t_SI.="\eP\e[5 q\e\\"
"let &t_EI.="\eP\e[1 q\e\\"

"let &t_ti.="\eP\e[?7727h\e\\"
"let &t_te.="\eP\e[?7727l\e\\"
"noremap <Esc>O[ <Esc>
"noremap! <Esc>O[ <C-c>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

