#!/bin/bash
ddcutil getvcp 10 --terse -b 6 | cut -f 4 -d ' ' 2>/dev/null
