#!/usr/bin/env python3

import sys
import json

# This script finds the name of the workspace containing a given i3 window ID.
#
# Usage:
#   find-workspace.py <window_id>
#
# Arguments:
#   <window_id> : The integer window ID to search for.
#
# Input:
#   Reads i3 tree JSON from stdin (use: i3-msg -t get_tree | python3 find-workspace.py <window_id>)
#
# Output:
#   Prints the workspace name if the window is found.
#   Prints -1 if the window is not found in the tree.

if len(sys.argv) != 2:
    print("Usage: find-workspace.py <window_id>")
    print("Reads i3 tree JSON from stdin.")
    sys.exit(1)

win_id = int(sys.argv[1])
tree = json.load(sys.stdin)


def find_workspace(node, win_id):
    if node.get("id") == win_id:
        return None

    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        result = find_workspace(child, win_id)
        if result is not None:
            if result == "FOUND" and node.get("type") == "workspace":
                return node
            elif result == "FOUND":
                return "FOUND"
            else:
                return result

    if node.get("window") == win_id:
        return "FOUND"

    return None


workspace = find_workspace(tree, win_id)

if workspace:
    print(workspace["name"])
else:
    print(-1)
