#!/bin/bash
#
# Sync extensions - Install missing extensions and update the list with current state
# Usage: ./sync-extensions.sh [vscode|cursor|antigravity|all]

DOTFILES_DIR="$HOME/dotfiles"
TARGET="${1:-all}"

sync_extensions() {
    local ide=$1
    local cmd=$2
    local file="$DOTFILES_DIR/${ide}-extensions.txt"

    if ! command -v "$cmd" &> /dev/null; then
        echo "⚠ $cmd not found, skipping"
        return
    fi

    echo "Syncing $ide extensions..."

    # Get currently installed extensions
    local installed=$($cmd --list-extensions 2>/dev/null | sort)

    # If extension list file exists, install missing ones
    if [ -f "$file" ]; then
        local missing=0
        while IFS= read -r extension; do
            # Skip empty lines and comments
            [[ -z "$extension" || "$extension" =~ ^# ]] && continue

            # Check if extension is installed
            if ! echo "$installed" | grep -q "^${extension}$"; then
                echo "  + Installing: $extension"
                "$cmd" --install-extension "$extension" --force 2>/dev/null
                ((missing++))
            fi
        done < "$file"

        if [ $missing -eq 0 ]; then
            echo "  ✓ All extensions already installed"
        else
            echo "  ✓ Installed $missing missing extension(s)"
        fi
    else
        echo "  ℹ No extension list found, will create one"
    fi

    # Update the extension list with current state
    echo "  Updating extension list..."
    $cmd --list-extensions > "$file" 2>/dev/null
    local total=$(wc -l < "$file" | tr -d ' ')
    echo "  ✓ Extension list updated ($total extensions)"
    echo ""
}

case "$TARGET" in
    vscode)
        sync_extensions "vscode" "code"
        ;;
    cursor)
        sync_extensions "cursor" "cursor"
        ;;
    antigravity)
        sync_extensions "antigravity" "agy"
        ;;
    all)
        sync_extensions "vscode" "code"
        sync_extensions "cursor" "cursor"
        sync_extensions "antigravity" "agy"
        ;;
    *)
        echo "Usage: $0 [vscode|cursor|antigravity|all]"
        exit 1
        ;;
esac

echo "Done! Extension lists are now in sync with your IDEs."
