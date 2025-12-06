_cheat_complete() {
    # generate completions for ommand names (-c) based on the current arg ($2)
    # and store in special COMPREPLY array
    COMPREPLY=( $(compgen -c "$2") )
}

# register completion func
complete -F _cheat_complete cheat
complete -F _cheat_complete cht
