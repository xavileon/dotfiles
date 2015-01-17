#!/bin/bash
#
# Nick Sieger's Bash Prompt (trimmed)

short_pwd ()
{
    local pwd_length=${PROMPT_LEN-20}
    local cur_pwd=$(echo $(pwd) | sed -e "s,^$HOME,~,")
    if [ $(echo -n $cur_pwd | wc -c | tr -d " ") -gt $pwd_length ]; then
  echo "...$(echo $cur_pwd | sed -e "s/.*\(.\{$pwd_length\}\)/\1/")"
    else
  echo $cur_pwd
    fi
}

prompt()
{
    local cyan='\[\033[1;36m\]'
    local white='\[\033[0;1m\]'
    local red='\[\033[0;31m\]'
    local green='\[\033[0;32m\]'
    local nocolor='\[\033[0m\]'
    
    title

    if [ "$SSH_TTY" -o "$USER" = root ]; then
        # Root or remote system, display host and full path
        PROMPT_COMMAND='__git_ps1 "$white\u@\h:$(short_pwd)" "$cyan > $nocolor"'
    else
        # Skip user@host when on local system; it will be in the title bar
        PROMPT_COMMAND='__git_ps1 "$white$(short_pwd)" "$cyan > $nocolor"'
    fi
}

# Set up environment for git coloring
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true
# Set up $PS1 and $PROMPT_COMMAND
prompt
