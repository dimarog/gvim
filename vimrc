" .vimrc File
" Maintained by: Dima Roginsky
"

version 7.4
if v:version < 700
	finish
endif

"let g:exvim_custom_path='c:/exvim/'
"source c:/exvim/.vimrc

"Forget compatibility with Vi. Who cares. FIXME need to be checked
set nocompatible

autocmd! BufEnter *


" to disable a bundle, must do it before pathogen#infect
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'bundle/python_mode')
call add(g:pathogen_disabled, 'bundle/python_mode/plugin/pymode.vim')
call add(g:pathogen_disabled, 'bundle/python_mode/ftplugin/python/pymode.vim')
call add(g:pathogen_disabled, '/usr2/droginsk/dotvim/bundle/python_mode')
call add(g:pathogen_disabled, '/usr2/droginsk/dotvim/bundle/python_mode/plugin/pymode.vim')
call add(g:pathogen_disabled, '/usr2/droginsk/dotvim/bundle/python_mode/ftplugin/python/pymode.vim')

"call pathogen#runtime_append_all_bundles()
execute pathogen#infect()
call pathogen#infect()
"call pathogen#interpose('bundle/YouCompleteMe')
"call pathogen#interpose('bundle/snippets')
"call pathogen#interpose('bundle/clang_complete')
"call pathogen#interpose('bundle/emacsauto')
"call pathogen#interpose('bundle/fileline')
"call pathogen#interpose('bundle/grep')
"call pathogen#interpose('bundle/matchit')
"call pathogen#interpose('bundle/nerdtree')
"call pathogen#interpose('bundle/snipmate')
"call pathogen#interpose('bundle/svn')
"call pathogen#interpose('bundle/syntastic')
"call pathogen#interpose('bundle/systemverilog')
"call pathogen#interpose('bundle/tabular')
"call pathogen#interpose('bundle/tasklist')
"call pathogen#interpose('bundle/tlib_vim')
"call pathogen#interpose('bundle/vim-addon-mw-utils')
"if &diff
"else
"call pathogen#interpose('bundle/python_mode')   
"endif
call pathogen#helptags()

"command examples
"open all results in tabs (all find results in this case):
":arga `find . -name '*.log'` | tab all


"Enable filetypes
syntax on
filetype plugin indent on

set visualbell              " enable the visual bell 

"Write the old file out when switching between files.
"set autowrite
set noautowrite

set backspace=2 "make backspace work like most other apps

"move btween windows with ctrl
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"Want a different map leader than \
"set mapleader = ",";

"Ever notice a slight lag after typing the leader key + command? This lowers
"the timeout.
"set timeoutlen=500

"Display current cursor position in lower right corner.
"set ruler
"
"add to taswk list
map <leader>td <Plug>TaskList

"revision history tool - not installed
"map <leader>g :GundoToggle<CR>

"replaces grep - not installed
"nmap <leader>a <Esc>:Ack!

"pyflakes - removed, now it's a part of python-mode
"let g:pyflakes_use_quickfix = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


function! CnLint()
  compiler cn_lint
  execute 'make!'
  echo "Press any key to continue..."
  execute 'cwindow'
endfunction

function! LlmAsk(...)
  let l:args = join(a:000, ' ')
  let g:captured_args = l:args
  "echo "captured args" . g:captured_args
  compiler llm_ask
  make!
  "echo "Press any key to continue..."
  execute 'copen'
endfunction




function! ChooseCommand()
  let l:command = input("Choose command (and hit Enter):\n\t1 = cn_lint\n\t2 = llm\n")
  echo "\n"
  if l:command == "1"
    call CnLint()
  elseif l:command == "2"
    let l:llm_ask = input("type your llm question, and hit enter:\n")
    echo "\n"
    call LlmAsk(l:llm_ask)
  else
    echo "Invalid command choice"
  endif
endfunction





"for python activate supertab completion - need to move to filetype detect file
let g:pymode_rope = 0
let g:pymode = 0
let g:pymode_lint = 0
let g:pymode_syntax = 0
let g:pymode_run = 0
" this was old stuff from before python mode
let g:pymode_lint_unmodified = 0
let g:pymode_lint_signs = 0
let g:pymode_lint_on_write = 0
" disable python code check
let g:pymode_lint = 0
" Show error message if cursor placed at the error line
let g:pymode_lint_message = 0
" default code checkers
let g:pymode_lint_checkers = ['']
"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"
"set completeopt=menuone,longest,preview
let g:pymode_rope_lookup_project = 0 "fix a bug in python mode
let g:pymode_rope_complete_on_dot = 0 "turn off auto-completion when pressing period button
"for pymode plugin - remove red end of line 
"let g:pymode_options_max_line_length = 0
let g:pymode_options_colorcolumn = 0
"Turn on code completion support in the plugin
"let g:pymode_rope_completion = 0
"Turn on the rope script
"let g:pymode_rope = 0
"Skip errors and warnings
"E.g. "E501,W002", "E2,W" (Skip all Warnings and Errors that starts with E2) and etc
"let g:pymode_lint_ignore = "E501,W"
let g:pymode_lint_ignore = "E501"   "skip 'too long' warning

hi Cursor guifg=Black guibg=green
hi Cursorline term=none cterm=none ctermbg=Green guibg=darkred
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

""Set the color scheme. Change this to your preference.
""Here's 100 to choose from: http://www.vim.org/scripts/script.php?script_id=625
"colorscheme torte
"Set font type and size. Depends on the resolution. Larger screens, prefer h20
"set guifont=LucidaTypewriter\ \9
if !has('win32')
   set guifont=Monospace\ \10
   nmap <silent> + :let &guifont=substitute(&guifont, '\(\d\+\)', '\=submatch(1) + 1', '')<CR>
   nmap <silent> _ :let &guifont=substitute(&guifont, '\(\d\+\)', '\=(submatch(1) - 1)', '')<CR>
endif

"Taglist - not installed
"let Tlist_Ctags_Cmd="C:/\ctags58/\ctags.exe"
"Tagbar
"let g:tagbar_ctags_bin = "C:/ctags58/ctags.exe"
if has('win32')
   let g:tagbar_ctags_bin = '$HOME/vimfiles/bin/ctags.exe'
else
   "let g:tagbar_ctags_bin = '$HOME/bin/ctags_install/bin/ctags'
   let g:tagbar_ctags_bin = 'usr/bin/ctags'
endif

""Tab stuff http://vimcasts.org/episodes/tabs-and-spaces/
set tabstop=3 "the width of the tab character (in spaces)
set shiftwidth=3 "shiftwidth == softtabstop so i can work with spaces and not tabs
set softtabstop=3 "how many white spaces to insert when tabbing
set expandtab "transform tabs to spaces"
""set smarttab "inset tabs at start of line and spaces at middle


"following seeting are controlled by external plugin so I disabled them here.
"set shortmess=xotI "shorten messages so you dont have to press enter, but i don't use this for now.
"set showcmd "Show command in bottom right portion of the screen
set showmatch "When a bracket is inserted briefly jump to the matching one

""Indent stuff - needs to be controlled for each filetype seperatlly
"set smartindent "this one tries to guess the indent, but it's bad in most cases
set autoindent "this one is simpler, just takes the indent from the last line, but if I have a special indent file for some filetype, it will overwrite this.
"
"set whichwrap=bshl<>[]      "select which keys can wrap lines, I disabled it here, but it looks like it's activated somewhere else.
"
"set laststatus=2 "Always show the status line - done by plugin, but maybe I need it because sometimes the statusline dissapears
"
""Prefer a slightly higher line height - that's the gap between lines
set linespace=3

"
""Better line wrapping
set wrap
"" Make shift-W toggle between wrap and unwrap longlines
map <S-W>  :set wrap! <CR>
"
"" Allow virtual edit, place cursor wherever you want
"" set ve=all
set ve=block
"
" set the maximum line size (longer than that will be broken to 2 lines) set
" by plugin but quite anoying.
""set textwidth=79
"set textwidth=0 "unlimited
"
" this make some big changes, not everyone will like it.
""set formatoptions=qrnl1
"
""Set incremental searching"
set incsearch
"
""Highlight searching
set hlsearch
"
"" case insensitive search
set ignorecase
set smartcase
"

" align all to ending ,
map <S-T> :Tabularize /[a-z_A-Z0-9]*,/l1


"Enable code folding - let's let the plugin control that
"set foldenable
"set foldmethod=indent
"set foldlevel=99

""Hide mouse when typing - can be anoying because you have to move the mouse
"to see where it is.
"set mousehide
"
""Shortcut to fold tags with leader (usually \) + ft - don't know what that is.
""nnoremap <leader>ft Vatzf
"
"" Create dictionary for custom expansions FIXME useful for UVM, but UVM has
"" it's own plugins so leave it disabled for now
"set dictionary+=/store/public/Temp/uvm_dict.txt
"
""Opens a vertical split and switches over (\v)
nnoremap <leader>v <C-w>v<C-w>l
"
"very usefull for the anoying dos/unix files - force to dos mode.
map <leader>dos :e ++ff=dos<CR>
map <leader>unix :e ++ff=unix<CR>
"the next one actually changes the file. save and check in after you do that
"for permanent fix.
map <leader>dos2unix :%s/\r\(\n\)/\1/g<CR>
"
""Split windows below the current window. - I like this better
set splitbelow
set splitright
"
"" session settings for mksession, the defaults are good enough
""set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,help
"
""Set up an HTML5 template for all new .html files FIXME for system verilog
""autocmd BufNewFile * silent! 0r $VIMHOME/templates/%:e.tpl

"Shortcut for editing  vimrc file in a new tab - this is one of the most
"usefull things in the world!
nmap <leader>ev :tabedit $MYVIMRC<cr>

""Saves time; maps the spacebar to colon
""nmap <space> :
"" Make Space bar enter insert mode - I'm just used to that, sorry.
map <Space> <Insert>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
"
"Automatically change current directory to that of the file in the buffer
"vim actually has a native function for this 'autochdir' but this is better
autocmd BufEnter * cd %:p:h
"
""Map code completion to , + tab TODO might be use
""imap <leader><tab> <C-x><C-o>
"
""Auto-completion menu for command line - behave like bash
set wildmode=list:longest
"" More useful command-line completion
set wildmenu
"" wildchar key that triggers command-line expansion
"set wildchar=<Tab>
"
"" Set showmode (show the mode in the bottom - visual/insert etc.) - done by plugin
"set smd
"
"" Make complete look in dictionary - makes it slower, I don't think it's good
"set cpt=.,k,b,t,i
"
"" Show full tag of completion
set sft
"
"" number of screen lines to show around the cursor
set so=5
"
" supposed to make it full screen, but I never saw it working well
"if has("gui_running")
"  " GUI is running or is about to start.
"  " Maximize gvim window.
"  set lines=999 columns=999
"endif
"
"" Make history buffer larger default 20
set hi=100
"
"if !has('win32')
"   "" Make shell commands work faster
"   set shell=csh\ -f
"endif
"
"" suffixesadd - used when searching for a file with gf
set suffixesadd=.v,.py,.sv,.c,.cpp,.h,.svh
"
"path - This is a list of directories which will be searched when using gf
"add spv include and uvm include
"set path=.,,./**,../**
set path=.
"
"be xterm
"
"" Make block mode work in insert mode
map! <C-V> <Esc><C-V>
"
"
""http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
""set completeopt=longest,menuone
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
"nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>
"
""Bubble single lines (kicks butt)
""http://vimcasts.org/episodes/bubbling-text/
"nmap <C-Up> ddkP
"nmap <C-Down> ddp
"
""Bubble multiple lines
"vmap <C-Up> xkP`[V`]
"vmap <C-Down> xp`[V`]
"
" Source the vimrc file after saving it. This way, you don't have to reload Vim to see the changes.
if has("autocmd")
 augroup myvimrchooks
  au!
  if has('win32')
     autocmd bufwritepost vimrc source $HOME/vimfiles/vimrc
  elseif has('unix')
     autocmd bufwritepost vimrc source $HOME/.vim/vimrc
  endif
 augroup END
endif
"
"" easier window navigation
""nmap <C-h> <C-w>h
""nmap <C-j> <C-w>j
""nmap <C-k> <C-w>k
""nmap <C-l> <C-w>l
"allows to navigate open windows using the - ALT + arrow keys
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>


let view_name = system("basename $CLEARCASE_ROOT")
if view_name =~ "droginsk_himalaya_wmss_14rf_2.0"
   let g:ctrlp_cmd='CtrlP /vobs/cores/modemss/himalaya_wmss'
elseif  view_name =~ "droginsk_streamer_dtr_14rf_1.0"
   let g:ctrlp_cmd='CtrlP /vobs/cores/modemss/streamer_wmss/dtr'
elseif  view_name =~ "droginsk_magnus_wmss_14lpp_1.0"
   let g:ctrlp_cmd='CtrlP /vobs/cores/modemss/magnus_wmss/wmss/'
endif

"ctrlp path example
"let g:ctrlp_root_markers = ['/vobs/cores/modemss/streamer_wmss/dtr']
"let g:ctrlp_root_markers = ['/vobs/cores/modemss/streamer_wmss/dtr/sub/sc_common/sub/dan_dfe/sub/phy_fe_logger']
"let g:ctrlp_user_command = 'find %s -type f | grep -v -P "\.jpg$|/tmp/"'
"let g:ctrlp_user_command = "find %s -type f | egrep -v '/\.(git|hg|svn)|solr|tmp/' | egrep -v '\.(png|exe|jpg|gif|jar|class|swp|swo|log|gitkep|keepme|so|o)$'"
"Keep caches between sessions - f5 to refresh
let g:ctrlp_clear_cache_on_exit = 0
""
let g:ctrlp_working_path_mode = '' 
"
""Spelling corrects. Just for example. Add yours below.
"iab teh the
"iab Teh The
"
"" Get to home dir easier
"" <leader>hm is easier to type than :cd ~
"nmap <leader>hm :cd ~/ <CR>
"
"" Saves file when Vim window loses focus
""au FocusLost * :wa
"
"" Backups
if has('win32')
   set backupdir=$HOME/backup " backups
elseif has('unix')
   set backupdir=$HOME/.backup " backups
endif
""set directory=~/.vim/tmp/swap// " swap files
set noswapfile
set backup " enable backup
"set nobackup
"
"
"If you exit Vim and later start it again, you would normally lose a lot of
"information.  The viminfo file can be used to remember that information, which
"enables you to continue where you left off.
"set viminfo='100,\"50,:200  " read /write a .viminfo file, don't store more than 50 lines of registers
"
"" Use popup menu for right mouse button and keep shift-left mouse button as search
set mousemodel=popup
map <S-LeftMouse> <LeftMouse>*
map! <S-LeftMouse> <Esc><LeftMouse>*
"
""Added by orenc
""Make sure that <EOL> is displayed as ^M when file type is "MS-DOS" or "Mac"
"set ffs=unix
"
"" confirm start a dialog when a command fails
set cf
"
""TODO what is ttym what is sel (selection)
"
"" equalalways	make all windows the same size when adding/removing windows
"set noea
"
autocmd! BufNewFile *.py call InsertPythonPackage() 

"TODO change name
function! InsertPythonPackage() 
    let dir = getcwd() 
    
    let result = append(0,"#!/usr/bin/python")
    let result = append(1, "'''")     
    let result = append(2, "-------------------------------------------------------------------------") 
    let filename = expand("%") 
    let result = append(3, "File name    : " . filename ) 
    let result = append(4, "Title        : ") 
    let result = append(5, "Project      : ") 
    let username = expand("$USER") 
    let result = append(6, "Developers   :  " . username) 
    let date = strftime("%a %b %d, %Y  %I:%M%p")
    if has('win32')
       let result = append(7, "Created      : ") 
    elseif has('unix')
       let result = append(7, "Created      : " . date) 
    endif
    let result = append(8, "Description  : ") 
    let result = append(9, "Notes        : ") 
    let result = append(10, "---------------------------------------------------------------------------") 
    let result = append(11, "Copyright ") 
    let result = append(12, "---------------------------------------------------------------------------*/")
    let result = append(13, "'''")     
  
endfunction

autocmd! BufNewFile *.v,*.sv,*.svh,*.c,*.cpp,*.h call InsertVerilogPackage()

"TODO change name
function! InsertVerilogPackage() 
    let filename = expand("%") 
    let date = strftime("%a %b %d, %Y  %I:%M%p")
	 let result = append(0, "// -------------------------------------------------------------------------")
	 let result = append(1, "// File name		: " . filename . " ")
	 let result = append(2, "// Title				: ")
	 let result = append(3, "// Project      	: ")
	 let username = expand("$USER") 
	 let result = append(4, "// Developers   	: " . username . " ")
	 let result = append(5, "// Created      	: " . date . " ")
	 let result = append(6, "// Last modified  : ")
	 let result = append(7, "// Description  	: ")
	 let result = append(8, "// Notes        	: ")
	 let result = append(9, "// Version			: 0.1")
	 let result = append(10, "// ---------------------------------------------------------------------------")
	 let result = append(11, "// Copyright ")
	 let result = append(12, "// Confidential Proprietary ")
	 let result = append(13, "// ---------------------------------------------------------------------------")
endfunction
"
"
"" map the [ ] keys
"" go to start/end of next line
"map [ 0<NL> 
"map ] $<NL>
"
"" save and suspend
map Z :w<NL>
"
"
"
"Menu items for Commenting and Un-Commenting code 
amenu 20.435 &Edit.-SEP4- : 
amenu Edit.Comment <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call Comment(fl, ll)<CR> 
amenu Edit.UnComment <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call UnComment(fl, ll)<CR>
"" Insert # comments
vmap <F2>  <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call Comment(fl, ll)<CR> 
vmap <S-F2> <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call UnComment(fl, ll)<CR>
"autocmd BufEnter *.c,*.h,*.cpp,*.v,*.vh,*.sv,*.svi,*.svh vmap <F2>  <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call Comment(fl, ll)<CR>
"autocmd BufEnter *.c,*.h,*.cpp,*.v,*.vh,*.sv,*.svi,*.svh vmap <S-F2> <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call UnComment(fl, ll)<CR>
"autocmd BufEnter *.vim,*.vmap <F2>  <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call CommentVim(fl, ll)<CR>
"autocmd BufEnter *.vim,*.vmap <S-F2> <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call UnCommentVim(fl, ll)<CR>
"autocmd BufEnter *.py,*.sh,*.mk,*.tcl vmap <F2>  <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call Commentpy(fl, ll)<CR>
"autocmd BufEnter *.py,*.sh,*.mk,*.tcl vmap <S-F2> <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call UnCommentpy(fl, ll)<CR>

autocmd FileType python,sh,make vmap <F2>  <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call Commentpy(fl, ll)<CR>
autocmd FileType python,sh,make vmap <S-F2> <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call UnCommentpy(fl, ll)<CR>
autocmd FileType vim vmap <F2>  <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call CommentVim(fl, ll)<CR>
autocmd FileType vim vmap <S-F2> <ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call UnCommentVim(fl, ll)<CR>
"
"Function for commenting a block of Visually selected text 
function! Comment(fl, ll) 
    let i=a:fl 
let comment="//" 
while i<=a:ll 
    let cl=getline(i) 
let cl2=comment.cl 
call setline(i, cl2) 
let i=i+1 
endwhile 
endfunction 

"Function for Un-Commenting a block of Visually selected text 
function! UnComment(fl, ll) 
    let i=a:fl 
let comment="//" 
while i<=a:ll 
    let cl=getline(i) 
let cl2=substitute(cl, "//", "", "") 
call setline(i, cl2) 
let i=i+1 
endwhile 
endfunction 
"
"-------------------------------------------------------------------
"Function for commenting a block of Visually selected text 
function! Commentpy(fl, ll) 
    let i=a:fl 
let comment="#" 
while i<=a:ll 
    let cl=getline(i) 
let cl2=comment.cl 
call setline(i, cl2) 
let i=i+1 
endwhile 
endfunction 

"Function for Un-Commenting a block of Visually selected text 
function! UnCommentpy(fl, ll) 
    let i=a:fl 
let comment="#" 
while i<=a:ll 
    let cl=getline(i) 
let cl2=substitute(cl, "#", "", "") 
call setline(i, cl2) 
let i=i+1 
endwhile 
endfunction 
"-------------------------------------------------------------------
"Function for commenting a block of Visually selected text 
function! CommentVim(fl, ll) 
    let i=a:fl 
let comment="\"" 
while i<=a:ll 
    let cl=getline(i) 
let cl2=comment.cl 
call setline(i, cl2) 
let i=i+1 
endwhile 
endfunction 

"Function for Un-Commenting a block of Visually selected text 
function! UnCommentVim(fl, ll) 
    let i=a:fl 
let comment="\"" 
while i<=a:ll 
    let cl=getline(i) 
let cl2=substitute(cl, "\"", "", "") 
call setline(i, cl2) 
let i=i+1 
endwhile 
endfunction 
"
"
"map <F10> :co .<NL>:s/[!-~]/-/g<NL>:s/- -/---/g<NL>:s/-  -/----/g<NL><ESC>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call Comment(fl, ll)<CR>
"map <F10> :co .<CR>:s/[!-~]/-/g<CR>:s/- -/---/g<CR>I#<esc>
map <F10> :co .<CR><S-V>r-<esc>v<F2>yykP
"
"" Useful abbreviations
"iab DR Dima Roginsky
"
""TODO move to global file
"au BufReadPost *.vsif so ~/bin/vsif.vim
""au BufReadPost *.sv so ~/.vim/syntax/systemverilog.vim
let g:verilog_syntax_fold = "all"
set foldmethod=syntax
nnoremap <leader>i :VerilogFollowInstance<CR>
nnoremap <leader>I :VerilogFollowPort<CR>
nnoremap <leader>u :VerilogGotoInstanceStart<CR>

"
"" maximum of 20 tabs opened with -p
set tabpagemax=12
"
""guioptions	list of flags that specify how the GUI works
set go+=acegmiLTrtb
set guitablabel=%t
"
""svn 
"map <S-F11> :!svn lock %<CR>
"map <S-F12> :!svn ci % -m "Fixed a Bug"<CR>
map <S-F11> :!ct co -nc %<CR>
map <S-F12> :!ct ci %<CR>
map <F12> :tabnew 
map <F11> :close <CR>
map <F9>  :MyGrep 
imap <F9> <ESC>:MyGrep 
map <S-F9> :MyGrep "<cword>" .<CR>
vmap <S-F9> :MyGrep "<cword>" .<CR>
imap <S-F9> <ESC>:MyGrep "<cword>" .<CR>
"Add grep abbilty to gvim
function! MyGrep(...)
  if a:0 < 2
    echo "Usage: MyGrep <options> <pattern> <dir>"
    echo 'Example: MyGrep -r "cow" ~/Desktop/*'
    return
  endif
  if a:0 == 2
    let options = '-rsinI'
    let pattern = a:1
    let dir = a:2
  else
    let options = a:1 . 'snI'
    let pattern = a:2
    let dir = a:3
  endif
  let exclude = 'grep -v "/.svn"'
  let cmd = 'grep '.options.' '.pattern.' '.dir. '| '.exclude
  let cmd_output = system(cmd)
  if cmd_output == ""
    echomsg "Pattern " . pattern . " not found"
    return
  endif

  let tmpfile = tempname()
  exe "redir! > " . tmpfile
  silent echon '[grep search for "'.pattern.'" with options "'.options.'"]'."\n"
  silent echon cmd_output
  redir END

  let old_efm = &efm
  set efm=%f:%\\s%#%l:%m

  execute "silent! cgetfile " . tmpfile
  let &efm = old_efm
  botright copen

  call delete(tmpfile)
endfunction

command! -nargs=* -complete=file MyGrep call MyGrep(<f-args>)

"FIXME work with session as project
"nmap <F3> <ESC>:call LoadSession()<CR> 
"let s:sessionloaded = 0 
"function! LoadSession() 
"    setlocal modifiable
"    source session.vim 
"    let s:sessionloaded = 1 
"endfunction 
""function! SaveSession() 
""    if s:sessionloaded == 1 
""        mksession! 
""    end 
""endfunction 
""autocmd VimLeave * call SaveSession() 
"
"let g:pydiction_location = '~/.vim/vimfiles/complete-dict'
"
""TODO add abrivations
"set tags=~\tags
"" Display function name in status bar:
"let g:ctags_statusline=1
"" Automatically start script
"let generate_tags=1
"" Displays taglist results in a vertical window:
"let Tlist_Use_Horiz_Window=0
"" Shorter commands to toggle Taglist display
"nnoremap TT :TlistToggle<CR>
map <F4> :Tagbar<CR>
"" Various Taglist diplay config:
"let Tlist_Use_Right_Window = 1
"let Tlist_Compact_Format = 0
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_GainFocus_On_ToggleOpen = 0
"let Tlist_File_Fold_Auto_Close = 1
"
"au BufWritePost *.py !pyflakes %
"
"" How to behave in Diff mode TODO check if better options
"if &diff
"    set co=171
"    set equalalways
"    "Option settings for diff mode (diffopt - dip):
"    " filler    - Show filler lines
"    " Context   - lines between a change and a fold
"    " icase     - Ignore changes in case of text
"    " iwhite    - Ignore changes in amount of white space
"    set dip=filler,iwhite,icase
"
"endif
"
"done by plugin
"set stl=%1*(%n)\ %2*%F\ %1*%y%w%m%r%=\ \ \ %2*Row=%l\ Col=%c\%V%3*\ %P%*
"
"" Make Shift-Arrow select like in Solaris
"map! <S-C-Left> <Right><Esc>vb<Left><Insert>
"map! <S-C-Right> <Right><Esc>ve<Right><Insert>
"map! <S-Left> <Right><Esc>v<Left><Insert>
"map! <S-Right> <Right><Esc>v<Right><Insert>
map! <S-Up> <Esc>v<Up><Insert>
map! <S-Down> <Esc>v<Down><Insert>
"map <S-C-Left> <Right><Esc>vb<Left>
"map <S-C-Right> <Esc>vw<Right>
"map <S-Left> <Right><Esc>v<Left>
"map <S-Right> <Esc>v<Right>
map <S-Up> <Esc>v<Up>
map <S-Down> <Esc>v<Down>
map <S-Left> <Esc>gT
map <S-Right> <Esc>gt
"
"if has("python")
"function! Doron()
"python << endpython
"import vim
"def doron():
"   (row, col) = vim.current.window.cursor
"   row = row
"   lines = []
"   max_len_line = 0
"   max_len_first = 0
"   max_len_second = 0
"   i = row
"   while True:
"      print i
"      line = vim.current.buffer[i].replace("\t"," ").strip()
"      if line:
"         while "  " in line:
"            line = line.replace("  "," ")
"
"         line = line.split(" ")
"         if len(line) < 2:
"            break
"
"         lines.append(line)
"         if len(line) > max_len_line:
"            max_len_line = len(line)
"
"         if len(line[0]) > max_len_first:
"            max_len_first = len(line[0])
"
"         if len(line) > 2 and len(line[1]) > max_len_second:
"            max_len_second = len(line[1])
"
"         i += 1
"      else:
"         break
"
"   for i in range(len(lines)):
"      white_spaces1 = 1 + max_len_first - len(lines[i][0])
"      white_spaces2 = 1 + max_len_second - len(lines[i][1])
"      print white_spaces1,white_spaces2,max_len_first,max_len_second
"      if max_len_line == 2:      
"         vim.current.buffer[row] = "\t"+lines[i][0]+white_spaces1*" "+lines[i][1]
"      elif max_len_line >= 3:
"         if len(lines[i]) == 3:
"            vim.current.buffer[row] = "\t"+lines[i][0]+white_spaces1*" "+lines[i][1]+white_spaces2*" "+lines[i][2]
"         elif len(lines[i]) == 2:
"            vim.current.buffer[row] = "\t"+lines[i][0]+white_spaces1*" "+(max_len_second+1)*" "+lines[i][1]
"         else:
"            vim.current.buffer[row] = "\t"+lines[i][0]+white_spaces1*" "+lines[i][1]+white_spaces2*" "+lines[i][2]+" ".join(lines[i][3:])
"
"      row += 1
"
"doron()
"endpython
"endfunction
"
"function! CP1()
"python << endpython
"import vim
"def cp1():
"    list_of_vars = []
"    max_var_size = 0    
"    (row, col) = vim.current.window.cursor
"    for i in range(row):
"        line = vim.current.buffer[i].split("//")[0]
"        if "_p1" in line:
"            line = line.replace("\t"," ").split("_p1")
"            for j in range(len(line)-1):
"                var_name = line[j].split(" ")[-1]
"                var_name = var_name.replace("(","").replace("&","").replace("|","").replace("~","").replace("{","")
"                if var_name not in list_of_vars:
"                   range_dec = "not_found"  
"                   for new_scan_i in range(row):
"                      new_scan_line = vim.current.buffer[new_scan_i]
"                      if var_name in new_scan_line and (("input" in new_scan_line) or ("output" in new_scan_line) or ("reg" in new_scan_line) or ("wire" in new_scan_line)):
"                         if "[" in new_scan_line:
"                            range_dec = "["+new_scan_line.split("[")[1].split("]")[0]+"]"
"                         else:
"                            range_dec = ""
"                         break
"                     
"                   if range_dec == "not_found":
"                      print "can't find declaration for ",var_name
"                      return
"
"                   if len(var_name)+len(range_dec) > max_var_size:
"                      max_var_size = len(var_name)+len(range_dec)
"
"                   list_of_vars.append([var_name,range_dec])
"                else:
"                    continue
"        else:
"            continue
"
"    vim.current.buffer.append("\talways @(posedge sclk or negedge sclk_rst_n)")
"    vim.current.buffer.append("\tbegin")
"    vim.current.buffer.append("\t\tif (~sclk_rst_n)")
"    vim.current.buffer.append("\t\tbegin")
"    for var in list_of_vars:
"        white_spaces = max_var_size - len(var[0]) - len(var[1]) + 4
"        vim.current.buffer.append("\t\t\t"+var[0]+"_p1"+var[1]+white_spaces*" "+"<=\t`RDEL 1'b0;")
"
"    vim.current.buffer.append("\t\tend")
"    vim.current.buffer.append("\t\telse")
"    vim.current.buffer.append("\t\tbegin")
"    for var in list_of_vars:
"        white_spaces = max_var_size - len(var[0]) - len(var[1]) + 4
"        vim.current.buffer.append("\t\t\t"+var[0]+"_p1"+var[1]+white_spaces*" "+"<=\t`RDEL "+var[0]+var[1]+";")
"
"    vim.current.buffer.append("\t\tend")
"    vim.current.buffer.append("\tend")
"
"cp1()
"endpython
"endfunction
"
"function! CP2()
"python << endpython
"import vim
"def cp2():
"    list_of_vars = []
"    max_var_size = 0
"    (row, col) = vim.current.window.cursor
"    for i in range(row):
"        line = vim.current.buffer[i].split("//")[0]
"        if "_p2" in line:
"            line = line.replace("\t"," ").split("_p2")
"            for j in range(len(line)-1):
"                var_name = line[j].split(" ")[-1]
"                var_name = var_name.replace("(","").replace("&","").replace("|","").replace("~","").replace("{","")
"                if var_name not in list_of_vars:
"                   range_dec = "not_found"
"                   for new_scan_i in range(row):
"                      new_scan_line = vim.current.buffer[new_scan_i]
"                      if var_name in new_scan_line and (("input" in new_scan_line) or ("output" in new_scan_line) or ("reg" in new_scan_line) or ("wire" in new_scan_line)):
"                         if "[" in new_scan_line:
"                            range_dec = "["+new_scan_line.split("[")[1].split("]")[0]+"]"
"                         else:
"                            range_dec = ""
"                         break
"                     
"                   if range_dec == "not_found":
"                      print "can't find declaration for ",var_name
"                      return
"
"                   if len(var_name)+len(range_dec) > max_var_size:
"                      max_var_size = len(var_name)+len(range_dec)
"
"                   list_of_vars.append([var_name,range_dec])
"                else:
"                   continue
"        else:
"            continue
"
"    vim.current.buffer.append("\talways @(posedge sclk or negedge sclk_rst_n)")
"    vim.current.buffer.append("\tbegin")
"    vim.current.buffer.append("\t\tif (~sclk_rst_n)")
"    vim.current.buffer.append("\t\tbegin")
"    for var in list_of_vars:
"        white_spaces = max_var_size - len(var[0]) - len(var[1]) + 4
"        vim.current.buffer.append("\t\t\t"+var[0]+"_p2"+var[1]+white_spaces*" "+"<=\t`RDEL 1'b0;")
"
"    vim.current.buffer.append("\t\tend")
"    vim.current.buffer.append("\t\telse")
"    vim.current.buffer.append("\t\tbegin")
"    for var in list_of_vars:
"        white_spaces = max_var_size - len(var[0]) - len(var[1]) + 4       
"        vim.current.buffer.append("\t\t\t"+var[0]+"_p2"+var[1]+white_spaces*" "+"<=\t`RDEL "+var[0]+"_p1"+var[1]+";")
"
"    vim.current.buffer.append("\t\tend")
"    vim.current.buffer.append("\tend")
"
"cp2()
"endpython
"endfunction
"endif
if has('win32')
   source $HOME/vimfiles/bundle/matchit/plugin/matchit.vim
elseif has('unix')
   source $HOME/.vim/bundle/matchit/plugin/matchit.vim
endif
if exists('loaded_matchit')
let b:match_ignorecase=0
let b:match_words=
  \ '\<begin\>:\<end\>,' .
  \ '\<if\>:\<else\>,' .
  \ '\<module\>:\<endmodule\>,' .
  \ '\<class\>:\<endclass\>,' .
  \ '\<program\>:\<endprogram\>,' .
  \ '\<clocking\>:\<endclocking\>,' .
  \ '\<property\>:\<endproperty\>,' .
  \ '\<sequence\>:\<endsequence\>,' .
  \ '\<package\>:\<endpackage\>,' .
  \ '\<covergroup\>:\<endgroup\>,' .
  \ '\<primitive\>:\<endprimitive\>,' .
  \ '\<specify\>:\<endspecify\>,' .
  \ '\<generate\>:\<endgenerate\>,' .
  \ '\<interface\>:\<endinterface\>,' .
  \ '\<function\>:\<endfunction\>,' .
  \ '\<task\>:\<endtask\>,' .
  \ '\<case\>\|\<casex\>\|\<casez\>:\<endcase\>,' .
  \ '\<fork\>:\<join\>\|\<join_any\>\|\<join_none\>,' .
  \ '`ifdef\>:`else\>:`endif\>,'
endif

"autocmd BufRead,BufNewFile *.v,*.vh setfiletype verilog
"autocmd BufRead,BufNewFile *.v,*.vh set expandtab tabstop=4 softtabstop=2 shiftwidth=2
"autocmd BufRead,BufNewFile *.sv,*.svi set filetype=verilog_systemverilog
"autocmd BufRead,BufNewFile *.sv,*.svi set expandtab tabstop=4 softtabstop=2 shiftwidth=2

"diff to trunk
set listchars=eol:$,tab:\>\ ,trail:.,extends:>,precedes:<
set nolist   " to turn on (use :set nolist to turn off)
"map <leader>dt :VCSVimDiff<CR>

" Snippets are separated from the engine. Add this if you want them:
"Plugin 'bundle/vim-snippets'

"NERD TREE
"Show hidden files in NerdTree
let NERDTreeShowHidden=1
"toggle nerdtree with f6
map  <silent> <F6>   :NERDTreeToggle<CR>
""autopen NERDTree and focus cursor in new document
""autocmd VimEnter * NERDTree
""autocmd VimEnter * wincmd p

"syntastic syntax helper
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"AirLine plugin
set laststatus=2 "always show status line
" here is an example of how you could replace the branch indicator with
" the current working directory, followed by the filename.
let g:airline_section_b = "[" . hostname() . ']%{getcwd()}'
let g:airline_section_c = '%t'

set number "Show lines numbers
" need VIM 7.3 (or 7.4) and above for the following numbering settings
set number relativenumber
"set nonumber norelativenumber  " turn hybrid line numbers off
"set !number !relativenumber    " toggle hybrid line numbers
"
highlight LineNr ctermfg=grey ctermbg=black guibg=black guifg=grey

" TAGS. tag support
" =========================================
" tag shortcuts:
" CTRL+] 	Jump to definition
" CTRL+t 	Jump back from definition
" CTRL+W } 	Preview definition
" g] 	See all definitions
"
" re-map goto definition of tag
" in new tab
"map <C-[> :tabnew <CR>:exec("tag ".expand("<cword>"))<CR>
" in vertical split
"map <C-[> :vs <CR>:exec("tag ".expand("<cword>"))<CR>

"set tags=~/tags
  "vim.command("set tags=~/tags_axion")

if has("python")
"autocmd BufReadPost * call SET_TAGS_LOCATION()
autocmd BufEnter * call SET_TAGS_LOCATION()
function! SET_TAGS_LOCATION()
python << endpython
import vim
import os
def set_tags_location():
  pwd = os.getcwd()
  unmanaged =  os.getenv("UNMANAGED_DIR")
  if not unmanaged:
     return
  unmanaged += "/../"
  vim.command("set tags="+unmanaged+"/tags_gvim")
  if "users" in pwd:
    splitted_pwd = pwd.split("/")
    while "users" in splitted_pwd[:-2]:
      workdir_path = "/".join(splitted_pwd)
      workdir_tags = workdir_path+"/tags"
      if os.path.exists(workdir_tags):
        vim.command("set tags="+workdir_tags)
        break
      else:
        splitted_pwd = splitted_pwd[:-1]

set_tags_location()
endpython
endfunction
" =========================================

autocmd BufEnter * call SET_WS()
function! SET_WS()
python << endpython
import vim
import os
def set_ws():
  if os.getenv("WS"):
     return

  pwd = os.getcwd()
  if "users" in pwd:
    splitted_pwd = pwd.split("/")
    while "users" in splitted_pwd[:-2]:
      workdir_path = "/".join(splitted_pwd)
      workdir_params = workdir_path+"/.params"
      if os.path.exists(workdir_params):
        os.environ["WS"] = workdir_path
        break
      else:
        splitted_pwd = splitted_pwd[:-1]

set_ws()
endpython
endfunction

function! Pydiff()
python << endpython
import vim
import os
def PyDiff():
	file1 = vim.buffers[1].name
	file2 = vim.buffers[2].name
	result = os.popen("~dorong/scripts/largediff.py "+file1+" "+file2)
	for line in result:
		print line

PyDiff()
endpython
endfunction

function! MyPwd()
python << endpython
   import os
   def MyPwd(file):
      print os.path.abspath(file)

   MyPwd("%")
endpython
endfunction
endif

function! ElogSettings()
   "colorscheme evening
   hi Cursorline term=none cterm=none ctermbg=Green guibg=darkred
   hi statusline guibg=darkred
   augroup CursorLine
      au!
      au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
      au WinLeave * setlocal nocursorline
   augroup END
	syn match ERROR "UVM_ERROR*"
	syn match comp_err "Error"
	syn match comp_warn "Warning"
	syn match FAILED "FAILED*"
	syn match failed "failed*"
	syn match warning "WARNING"
	syn match info "UVM_INFO"
	syn match passed "passed*"
	syn match PASSED "PASSED*"
	syn match match "ITEM MATCH"
   syn match miss "MISSMATCH"
	syn match TstLog "Test_Log"
	hi def msg guibg=Black guifg=Black
	hi ERROR 	gui=bold guibg=Red guifg=Black
	hi comp_err gui=bold guibg=Red guifg=Black
	hi comp_warn gui=bold guibg=Brown guifg=Black
	hi FAILED 	gui=bold guibg=Red guifg=Black
	hi failed 	gui=bold guibg=Red guifg=Black
	hi warning 	gui=bold guibg=Orange guifg=White
	hi info 	   gui=bold guibg=Gray guifg=Red
	hi PASSED 	gui=bold guibg=Green guifg=Black
	hi passed 	gui=bold guibg=Green guifg=Black
	hi match 	gui=bold guibg=Green guifg=Blue
   hi miss     gui=bold guifg=Red
	hi TstLog  	gui=bold guibg=Blue guifg=Green
endfunction
autocmd BufRead *.log :call ElogSettings()

vmap <C-S> e <ESC> /<C-R>*<CR>

let  g:C_UseTool_cmake    = 'yes' 
let  g:C_UseTool_doxygen = 'yes'

"make vim detect filenames with : so it can open the line and columb
set isfname+=:
set isfname+=,
"make vim detect filenames with {} so it can open a filename with env var ${WS}
set isfname+={,}

"autocmd BufReadPost *.log silent %s!,!:!g
"autocmd BufReadPost *.log silent %s!|!:!g
"autocmd BufReadPost *.log :0
"autocmd BufReadPost *.log :/\*E

"let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
let &titlestring = "%t"
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
if &term == "screen" || &term == "xterm"
  set title
endif

" disable emacsauto complete
"let g:loaded_verilog_emacsauto = 1

"clang flags
" disable clang:
call pathogen#is_disabled('bundle/clang_complete/plugin/clang_complete.vim')   
let g:clang_complete_copen = 1
let g:clang_auto_select = 2
"let g:clang_jumpto_declaration_key = '<C-.>'
"let g:clang_jumpto_back_key = '<C-,>'
"to ebnable clang, need to install it instead of the following path
"let g:clang_library_path ="/home/dorong/bin/clang/lib"
if has('win32')
   let g:clang_complete_loaded = 1
endif
"
" not to use tags
set complete-=t

"search for visualy selected text
vnoremap // y/<C-R>"<CR>


" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

"let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat
"let &errorformat="Warning-%t%* %m" . &errorformat

" Definitions for errorformat
" {{{
function! VerilogErrorFormat(...)
  " Choose tool
" if (a:0 == 0)
"   let l:tool = inputlist([
"         \"1. VCS",
"         \"2. Modelsim",
"         \"3. iverilog",
"         \"4. cver",
"         \"5. Leda",
"         \])
"   echo "\n"
"   if (l:tool == 1)
"     let l:tool = "vcs"
"   elseif (l:tool == 2)
"     let l:tool = "msim"
"   elseif (l:tool == 3)
"     let l:tool = "iverilog"
"   elseif (l:tool == 4)
"     let l:tool = "cver"
"   elseif (l:tool == 5)
"     let l:tool = "leda"
"   else
"     let l:tool = "iverilog"
"   endif
" else
"   let l:tool = "vcs"
" endif
"
" " Choose error level
" if (a:0 <= 1)
"   if (l:tool == "vcs")
"     let l:mode = inputlist([
"           \"1. check all",
"           \"2. ignore lint",
"           \"3. ignore lint and warnings"
"           \])
"     echo "\n"
"   elseif (
"     \ l:tool == "msim" ||
"     \ l:tool == "cver"
"     \ )
"     let l:mode = inputlist([
"           \"1. check all",
"           \"2. ignore warnings"
"           \])
"     echo "\n"
"   endif
" else
"   let l_mode = 1
" endif
  let l:tool = "vcs"
  let l:mode = 1

  if (l:tool == "vcs")
    " Error messages
    set errorformat=%E%trror-\[%.%\\+\]\ %m
    set errorformat+=%C%.%#line\ %l\ of\ file%.%#
    set errorformat+=%C%m\"%f\"\\,\ %l%.%#
    set errorformat+=%C%f\\,\ %l
    set errorformat+=%C\ \ \"%f\"%.%#
    set errorformat+=%C%\\s%\\+%l:\ %m
    set errorformat+=%C%m\"%f\"\\,%.%#
    set errorformat+=%Z%p^                      "Column pointer
    set errorformat+=%C%m                       "Catch all rule
    set errorformat+=%Z%m                       "Finalization messages
    set errorformat+=%-IParsing\ %m
    set errorformat+=%-IBack\ to\ file\ '%f'%m
    "set errorformat+=%C\ \ \"%f\",
    "set errorformat+=%C\ \ %l%.%#                       "Catch all rule
    " Warning messages
    if (l:mode <= 2)
      set errorformat+=%W%tarning-\[%.%\\+]\\$
      set errorformat+=%-W%tarning-[LCA_FEATURES_ENABLED]\ Usage\ warning    "Ignore LCA enabled warning
      set errorformat+=%W%tarning-\[%.%\\+\]\ %m
    endif
    " Lint message
    if (l:mode <= 1)
      set errorformat+=%I%tint-\[%.%\\+\]\ %m
      set errorformat+=%I%tote-\[%.%\\+\]\ %m
      "set errorformat+=%IIgnored\ %m
      "set errorformat+=%C\"%f\",
    endif
    echo "Selected VCS errorformat"
    "TODO Add support for:
    "Error-[SE] Syntax error
    "  Following verilog source has syntax error :
    "  "../../rtl_v/anadigintf/anasoftramp.v", 128: token is 'else'
    "          else
  endif
" if (l:tool == "msim")
"   " Error messages
"   set errorformat=\*\*\ Error:\ %f(%l):\ %m
"   " Warning messages
"   if (l:mode <= 1)
"     set errorformat+=\*\*\ Warning:\ \[\%n\]\ %f(%l):\ %m
"   endif
"   echo "Selected Modelsim errorformat"
" endif
" if (l:tool == "iverilog")
"   set errorformat=%f:%l:\ %m
"   echo "Selected iverilog errorformat"
" endif
" if (l:tool == "cver")
"   " Error messages
"   set errorformat=\*\*%f(%l)\ ERROR\*\*\ \[%n\]\ %m
"   " Warning messages
"   if (l:mode <= 1)
"     set errorformat+=\*\*%f(%l)\ WARN\*\*\ \[%n\]\ %m,\*\*\ WARN\*\*\ \[\%n\]\ %m
"   endif
"   echo "Selected cver errorformat"
" endif
" if (l:tool == "leda")
"   " Simple errorformat:
"   set errorformat=%f:%l:\ %.%#\[%t%.%#\]\ %m
"   "TODO Review -> Multiple line errorformat:
"   "set errorformat=%A\ %#%l:%.%#,%C\ \ \ \ \ \ \ \ %p^^%#,%Z%f:%l:\ %.%#[%t%.%#]\ %m
"   echo "Selected Leda errorformat"
" endif
endfunction
" }}}
map <F5> :call VerilogErrorFormat()<CR>:cfile %<CR>:cw<CR>

"----------
" CSCOPE "
"----------
"if has('win32')
"   let g:cscope_cmd = "U:/vimfiles/bin/cscope.exe"
"else
"   let g:cscope_cmd = '$HOME/.vim/bin/cscope.exe'
"endif
let g:cscope_interested_files = '\.c$\|\.cpp$\|\.h$\|\.hpp'

nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>


if filereadable(glob("$HOME/myvimrc")) 
    source $HOME/myvimrc
endif
autocmd! BufNewFile *.py call InsertPythonPackage() 


"emacs auto emacsauto usage example:
"runmod emacs -q -batch --eval "(setq vc-handled-backends 'nil)" -l emacs-site-lisp/site-start.el -l emacs-site-lisp/verilog-mode.el <file.v> -f verilog-batch-auto
