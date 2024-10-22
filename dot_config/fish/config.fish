if status is-interactive
  ############
  # Settings #
  ############

  source $HOME/.config/aliases

  set -g fish_greeting ""


  function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_vi_key_bindings --no-erase normal
  end
end
