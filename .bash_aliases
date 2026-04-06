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

activate_env() {
    set -x
    local dir="${PWD##*/}"
    if [[ "$dir" == *xla ]]; then
        source venv/activate
    elif [[ "$dir" == *mlir ]]; then
        source env/activate
    fi
    set +x
}

set-mlir() {
    set -x
    sed -i -E \
    "s|(set\(TT_MLIR_VERSION[[:space:]]+\")[0-9a-f]+(\")|\1$1\2|" \
    /localdev/acicovic/tt-xla/third_party/CMakeLists.txt
    set +x
}

alias py='python'
alias pt='pytest'
alias host='hostname'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias tl='tmux ls'
alias ta='tmux attach'
alias td='tmux detach'
alias topm='ps -eo pid,user,%mem,%cpu,cmd --sort=-%mem | head -n 10'
alias topc='ps -eo pid,user,%mem,%cpu,cmd --sort=-%cpu | head -n 10'

alias cdd='pushd /localdev/acicovic'
alias xla='pushd /localdev/acicovic/tt-xla'
alias mlir='pushd /localdev/acicovic/tt-mlir'
alias pytorch='pushd /localdev/acicovic/pytorch'
alias torch-xla='pushd /localdev/acicovic/pytorch/xla'

alias a='activate_env'
alias init='echo -n "Create .vscode/ ... " && mkdir -p .vscode && cp ~/.vscode-my/launch.json .vscode/ && echo -n "Initialize submodules ... " && git submodule update --init --recursive && echo "Activate venv ... " && a && echo "Install hooks ... " && pre-commit install'
alias cfg='cmake -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
alias cfg-dbg='cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
alias cfg-rt-shlo='cmake -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DTTMLIR_ENABLE_RUNTIME=ON -DTTMLIR_ENABLE_STABLEHLO=ON'
alias build='cmake --build build/'
alias build-explain='cmake --build build/ -- -v -d explain'
alias cfg-build='cfg && build'
alias cfg-dbg-build='cfg-dbg && build'
alias patch-gdb='git restore --source=acicovic/gdb --worktree -- scripts/gdb'

alias pre-all='pre-commit run --all-files'
alias cont='docker exec -it -w /localdev/acicovic/tt-xla --user acicovic $(docker ps | grep acicovic-for-reservation | awk "{print \$1}") bash'
alias cont-qb='docker exec -it -w /localdev/acicovic/tt-xla --user root $(docker ps | grep tt-xla-ird-ubuntu | awk "{print \$1}") bash'
alias cls='docker ps -a'
alias isc='cat /proc/1/cgroup'
alias mlir-ver='head -n 20 /localdev/acicovic/tt-xla/third_party/CMakeLists.txt | grep "set(TT_MLIR_VERSION" | sed -n '\''s/.*"\([0-9a-fA-F]\{40\}\)".*/\1/p'\'''
alias set-torch-xla-env='export PYTORCH_REPO_PATH=/localdev/acicovic/pytorch && export TEST_TMPDIR=/localdev/acicovic/bazel_tmp && export USE_CUDA=0 && export BUILD_TEST=0 && export DEBUG=1'

alias br='git branch --show-current'
alias diff='git diff'
alias log='git log --pretty=format:"%C(yellow)%H%Creset %Cgreen%ad%Creset %C(blue)%an%Creset %C(red)%d%Creset %s" --date=short'
alias purge='git clean -xdf'
alias push='git push origin HEAD'
alias rinit='git submodule update --init --recursive'
alias st='git status'
