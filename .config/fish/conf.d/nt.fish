function nt
  # Check if the first argument is provided, set name accordingly
  if test (count $argv) -eq 0
    set name "note"
  else
    set name "$argv[1]"
  end

  set file (touty -t ~/Nextcloud/Notes/inbox -n "$name")  # Capture the output in a variable
  nvim "$file"  # Pass the file directly to nvim
end

