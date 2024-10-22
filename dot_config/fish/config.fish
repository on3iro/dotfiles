if status is-interactive
  ############
  # Settings #
  ############

  source $HOME/.config/aliases

  set -g fish_greeting ""

  # todo fix this and extract into its own module
  function nt
    set name (math "$argv[1]" == "" ? "note" : "$argv[1]")  # Use conditional expression to set a default value
    set file (touty -t ~/Nextcloud/Notes/inbox -n "$name")  # Capture the output in a variable
    nvim "$file"  # Pass the file directly to nvim
  end


  function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_vi_key_bindings --no-erase normal
  end
end
