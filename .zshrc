# Enable bindkey
# ref: http://d.hatena.ne.jp/y-echo/20110125/1295971977
bindkey -e

# [2019/12/27 19:17:52] /path/to/current
# 🏯 %
PROMPT="[%D{%Y/%m/%d %T}] %/
🏯 %# "

# PATH {{{

export GOPATH=$HOME
export PYENV_ROOT=/usr/local/var/pyenv

# defalut
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

# etc
paths=(
  "$GOPATH/bin"
  "$PYENV_ROOT/bin"
  "$HOME/.rbenv/bin"
  "$HOME/.ndenv/bin"
  "/usr/local/git/bin"
)

for p in ${paths}; do
  export PATH="${p}:$PATH"
done


# }}}

# eval {{{

eval "$(rbenv init -)"
eval "$(thefuck --alias)"
eval "$(ndenv init -)"
eval "$(direnv hook zsh)"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# }}}

# export {{{

export EDITOR=/usr/local/bin/vim
export VISUAL=/usr/local/bin/vim
export LESS='-g -i -M -R'

# }}}

# alias {{{

alias gti='git'
alias vimrc='vim ~/.vimrc'
alias ql='qlmanage -p'
# ref: https://github.com/robbyrussell/oh-my-zsh/blob/37c2d0ddd751e15d0c87a51e2d9f9849093571dc/plugins/git/git.plugin.zsh#L52
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
# ref: https://qiita.com/itkrt2y/items/0671d1f48e66f21241e2
alias gsf='cd $(ghq list -p standfirm | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias gfcm='git fetch -p && git checkout origin/master && gbda'
alias be='bundle exec'
# ref: http://rikuga.me/2017/06/25/aws-profile-switch/
alias awsp='export AWS_DEFAULT_PROFILE=`grep "^\[.*\]" ~/.aws/credentials | tr -d "[" | tr -d "]" | peco`; export AWS_PROFILE=${AWS_DEFAULT_PROFILE}; awsw'
alias awsw='echo "Current AWS Profile: ${AWS_DEFAULT_PROFILE}"'
alias doc='docker-compose'
alias tf='terraform'

# }}}

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

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

source $HOME/.cargo/env


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


# ローカル環境用の設定を読み込む
# see: http://qiita.com/awakia/items/1d5cd440ce58ef4fb8ae
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
