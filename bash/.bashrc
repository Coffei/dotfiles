# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
alias tv='LC_TIME=en_US.UTF-8 vimx ~/Documents/notes/todo.org'

# alias vim to edit terminal title
alias vimx='echo -ne "\033]0;vimx: ${PWD##*/}\007" && vimx'

# Increase history file size
HISTSIZE=5000
HISTFILESIZE=10000

# set editor to vim
export EDITOR=vimx

# Auto unlock ssh key - useful for i3 not for Gnome
# eval "$(ssh-agent)"
# cat ~/.ssh/id_rsa | SSH_ASKPASS="$HOME/.sshpass" ssh-add - &> /dev/null

#Java 11 default
export JAVA_HOME=/usr/lib/jvm/java-11

# Rustup
source $HOME/.cargo/env

# User specific aliases and functions
# Prompt
prompt_command () {
    LAST_EXIT="$?"
    # Adds last command to history immediatelly
    history -a; history -c; history -r;
    # Colors
    YELLOW="\[\033[93m\]"
    LGREEN="\[\033[92m\]"
    GREEN="\[\033[32m\]"
    BLUE_BOLD="\[\033[1;34m\]"
    RED_BOLD="\[\033[1;31m\]"
    COLOR_RESET="\[\033[0m\]"

    # GIT indicator
    if git rev-parse --git-dir > /dev/null 2>&1; then
        BRANCH=$(git branch 2>/dev/null | grep '^*' | colrm 1 2 | tr -d "\n")
        STAGED=$(git status -s 2> /dev/null | grep "^[MA]" | wc -l)
        NOT_STAGED=$(git status -s 2> /dev/null | grep "^ [MD]" | wc -l)

        if [ "$STAGED" -gt 0 ]; then
            STAGED_STATUS=" ${LGREEN}${STAGED}"$'\u2691'
        else
            STAGED_STATUS=""
        fi

        if [ "$NOT_STAGED" -gt 0 ]; then
            NOT_STAGED_STATUS=" ${YELLOW}${NOT_STAGED}"$'\u2691'
        else
            NOT_STAGED_STATUS=""
        fi

        if [[ "$STAGED" == "0" && "$NOT_STAGED" == "0" ]]; then
            DONE_STATUS=" ${LGREEN}"$'\u2714'
        else
            DONE_STATUS=""
        fi

        GIT=" ${YELLOW}(${BRANCH}${STAGED_STATUS}${NOT_STAGED_STATUS}${DONE_STATUS}${YELLOW})"
    else
        GIT=""
    fi
    
    # Last command status
    if [ "$LAST_EXIT" -gt 0 ]; then
        STATUS_COLOR=$RED_BOLD
    else
        STATUS_COLOR=$BLUE_BOLD
    fi

    export PS1="${GREEN}\w${GIT}${STATUS_COLOR} >> ${COLOR_RESET}"
}
export PROMPT_COMMAND=prompt_command

stty -ixon
unset command_not_found_handle

# Load ASDF
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

PATH="/home/jtrantin/bin:/home/jtrantin/Apps/elixir-ls/bin:/home/jtrantin/.mix/escripts:/home/jtrantin/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/jtrantin/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/jtrantin/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/jtrantin/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/jtrantin/perl5"; export PERL_MM_OPT;

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jtrantin/Apps/google-cloud-sdk/path.bash.inc' ]; then . '/home/jtrantin/Apps/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/jtrantin/Apps/google-cloud-sdk/completion.bash.inc' ]; then . '/home/jtrantin/Apps/google-cloud-sdk/completion.bash.inc'; fi
. "$HOME/.cargo/env"
