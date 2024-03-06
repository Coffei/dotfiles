#!/bin/bash

layout=$(xset -q | grep -A 0 'LED' | cut -c59-67)
variant_order=$(setxkbmap -query | grep variant | cut -c13-18)

if [[ $layout -lt 00001000 ]]; then
    if [[ $variant_order == 'coder,' ]]; then
        text=en
    else
        text=cs
    fi
else
    if [[ $variant_order == 'coder,' ]]; then
        text=cs
    else
        text=en
    fi
fi

echo $text
