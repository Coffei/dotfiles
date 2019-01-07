#!/bin/bash
FILE=~/Documents/todos/notes.org
ONGOING=$(cat $FILE | sed -ne '1,/* Done/ p' | grep -e '\*\* IN-PROGRESS' | wc -l)
ALL=$(cat $FILE | sed -ne '1,/* Done/ p' | grep -e '\*\*' | wc -l) 

echo "$ONGOING/$ALL"
