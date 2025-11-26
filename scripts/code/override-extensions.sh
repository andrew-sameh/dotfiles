#!/bin/bash
#
# Override extensions - Make IDE match the list exactly (install missing, remove extras)
# Usage: ./override-extensions.sh [vscode|cursor|antigravity|all]

DOTFILES_DIR="$HOME/dotfiles"
TARGET="${1:-all}"

override_extensions() {
    local ide=$1
    local cmd=$2
    local file="$DOTFILES_DIR/${ide}-extensions.txt"

    if ! command -v "$cmd" &> /dev/null; then
        echo "⚠ $cmd not found, skipping"
        return
    fi

    if [ ! -f "$file" ]; then
        echo "⚠ $file not found, skipping"
        return
    fi

    echo "Overriding $ide extensions to match list..."

    # Read target extensions from file into array
    local -a target_extensions
    while IFS= read -r extension; do
        # Skip empty lines and comments
        [[ -z "$extension" || "$extension" =~ ^# ]] && continue
        target_extensions+=("$extension")
    done < "$file"

    # Get currently installed extensions
    local installed=$($cmd --list-extensions 2>/dev/null | sort)

    # Install missing extensions
    local installed_count=0
    for extension in "${target_extensions[@]}"; do
        if ! echo "$installed" | grep -q "^${extension}$"; then
            echo "  + Installing: $extension"
            "$cmd" --install-extension "$extension" --force 2>/dev/null
            ((installed_count++))
        fi
    done

    if [ $installed_count -eq 0 ]; then
        echo "  ✓ All target extensions already installed"
    else
        echo "  ✓ Installed $installed_count extension(s)"
    fi

    # Remove extensions not in the target list
    local removed_count=0
    while IFS= read -r extension; do
        # Check if this extension is in our target list
        local found=0
        for target in "${target_extensions[@]}"; do
            if [ "$extension" = "$target" ]; then
                found=1
                break
            fi
        done

        # If not in target list, uninstall it
        if [ $found -eq 0 ]; then
            echo "  - Removing: $extension"
            "$cmd" --uninstall-extension "$extension" 2>/dev/null
            ((removed_count++))
        fi
    done <<< "$installed"

    if [ $removed_count -eq 0 ]; then
        echo "  ✓ No extra extensions to remove"
    else
        echo "  ✓ Removed $removed_count extension(s)"
    fi

    echo "  ✓ $ide now matches the extension list exactly (${#target_extensions[@]} extensions)"
    echo ""
}

case "$TARGET" in
    vscode)
        override_extensions "vscode" "code"
        ;;
    cursor)
        override_extensions "cursor" "cursor"
        ;;
    antigravity)
        override_extensions "antigravity" "agy"
        ;;
    all)
        override_extensions "vscode" "code"
        override_extensions "cursor" "cursor"
        override_extensions "antigravity" "agy"
        ;;
    *)
        echo "Usage: $0 [vscode|cursor|antigravity|all]"
        exit 1
        ;;
esac

echo "Done! All IDEs now match their extension lists."
