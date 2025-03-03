if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  fastfetch
  exec startx
  logout # Exit the shell so tmux doesn't keep running and $DISPLAY is set in the new one
fi

source ~/.bashrc
