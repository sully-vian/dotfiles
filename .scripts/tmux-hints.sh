#!/usr/bin/env bash

# 1. Get the width, height, left, and top offsets of the active pane
read -r p_width p_height p_left p_top <<< \
  $(tmux display-message -p '#{pane_width} #{pane_height} #{pane_left} #{pane_top}')

# 2. Calculate the center of that pane
target_col=$(( p_left + (p_width / 2) - 2 )) # -2 adjusts for half the length of "baba"
target_row=$(( p_top + (p_height / 2) ))

# 3. Use tput to move the cursor to that coordinate, print, and reset
# Note: We direct this to the tty tmux is currently rendering to
current_tty=$(tmux display-message -p '#{client_tty}')

{
  # Save cursor position
  tput sc
  # Move to the calculated row and column
  tput cup $target_row $target_col
  # Set colors (e.g., Bold Red text)
  tput bold; tput setaf 1
  printf "BABA"
  # Restore original formatting and cursor position
  tput sgr0
  tput rc
} > "$current_tty"

# 4. Leave it on screen for 1.5 seconds, then force tmux to redraw/erase it
sleep 1.5
tmux refresh-client
