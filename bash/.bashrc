# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
PS1='\[\033[0;32m\]\w\[\033[0;93m\]$(git branch &>/dev/null && echo -n " (" && git branch 2>/dev/null | grep '^*' | colrm 1 2 | tr -d "\n" && echo -n ")")\[\033[1;34m\] >> \[\033[0m\]'
