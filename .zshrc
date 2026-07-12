export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Plugins (must be set before sourcing oh-my-zsh.sh)
plugins=(
	# archlinux # Arch Linux plugin
	brew # macOS
	command-not-found
	colorize
	docker
	docker-compose
	emoji
	fzf
	git
	safe-paste
	sudo
)

# Load Oh My Zsh (this must come after plugins=())
source $ZSH/oh-my-zsh.sh

# Load extra plugins not part of Oh My Zsh
for plugin in \
    "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "/usr/local/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
do
    [ -f "$plugin" ] && source "$plugin" && break
done

for plugin in \
    "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "/usr/local/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting.zsh" \
    "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
do
    [ -f "$plugin" ] && source "$plugin" && break
done

# Eza (better ls)
alias ls="eza --icons=always"

# Zoxide (better cd)
eval "$(zoxide init zsh)"
alias cd='z'

export PATH="/opt/homebrew/bin:$PATH"

export FLUTTER=$HOME/development/flutter/bin
export OPENJDK=/opt/homebrew/opt/openjdk@17/bin
export ANDROID_HOME=$HOME/Library/Android/sdk
export SDKMANAGER=$HOME/development/android_sdk/cmdline-tools/latest/bin
export DOTNET_TOOLs=$HOME/.dotnet/tools

export PATH=$FLUTTER:$SDKMANAGER:$OPENJDK:$DOTNET_TOOLs:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH
