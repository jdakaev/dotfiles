# TODO: add where I stole this from.
DIRS=(
    "$HOME/Documents"
    "$HOME/.local/bin"
    "$HOME/dotfiles/.config"
    "$HOME/dotfiles"
    #"$HOME/.local/bin"
    "$HOME/notes/"
    #"$HOME/.config/"
)

if [[ $# -ne 0 ]]; then
    DIRS=$@
fi

selected=$(find "${DIRS[@]}" -mindepth 0 -maxdepth 1 -type d | fuzzel --dmenu --width=80 --lines=20)

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name"; then
    tmux new-session -A -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"
