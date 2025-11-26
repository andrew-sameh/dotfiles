#!/bin/bash
#
# Setup IDE settings symlinks and stow packages
# Usage: ./setup-ide-settings.sh [setup|stow|unstow|restow]

DOTFILES_DIR="$HOME/dotfiles"
MASTER_DIR="$DOTFILES_DIR/master_code"

setup_symlinks() {
    echo "Setting up internal symlinks to master_code..."

    # VS Code
    local vscode_user="$DOTFILES_DIR/vscode/Library/Application Support/Code/User"
    mkdir -p "$vscode_user"
    cd "$vscode_user"
    ln -sf ../../../../../master_code/settings.json settings.json
    ln -sf ../../../../../master_code/keybindings.json keybindings.json
    echo "✓ VS Code symlinks created"

    # Cursor
    local cursor_user="$DOTFILES_DIR/cursor/Library/Application Support/Cursor/User"
    mkdir -p "$cursor_user"
    cd "$cursor_user"
    ln -sf ../../../../../master_code/settings.json settings.json
    ln -sf ../../../../../master_code/keybindings.json keybindings.json
    echo "✓ Cursor symlinks created"

    # Antigravity
    local antigravity_user="$DOTFILES_DIR/antigravity/Library/Application Support/Antigravity/User"
    mkdir -p "$antigravity_user"
    cd "$antigravity_user"
    ln -sf ../../../../../master_code/settings.json settings.json
    ln -sf ../../../../../master_code/keybindings.json keybindings.json
    echo "✓ Antigravity symlinks created"

    echo ""
}

stow_packages() {
    echo "Stowing IDE settings..."
    cd "$DOTFILES_DIR"

    # Backup existing settings
    for ide in vscode cursor antigravity; do
        case $ide in
            vscode)
                local user_dir="$HOME/Library/Application Support/Code/User"
                ;;
            cursor)
                local user_dir="$HOME/Library/Application Support/Cursor/User"
                ;;
            antigravity)
                local user_dir="$HOME/Library/Application Support/Antigravity/User"
                ;;
        esac

        if [ -f "$user_dir/settings.json" ] && [ ! -L "$user_dir/settings.json" ]; then
            echo "  Backing up existing $ide settings.json to settings.json.backup"
            mv "$user_dir/settings.json" "$user_dir/settings.json.backup"
        fi

        if [ -f "$user_dir/keybindings.json" ] && [ ! -L "$user_dir/keybindings.json" ]; then
            echo "  Backing up existing $ide keybindings.json to keybindings.json.backup"
            mv "$user_dir/keybindings.json" "$user_dir/keybindings.json.backup"
        fi
    done

    # Stow packages
    stow -v vscode
    stow -v cursor
    stow -v antigravity

    echo ""
    echo "✓ IDE settings stowed successfully"
    echo ""
}

unstow_packages() {
    echo "Unstowing IDE settings..."
    cd "$DOTFILES_DIR"

    stow -D -v vscode 2>/dev/null || true
    stow -D -v cursor 2>/dev/null || true
    stow -D -v antigravity 2>/dev/null || true

    echo "✓ IDE settings unstowed"
    echo ""
}

restow_packages() {
    echo "Restowing IDE settings..."
    unstow_packages
    stow_packages
}

verify_setup() {
    echo "Verifying setup..."

    for ide in vscode cursor antigravity; do
        case $ide in
            vscode)
                local user_dir="$HOME/Library/Application Support/Code/User"
                ;;
            cursor)
                local user_dir="$HOME/Library/Application Support/Cursor/User"
                ;;
            antigravity)
                local user_dir="$HOME/Library/Application Support/Antigravity/User"
                ;;
        esac

        if [ -L "$user_dir/settings.json" ]; then
            local target=$(readlink "$user_dir/settings.json")
            echo "✓ $ide settings.json -> $target"
        else
            echo "✗ $ide settings.json is not a symlink"
        fi
    done

    echo ""
}

case "${1:-setup}" in
    setup)
        setup_symlinks
        echo "Internal symlinks created. Run './setup-ide-settings.sh stow' to apply."
        ;;
    stow)
        stow_packages
        verify_setup
        ;;
    unstow)
        unstow_packages
        ;;
    restow)
        restow_packages
        verify_setup
        ;;
    verify)
        verify_setup
        ;;
    *)
        echo "Usage: $0 [setup|stow|unstow|restow|verify]"
        echo ""
        echo "Commands:"
        echo "  setup   - Create internal symlinks to master_code (safe, doesn't modify system)"
        echo "  stow    - Apply settings to system using stow (backs up existing files)"
        echo "  unstow  - Remove stowed settings from system"
        echo "  restow  - Unstow then stow (refresh symlinks)"
        echo "  verify  - Check if symlinks are correctly set up"
        exit 1
        ;;
esac
