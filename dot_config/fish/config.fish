if status is-interactive
  ############
  # Settings #
  ############

  source $HOME/.config/aliases

  set -g fish_greeting ""

  set fish_vi_force_cursor 1
  set fish_cursor_default block
  set fish_cursor_insert line
  set fish_cursor_replace_one underscore
  set fish_cursor_visual block


  function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_vi_key_bindings --no-erase normal
  end
end
