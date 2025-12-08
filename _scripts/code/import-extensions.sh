#!/bin/bash
#
# Install VS Code-based IDE extensions from text files
# Usage: ./import-extensions.sh [vscode|cursor|antigravity|all]

DOTFILES_DIR="$HOME/dotfiles"
TARGET="${1:-all}"

install_extensions() {
    local ide=$1
    local cmd=$2
    local file="$DOTFILES_DIR/${ide}-extensions.txt"

    if [ ! -f "$file" ]; then
        echo "⚠ $file not found, skipping"
        return
    fi

    if ! command -v "$cmd" &> /dev/null; then
        echo "⚠ $cmd not found, skipping"
        return
    fi

    echo "Installing $ide extensions..."
    local count=0
    while IFS= read -r extension; do
        # Skip empty lines and comments
        [[ -z "$extension" || "$extension" =~ ^# ]] && continue

        echo "  Installing: $extension"
        "$cmd" --install-extension "$extension" --force
        ((count++))
    done < "$file"

    echo "✓ Installed $count $ide extensions"
    echo ""
}

case "$TARGET" in
    vscode)
        install_extensions "vscode" "code"
        ;;
    cursor)
        install_extensions "cursor" "cursor"
        ;;
    antigravity)
        install_extensions "antigravity" "agy"
        ;;
    all)
        install_extensions "vscode" "code"
        install_extensions "cursor" "cursor"
        install_extensions "antigravity" "agy"
        ;;
    *)
        echo "Usage: $0 [vscode|cursor|antigravity|all]"
        exit 1
        ;;
esac

echo "Done!"
