#!/bin/bash

layout=$(xset -q | grep -A 0 'LED' | cut -c59-67)

if [[ $layout < 00001000 ]]; then
    text=en
else
    text=cs
fi

echo $text
