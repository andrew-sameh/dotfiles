eval "$(starship init zsh)"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
fpath+=~/.zfunc

autoload -Uz compinit && compinit

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8  
export EDITOR=/opt/homebrew/bin/nvim
export TERM=xterm-256color
export XDG_CONFIG_HOME="$HOME/.config"
export DOTFILES="$HOME/dotfiles"
## Aliases
#alias l='lsd -hA --group-dirs first'
# Eza
alias l="eza -l --icons --git -a"
alias ls="eza --icons --git --group-directories-first -a "
alias ld="eza --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpush='git push -u origin'
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gaa='git add .'
alias gcoall='git checkout -- .'
alias gcb='git checkout -b'
alias gr='git remote'
alias gre='git reset'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# GCP
alias gcpconf="gcloud config configurations list"
alias gcpact="gcloud config configurations activate"
alias gcpsetquota="gcloud auth application-default set-quota-project"
alias gcpuse="gcloud config set project"
alias gcpdeact="gcloud auth revoke"
alias gcpinfo="gcloud info"
alias gcpdauth="gcloud auth application-default login"
alias gcpauth="gcloud auth login"

# Zsh Source
alias rezsh="source ~/.zshrc"
alias zshconfig="nvim ~/.zshrc"

# Zoxide
# alias cd="z"

# Tmux
alias retmux="source ~/.tmux.conf"

# MacO
alias wifipass="security find-generic-password -wa"
alias c="clear"

# Brew
alias brewdump='brew bundle dump --force --describe --file=~/Brewfile'
alias ccupgrade='brew upgrade --cask claude-code'

## Python
# Created by `pipx` on 2025-01-23 14:13:12
export PATH="$PATH:/Users/andrew/.local/bin"
export PATH="$(brew --prefix python)/libexec/bin:$PATH"
#Poetry
export POETRY_VIRTUALENVS_IN_PROJECT=true
# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
alias aple='source .venv/bin/activate'

## Go
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Zsh Plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-you-should-use/you-should-use.plugin.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# eval "$(zoxide init zsh)"
# if [ -z "$DISABLE_ZOXIDE" ]; then
#     eval "$(zoxide init --cmd cd zsh)"
# fi

[[ $- == *i* ]] && eval "$(zoxide init --cmd cd zsh)"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# FZF key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Color Script
indexes=(30 39 56 55 51 49 30 29 4 21 11 2)
random_index=${indexes[RANDOM % ${#indexes[@]}]}
colorscript exec $random_index

# Nap
export NAP_CONFIG="$XDG_CONFIG_HOME/nap/config.yaml"

# ---- TheFuck -----
# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# Consol-Ninja


# Tmuxifier
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# Added by Windsurf
export PATH="/Users/andrew/.codeium/windsurf/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/andrew/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/andrew/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/andrew/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/andrew/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/andrew/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Android
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools"
