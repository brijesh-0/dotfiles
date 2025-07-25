# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Env
export XDG_CONFIG_HOME="$HOME/.config"
export FZF_DEFAULT_COMMAND='fdfind --type file --exclude .git --exclude node_modules --exclude venv --exclude .Private'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Enable command history
HISTFILE=~/.zsh_history  # Path to your history file
HISTSIZE=10000           # Number of history entries to keep in memory
SAVEHIST=10000           # Number of history entries to save to the file
setopt HIST_IGNORE_DUPS  # Ignore duplicate commands
setopt HIST_IGNORE_SPACE # Ignore commands starting with space
setopt SHARE_HISTORY     # Share history across sessions

# Aliases
[ -f "$XDG_CONFIG_HOME/shell/aliases" ] && source "$XDG_CONFIG_HOME/shell/aliases"

# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

DISABLE_AUTO_TITLE=true # Remove default terminal title

# # --- Load completion system ---
# autoload -Uz compinit
# compinit
#
# # Optional: enable completion caching
# zstyle ':completion::complete:*' use-cache on
# zstyle ':completion::complete:*' cache-path ~/.zsh/cache
#
# # Optional: case-insensitive + partial matching
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*'
#
# # Optional: enable interactive menu with arrow keys
# zstyle ':completion:*' menu select

# --- Load plugins ---
if [ -f "$XDG_CONFIG_HOME/shell/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$XDG_CONFIG_HOME/shell/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Custom Functions
[ -f "$XDG_CONFIG_HOME/shell/custom_functions" ] && source "$XDG_CONFIG_HOME/shell/custom_functions"

# Prompt
PS1='%F{blue}%~ %(?.%F{green}.%F{red})>%f '

