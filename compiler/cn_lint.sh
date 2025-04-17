#! /bin/csh -f

rir -q -- cn_lint $1 |& rir -q -- ~/.vim/compiler/cn_lint_filter.pl
