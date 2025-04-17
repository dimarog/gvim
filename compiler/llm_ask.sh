#! /bin/csh -f
#/proj/mkit/m1dp3/m1dpcopilot/stable/bin/m1dpcopilot ask "$argv[3-]" --file $1 --format txt |&  ~/.vim/compiler/llm_ask_filter.pl
set copilot_prompt_guidelines = "your answer should be of the following format: [line number in this file]: your resonse. disregard comment lines. response example - '[12]: fifo code' . what i want you to do is : "
#echo "i asked $copilot_prompt_guidelines $argv[2-]"
/proj/mkit/m1dp3/m1dpcopilot/stable/bin/m1dpcopilot ask "$copilot_prompt_guidelines $argv[3-]" --file $1 --format txt |&  ~/.vim/compiler/llm_ask_filter.py $argv
