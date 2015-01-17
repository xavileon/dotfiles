#!/bin/bash
#
# Adapted from
# - Nick Sieger's Bash Prompt (trimmed)
# - http://mediadoneright.com/content/ultimate-git-ps1-bash-prompt
# - Cherry picked from both sources to fit my needs

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

location() {
    # Check if local or remote
    if [ "$SSH_TTY" -o "$USER" = root ]; then
        # Root  or remote system, display host and full path
        echo "$BWhite\u@\h:"
    else
        # Skip user@host when on local system
        echo "$BWhite"
    fi
}

prompt() {
  PS1=$(location)$Color_Off'$(git branch &>/dev/null;\
  if [ $? -eq 0 ]; then \
    echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
    if [ "$?" -eq "0" ]; then \
      # @4 - Clean repository - nothing to commit
      echo "'$Green'"$(__git_ps1 "(%s)"); \
    else \
      # @5 - Changes to working tree
      echo "'$IRed'"$(__git_ps1 "{%s}"); \
      fi) '$BYellow\${shortPWD}$Color_Off'\$ "; \
  else \
    # @2 - Prompt when not in GIT repo
    echo " '$Yellow\${shortPWD}$Color_Off'\$ "; \
  fi)'
}

_prompt_command() {
    shortPWD=$(short_pwd)
}

prompt
export PROMPT_COMMAND=_prompt_command
