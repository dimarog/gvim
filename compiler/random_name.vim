" cn_lint.vim example : 
" Vim compiler file


if exists("current_compiler")
  finish
endif
let current_compiler = "cn_lint"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=$HOME/.vim/compiler/cn_lint.sh\ %

" the filter turns (hopefully) all messages into the following form:
"%E- buffer.v:138:syntax error, unexpected logic, expecting ',' or ';'
CompilerSet errorformat =%%%t-\ %f:%l:%m

"catch other messages, such as info
"CompilerSet errorformat+=%%%t-\ %m

"ignore everything else
CompilerSet errorformat+=%-G%.%#

" llm_ask.vim example

" Vim compiler file


if exists("current_compiler")
  finish
endif
let current_compiler = "llm_ask"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
 

"CompilerSet makeprg=$HOME/.vim/compiler/llm_ask.sh\ %\ expand(g:captured_args)
execute 'CompilerSet makeprg=$HOME/.vim/compiler/llm_ask.sh\ %\ ' . escape(g:captured_args, ' \')
"
CompilerSet errorformat+=%f:%l:%m
"
