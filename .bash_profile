set -o vi
PS1='\[\e[1;32m\][\W]\$\[\e[0m\] '
export EDITOR=nvim
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export TIMEFORMAT="real  %3lR  (cpu=%P%%, user=%3lU, sys=%3lS)"
# so vim clipboard works
export DISPLAY=":0"

alias ll='ls -larth'
alias youtube-audio='youtube-dl --audio-format mp3 -x'
alias dud='python3 ~/prog/utils/dud.py'
#alias dud='du -d 1 -h'
alias dh='df -h'
alias vim='nvim'
alias python='python3'
alias tig='tig --all'
alias listening='lsof -i -sTCP:LISTEN -P'
# Alembic aliases
alias alemup='alembic upgrade head'
alias alemdn='alembic downgrade -1'
alias alemgen='alembic revision --autogenerate -m'

#if [ -f `brew --prefix`/etc/bash_completion ]; then
#   . `brew --prefix`/etc/bash_completion
#fi

function mdcd {
    mkdir -p "$@" && cd "$@"
}

. ~/.bashrc
