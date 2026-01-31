#!/usr/bin/env bash

MESSAGE="C'est une amazone, dès qu'elle arrive, j'ai l'paquet"
MSG_LEN=${#MESSAGE}
LENGTH=100 # displayed length

WRAPPED_MESSAGE="$MESSAGE // $MESSAGE // $MESSAGE"

timestamp=$(date +%s)


start=$(( timestamp % MSG_LEN ))

echo "${WRAPPED_MESSAGE:start:LENGTH}"

