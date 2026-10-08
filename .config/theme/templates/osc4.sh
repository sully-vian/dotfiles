#!/usr/bin/env sh

set -euo pipefail

# nvim's :terminal its palette from g:terminal_color_N and does not support OSC 4
if [ -n "${NVIM+x}" ]; then
    exit 0
fi

if [ -n "${TMUX+x}" ]; then
    printf "%b" "\033Ptmux;\033\033]4;0;${color00}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;1;${color01}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;2;${color02}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;3;${color03}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;4;${color04}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;5;${color05}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;6;${color06}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;7;${color07}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;8;${color08}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;9;${color09}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;10;${color10}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;11;${color11}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;12;${color12}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;13;${color13}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;14;${color14}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;15;${color15}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;16;${color16}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;17;${color17}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;18;${color18}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;19;${color19}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;20;${color20}\007\033\\"
    printf "%b" "\033Ptmux;\033\033]4;21;${color21}\007\033\\"
else
    printf "%b" "\033]4;0;${color00}\033\\"
    printf "%b" "\033]4;1;${color01}\033\\"
    printf "%b" "\033]4;2;${color02}\033\\"
    printf "%b" "\033]4;3;${color03}\033\\"
    printf "%b" "\033]4;4;${color04}\033\\"
    printf "%b" "\033]4;5;${color05}\033\\"
    printf "%b" "\033]4;6;${color06}\033\\"
    printf "%b" "\033]4;7;${color07}\033\\"
    printf "%b" "\033]4;8;${color08}\033\\"
    printf "%b" "\033]4;9;${color09}\033\\"
    printf "%b" "\033]4;10;${color10}\033\\"
    printf "%b" "\033]4;11;${color11}\033\\"
    printf "%b" "\033]4;12;${color12}\033\\"
    printf "%b" "\033]4;13;${color13}\033\\"
    printf "%b" "\033]4;14;${color14}\033\\"
    printf "%b" "\033]4;15;${color15}\033\\"
    printf "%b" "\033]4;16;${color16}\033\\"
    printf "%b" "\033]4;17;${color17}\033\\"
    printf "%b" "\033]4;18;${color18}\033\\"
    printf "%b" "\033]4;19;${color19}\033\\"
    printf "%b" "\033]4;20;${color20}\033\\"
    printf "%b" "\033]4;21;${color21}\033\\"
fi
