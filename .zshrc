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
alias mdlink='~/dev/shellscript/mdlink'
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby osx bundler brew rails emoji-clock)

source $ZSH/oh-my-zsh.sh
# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:$HOME/Downloads/spang-0.3.4/bin"
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
export JAVA=$JAVA_HOME/bin
export PATH=/usr/local/texlive/2015/bin/x86_64-darwin/:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

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

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PYTHONPATH=/Library/Python/2.7/site-packages

[[ -s "/Users/mizushiri/.gvm/scripts/gvm" ]] && source "/Users/mizushiri/.gvm/scripts/gvm"

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
