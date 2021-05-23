set CONFIG $HOME/dotfiles
set PATH $PATH $CONFIG/scripts
set PATH $PATH $HOME/.cargo/bin

set -Ux EDITOR nvim

starship init fish | source

# >>> conda initialize >>>
eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
