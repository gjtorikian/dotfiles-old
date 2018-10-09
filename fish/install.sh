#!/bin/sh
config_dir=~/.config
config_file=$config_dir/fish/config.fish
mkdir -p $config_dir

# If this user's login shell is not already "fish", attempt to switch.
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "fish" ]; then
  grep -q -F '/usr/local/bin/fish' /etc/shells || sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
  # If this platform provides a "chsh" command (not Cygwin), do it!
  if hash chsh >/dev/null 2>&1; then
    info "Time to change your default shell to fish!\n"
    chsh -s `which fish`
  # Else, suggest the user do so manually.
  else
    info "I can't change your shell automatically because this system does not have chsh.\n"
    info "Please manually change your default shell to fish!\n"
  fi
fi

if [ ! -f "$config_file" ]; then
  echo "No fish config found. Symlinking to dotfiles"
  ln -s ~/.dotfiles/fish "$config_dir"
fi
