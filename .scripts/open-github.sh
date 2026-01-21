#!/usr/bin/env bash


# script to open github page from a repo in Tmux
# strangly inspired by https://github.com/SylvanFranklin/.config/blob/main/scripts/open_github.sh

cd $(tmux run "echo #{pane_current_path}") || exit 1

git_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    tmux display-message "Not inside a git repository"
    exit 1
}

rel_path=$(realpath --relative-to="$git_root" "$PWD")

branch=$(git branch --show-current)

url=$(git remote get-url origin)

if [[ $url != *github.com* ]]; then
	tmux display-message "This repo is not hosted on GitHub."
    exit 1
fi

# normalize SSH -> HTTPS
if [[ $url == git@* ]]; then # git@github.com:<user>/<repo>
	url="${url#git@}" # github.com:<user>/<repo>
	url="${url/:/\/}" # github.com/<user>/<repo>
	url="https://$url" # https://github.com/<user>/<repo>
fi

url="${url%.git}" # strip trailing .git

if [[ "$relpath" == "." ]]; then
    final_url="$url/tree/$branch"
else
    final_url="$url/tree/$branch/$rel_path"
fi

	xdg-open $final_url > /dev/null 2>&1 &
	tmux display-message -d 1000 "opening $url"
else
fi
