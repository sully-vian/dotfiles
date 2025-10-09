#!/usr/bin/env bash


# script to open github page from a repo in Tmux
# strangly inspired by https://github.com/SylvanFranklin/.config/blob/main/scripts/open_github.sh

cd $(tmux run "echo #{pane_current_path}")
url=$(git remote get-url origin)

if [[ $url == *github.com* ]]; then
	# echo "hosted on GitHub at $url"
	if [[ $url == git@* ]]; then # git@github.com:<user>/<repo>
		url="${url#git@}" # github.com:<user>/<repo>
		url="${url/:/\/}" # github.com/<user>/<repo>
		url="https://$url" # https://github.com/<user>/<repo>
		# echo $url
	fi
	xdg-open $url > /dev/null
	tmux display-message -d 1000 "opening $url"
else
	echo "This repo is not hosted on GitHub."
fi
