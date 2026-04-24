#!/usr/bin/env bash

# script to open github page from a repo in Tmux
# strangly inspired by https://github.com/SylvanFranklin/.config/blob/main/scripts/open_github.sh

cd "$(tmux display-message -p "#{pane_current_path}")" || exit 1

git_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    tmux display-message "Not inside a git repository"
    exit 1
}

rel_path=$(realpath --relative-to="$git_root" "$PWD")

branch=$(git branch --show-current)

url=$(git remote get-url origin)

if [[ -z "$url" ]]; then
    tmux display-message "No remote 'origin' found"
    exit 1
fi

# if ssh, normalize to http:
# git@hostname:user/repo.git -> https://hostname/user/repo
if [[ $url =~ ^(ssh://)?git@ ]]; then # git@github.com:<user>/<repo>
    url="${url#ssh://}" # remove ssh:// if it exists
	url="${url#git@}" # remove git@
    url="${url/:/\/}" # replace first ':' with '/' (no-op for ssh:// urls)
	url="https://$url" # add schema
fi

url="${url%.git}" # remove trailing .git

path_sep="tree" # some providers use other

if [[ -n "$branch" ]]; then # add branch
    url="$url/$path_sep/$branch"
fi

if [[ -n "$rel_path" && "$rel_path" != "." ]]; then # add relative path
    url="$url/$rel_path"
fi

tmux display-message -d 3000 "Opening $url..."
xdg-open "$url" > /dev/null 2>&1 &
