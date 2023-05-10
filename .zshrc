# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/morim/.zshrc'

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select # tab押下時に選択中の項目を塗りつぶす

autoload -Uz colors
colors

# End of lines added by compinstall
#
export LANG=ja_JP.UTF-8

# prompt settings
export PS1="%~ %F{cyan}>%f%F{green}>%f "
export RPROMPT='%F{cyan}'$'\Ue388''%f %*'
# end of prompt settings
# path setting#
export PATH="/home/morim/.local/bin:$PATH"
export PATH="/home/morim/.deno/bin:$PATH"

# end path setting#
export PYTHONPATH="/home/morim/repos/mitou-evoluation/:$PYTHONPATH"
export PYTHONPATH="/home/morim/repos/mitou-quads/:$PYTHONPATH"
export PYTHONPATH="/home/morim/repos/hm_birl/:$PYTHONPATH"
# zenhan
# cxport zenhan='/mnt/c/Users/morim/scoop/shims/zenhan.shim'
#
# grobi
export GUROBI_HOME="/opt/gurobi952/linux64"
export PATH="${PATH}:${GUROBI_HOME}/bin"
export PATH="$PATH:/usr/local/go/bin"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib:/usr/local/lib"
###

eval "$(zoxide init zsh)"
# alias
alias grep='grep --color=auto'
alias vim='nvim'

function open() {
    if [ $# != 1 ]; then
        explorer.exe .
    else
        if [ -e $1 ]; then
            /mnt/c/Windows/System32/cmd.exe /c start $(wslpath -w $1) 2> /dev/null
        else
            echo "open: $1 : No such file or directory" 
        fi
    fi
}

alias less='bat'    
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
help() {
    "$@" --help 2>&1 | bat --plain --language=help
}



if [[ $(command -v exa) ]]; then
  alias e='exa --icons --git'
  alias l=/bin/ls
  alias ls=e
  alias la='exa -a --icons --git'
  alias ll='exa -aal --icons --git'
fi

if [[ -x `which colordiff` ]]; then
  alias diff='colordiff'
fi

alias mmd=pandoc -N --toc --toc-depth=2 -f markdown --pdf-engine=lualatex -V documentclass=ltjsarticle

# end alias

setopt auto_param_slash       # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs              # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt auto_menu              # 補完キー連打で順に補完候補を自動で補完
setopt interactive_comments   # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst      # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt complete_in_word       # 語の途中でもカーソル位置で補完
setopt print_eight_bit
setopt nobeep
setopt HIST_IGNORE_DUPS # 重複コマンドをhistoryに残さない
setopt print_exit_value
setopt notify
# 補完候補をできるだけ詰めて表示する
setopt list_packed
setopt autopushd

# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

ga(){
  local selected
  selected=$(git status -s | fzf -m --ansi --preview="echo {} | awk '{print $2}' | xargs git diff" | awk '{print $2}')
  if [[ -n "$selected" ]]; then
    git add `paste -s - <<< $selected`
  fi
  git status
}
