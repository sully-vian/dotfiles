#!/bin/bash

# custom ssh function with prompt if inside a tmux session
ssh() {
  ORANGE="\033[0;33m"
  RESET="\033[0m"

  # check if we are in a tmux session
  if [ -n "$TMUX" ]; then
    # prompt the user
    echo -e "${ORANGE}[WARNING]${RESET}\nYou are currently in a tmux session. The machine you're connecting to might automatically run a tmux session too, causing tmux session nesting."
    read -p "Do you want to Proceed (y/n)?: " choice
    case "$choice" in
    y | Y) echo "Proceeding with SSH..." ;;
    n | N)
      echo "SSH aborted to avoid nested tmux sessions"
      return 1
      ;;
    *)
      echo "Invalid choice. SSH aborted."
      return 1
      ;;
    esac
  fi
  # execute the ssh command with the provided args
  command ssh "$@"
}
