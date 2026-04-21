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

# if ssh, normalize to http:
# git@hostname:user/repo.git -> https://hostname/user/repo
if [[ $url =~ ^git@ ]]; then # git@github.com:<user>/<repo>
	url="${url#git@}" # remove git@
	url="${url/:/\/}" # replace first ':' with '/'
	url="https://$url" # add schema
fi

url="${url%.git}" # remove trailing .git

path_sep="tree" # some providers use other

final_url="$url/$path_sep/$branch/$rel_path"

tmux display-message -d 3000 "Opening $final_url..."
xdg-open $final_url > /dev/null 2>&1 &
