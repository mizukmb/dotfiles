# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="miloshadzic"

# alias
alias gti='git'
alias vimrc='vim ~/.vimrc'
alias ql='qlmanage -p'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby osx bundler brew rails emoji-clock)

source $ZSH/oh-my-zsh.sh

# PATH {{{
# defalut
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

# etc
paths=(
  '$GOPATH/bin'
  '$HOME/.rbenv/bin'
  '$HOME/.nodebrew/current/bin'
  '/usr/local/git/bin'
)

for p in ${paths}; do
  export PATH="${p}:$PATH"
done
# }}}
#
eval "$(rbenv init -)"

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

RPROMPT="🕛  %D-%{${fg[cyan]}%}%*%{${reset_color}%}"

# 入力したコマンドが存在せず、かつディレクトリ名と一致するなら、ディレクトリに cd する
# 例： /usr/bin と入力すると /usr/bin ディレクトリに移動
setopt auto_cd

# cd した先のディレクトリをディレクトリスタックに追加する
# ディレクトリスタックとは今までに行ったディレクトリの履歴のこと
# `cd +<Tab>` でディレクトリの履歴が表示され、そこに移動できる
setopt auto_pushd

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# Enterで自動ls, git status
function do_enter() {
  if [ -n "$BUFFER" ]; then
    zle accept-line
    return 0
  fi
  echo
  ls
  # ↓おすすめ
  # ls_abbrev
  if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
    echo
    echo -e "\e[0;33m--- git status ---\e[0m"
    git status -sb
  fi
  zle reset-prompt
  return 0
}
zle -N do_enter
bindkey '^m' do_enter

# [vim から :shell で抜けたときにわかりやすくする](http://qiita.com/dayflower/items/06cba1bc3d8bf5403659)
[[ -n "$VIMRUNTIME" ]] && \
  PROMPT="%{${fg[white]}${bg[blue]}%}(vim)%{${reset_color}%} $PROMPT"

# Cliから辞書を開く
function dict {
  if [ $# -eq 0 ]; then
    echo "Usage: dict WORD" 1>&2
    return 1
  fi
  open dict://$@
}

# refer to http://r7kamura.github.io/2014/06/21/ghq.html
p() { peco | while read LINE; do $@ $LINE; done  }
alias e='ghq list -p | p cd'
alias eff='ghq list -p feedforce | p cd'

export EDITOR=/usr/local/bin/vim
eval "$(direnv hook zsh)"

export LESS='-g -i -M -R'
source ~/.cargo/env

function peco-git-recent-branches () {
  local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
    perl -pne 's{^refs/heads/}{}' | \
    peco)
  if [ -n "$selected_branch" ]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-git-recent-branches

function peco-git-recent-all-branches () {
  local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads refs/remotes | \
    perl -pne 's{^refs/(heads|remotes)/}{}' | \
    peco)
  if [ -n "$selected_branch" ]; then
    BUFFER="git checkout -t ${selected_branch}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-git-recent-all-branches

bindkey '^x^b' peco-git-recent-branches
bindkey '^xb' peco-git-recent-all-branches

# ローカル環境用の設定を読み込む
# see: http://qiita.com/awakia/items/1d5cd440ce58ef4fb8ae
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
