# Via https://git.io/vS5Tk
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showuntrackedfiles 'no'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_color_stagedstate red
set __fish_git_prompt_color_untrackedfiles red
set __fish_git_prompt_color_upstream red
set __fish_git_prompt_color_cleanstate red
set __fish_git_prompt_char_cleanstate '✔'
set __fish_git_prompt_char_dirtystate '𝚫'
set __fish_git_prompt_char_stagedstate '●'
set __fish_git_prompt_char_untrackedfiles '+'
set __fish_git_prompt_char_upstream_behind '⬇ '
set __fish_git_prompt_char_upstream_ahead '⬆ '
set __fish_git_prompt_char_stateseparator ' '

set -U fish_prompt_pwd_dir_length 0

function fish_prompt
  set_color cyan
  printf '%s ' (prompt_pwd)

  if git -C . rev-parse 2>/dev/null
    set_color normal
    printf '| '

    if git status --porcelain ^/dev/null | grep '^.[^ ]' >/dev/null
      set_color red # dirty
    else
      set_color green
    end
      printf '%s ' (__fish_git_prompt '%s')
  end

  set_color cyan
  printf '$ '
  set_color normal
end
