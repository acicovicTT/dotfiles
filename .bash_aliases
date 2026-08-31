gc() {
    set -x
    git commit -m "$*"
    set +x
}

psg() {
    if [ -z "$1" ]; then
        echo "Usage: psg <keyword>"
        return 1
    fi
    ps -eo pid,state,user,cmd \
    | grep -i --color=auto "$1" \
    | grep -v grep
}

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias tl='tmux ls'
alias ta='tmux attach'
alias td='tmux detach'
alias topm='ps -eo pid,user,%mem,%cpu,cmd --sort=-%mem | head -n 10'
alias topc='ps -eo pid,user,%mem,%cpu,cmd --sort=-%cpu | head -n 10'
alias py='python'
alias pt='pytest'
alias host='hostname'
alias cdd='pushd /localdev/acicovic'

alias cont='docker exec -it -w /localdev/acicovic/tt-metal --user acicovic $(docker ps | grep acicovic-for-reservation | awk "{print \$1}") bash'
alias set-cache='export UV_CACHE_DIR=/localdev/acicovic/.cache/uv && export CCACHE_DIR=/localdev/acicovic/.cache/ccache && export HF_HOME=/localdev/acicovic/.cache/hf_cache && export TT_METAL_CACHE=/localdev/acicovic/.cache'
alias patch-gdb='git restore --source=acicovic/gdb --worktree -- scripts/gdb'
alias cls='docker ps -a'
alias isc='cat /proc/1/cgroup'

alias br='git branch --show-current'
alias diff='git diff'
alias log='git log --pretty=format:"%C(yellow)%H%Creset %Cgreen%ad%Creset %C(blue)%an%Creset %C(red)%d%Creset %s" --date=short'
alias push='git push origin HEAD'
alias rinit='git submodule update --init --recursive'
alias st='git status'
