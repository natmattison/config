
# Get's the current git branch
function parse_git_branch
{
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

# Checks to see if there are uncommitted files
function git_status
{
  string=$(git status 2> /dev/null) || return

  if [[ "$string" == *"Changes not staged for commit"* || "$string" == *"untracked files present"* ]]
  then
    echo "*"
  fi
}

# Checks to see if there are files ready to be committed
function git_changes
{
  string=$(git status 2> /dev/null) || return

  if [[ "$string" == *"Changes to be committed"* ]]
  then
    echo "+"
  fi
}

RED='\[\e[0;31m\]'
YELLOW='\[\e[0;33m\]'
CYAN='\[\e[0;36m\]'
WHITE='\[\e[0;37m\]'
GREEN='\[\e[0;32m\]'

source ~/.git-completion.bash
export PS1="\u:\w$RED ➜ $YELLOW\$(parse_git_branch)$RED\$(git_status)$GREEN\$(git_changes)$WHITE$ " 
