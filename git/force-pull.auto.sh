function force-pull() {
  branch=$(command git rev-parse --abbrev-ref HEAD 2> /dev/null)
  cmd="git reset --hard origin/$branch"
  eval $cmd
}
