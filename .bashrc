export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# ~/.bashrc

#aliasFuncrions
mkcd () {
  mkdir -p "$1"
  cd "$1"
}

# autocd
shopt -s autocd

# git
plugins=(git)
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# starship
eval "$(starship init bash)"

# zoxide
eval "$(zoxide init bash)"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# extract file
extract () {
    if [ -f "$1" ]; then
        local filename=$(basename "$1")
        local dir_name="${filename%.*}"
        dir_name="${dir_name%.tar}"
        mkdir -p "$dir_name"

        case "$1" in
            *.tar.bz2)   tar xjf "$1" -C "$dir_name"   ;;
            *.tar.gz)    tar xzf "$1" -C "$dir_name"   ;;
            *.bz2)       bunzip2 -c "$1" > "$dir_name/${dir_name}" ;;
            *.rar)       unrar x "$1" "$dir_name/"     ;;
            *.gz)        gunzip -c "$1" > "$dir_name/${dir_name}"  ;;
            *.tar)       tar xf "$1" -C "$dir_name"    ;;
            *.tbz2)      tar xjf "$1" -C "$dir_name"   ;;
            *.tgz)       tar xzf "$1" -C "$dir_name"   ;;
            *.zip)       unzip "$1" -d "$dir_name"     ;;
            *.7z)        7z x "$1" -o"$dir_name"       ;;
            *) 
                echo "I don't know how to extract: $1" 
                rmdir "$dir_name" 2>/dev/null              
	     	;;
        esac
    else
        echo "The file $1 does not exist"
    fi
}

fastfetch

# General 
alias open="dolphin"
alias show="kitten icat"
alias mk="mkdir"
alias yy='yazi'
alias j='zi'
alias jf='z "$(zoxide query -l | fzf --preview "eza --tree --level=1 --icons {}" --preview-window=right:40%)"'
alias k='kitty'
alias ..='cd ..'
alias ...='cd ../..'
alias update='yay -Syu'
alias cat='bat --style=plain --paging=never'
alias yt-tool='./.yt-tool'
alias my-yt-dlp='python3 /home/safooahmed/.yt-dlp/yt_dlp/__main__.py'
alias vi='vim'
alias pdf='zathura'
alias play='mpv'
alias music='cmus'
alias pic='feh'
alias sr='ddgr'
alias pms='sudo pacman -Ss'
alias pmi='sudo pacman -S'
alias pmr='sudo pacman -R'
alias pmu='sudo pacman -Syu'
# eza
alias ls='eza --color=auto --icons=auto'
alias eza='eza --color=auto --icons=auto'
alias ll='eza -l'
alias la='eza -lah'
alias lt='eza -T'
# npm
alias run='npm run dev'
alias i='npm i'
alias irun='npm i && npm run dev'
# git
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gch='git checkout'

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# opencode
export PATH=/home/safooahmed/.opencode/bin:$PATH

# OpenClaw Completion
[ -f "/home/safooahmed/.openclaw/completions/openclaw.bash" ] && source "/home/safooahmed/.openclaw/completions/openclaw.bash"
export PATH="$HOME/.local/bin:$PATH"

whoami() {
	echo "you are $USER"
}
