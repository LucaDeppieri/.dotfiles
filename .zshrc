# ==============================================================================
# 1. OH MY ZSH CONFIGURATION
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Built-in Oh My Zsh plugins
plugins=(
    brew
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

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# ==============================================================================
# 2. ALIASES & TOOLS
# ==============================================================================
# Eza (better ls)
alias ls="eza --icons=always"

# Zoxide (better cd)
eval "$(zoxide init zsh)"
alias cd='z'

# ==============================================================================
# 3. PATH & ENVIRONMENT
# ==============================================================================
export PATH="/opt/homebrew/bin:$PATH"

# Development variables
export FLUTTER="$HOME/development/flutter/bin"
export OPENJDK="/opt/homebrew/opt/openjdk@17/bin"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export SDKMANAGER="$HOME/development/android_sdk/cmdline-tools/latest/bin"
export DOTNET_TOOLS="$HOME/.dotnet/tools"

# Combine paths
export PATH="$FLUTTER:$SDKMANAGER:$OPENJDK:$DOTNET_TOOLS:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

# ==============================================================================
# 4. EXTERNAL PLUGINS (Homebrew) - Always at the end!
# ==============================================================================

# 4a. Autosuggestions
for plugin in \
    "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "/usr/local/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
do
    [ -f "$plugin" ] && source "$plugin" && break
done

# 4b. Syntax Highlighting (MUST BE THE LAST LINE OF THE FILE)
for plugin in \
    "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "/usr/local/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting.zsh" \
    "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
do
    [ -f "$plugin" ] && source "$plugin" && break
done
