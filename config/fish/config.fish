if status is-interactive
  ############
  # Settings #
  ############

  source $HOME/.config/aliases

  if test -f ~/.local.fish
    source ~/.local.fish
  end

  set -g fish_greeting ""

  set fish_vi_force_cursor 1
  set fish_cursor_default block
  set fish_cursor_insert line
  set fish_cursor_replace_one underscore
  set fish_cursor_visual block


  function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_vi_key_bindings --no-erase normal

    bind \cr _atuin_search
    bind -M insert \cr _atuin_search
  end
end

# Created by `pipx` on 2025-09-26 16:02:55
set PATH $PATH /Users/theo/.local/bin
