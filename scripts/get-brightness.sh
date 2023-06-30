#!/bin/bash
ddcutil getvcp 10 --sleep-multiplier .01 --terse --nousb | cut -f 4 -d ' ' 2>/dev/null
