# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#Java 11 default
export JAVA_HOME=/usr/lib/jvm/java-11

# Rustup
source $HOME/.cargo/env

# User specific aliases and functions
# Prompt
prompt_command () {
    LAST_EXIT="$?"
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
        NOT_STAGED=$(git status -s 2> /dev/null | grep "^ M" | wc -l)

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
PROMPT_COMMAND=prompt_command

stty -ixon
unset command_not_found_handle
