autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_prompt_info () {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    ref=$($git symbolic-ref HEAD 2>/dev/null)
    # not a branch? maybe there's a sha.
    if  [[ ${ref} == "" ]]
    then
      ref=$($git rev-parse HEAD 2>/dev/null) || return
      ref="${ref[1,8]}"
    fi
    if [[ $($git status --porcelain) == "" ]]
    then
      echo " %{$fg_bold[green]%}(${ref#refs/heads/})%{$reset_color%}"
    else
      echo " %{$fg_bold[red]%}(${ref#refs/heads/})%{$reset_color%}"
    fi
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%{$reset_color%}"
}

export PROMPT=$'$(directory_name)$(git_prompt_info): '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
