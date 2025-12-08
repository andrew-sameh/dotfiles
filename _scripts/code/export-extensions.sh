#!/bin/bash
#
# Export VS Code-based IDE extensions to text files
# Usage: ./export-extensions.sh

DOTFILES_DIR="$HOME/dotfiles"

echo "Exporting extensions..."

# VS Code
if command -v code &> /dev/null; then
    code --list-extensions > "$DOTFILES_DIR/vscode-extensions.txt"
    echo "✓ VS Code extensions exported ($(wc -l < "$DOTFILES_DIR/vscode-extensions.txt" | tr -d ' ') extensions)"
else
    echo "⚠ VS Code not found, skipping"
fi

# Cursor
if command -v cursor &> /dev/null; then
    cursor --list-extensions > "$DOTFILES_DIR/cursor-extensions.txt"
    echo "✓ Cursor extensions exported ($(wc -l < "$DOTFILES_DIR/cursor-extensions.txt" | tr -d ' ') extensions)"
else
    echo "⚠ Cursor not found, skipping"
fi

# Antigravity
if command -v agy &> /dev/null; then
    agy --list-extensions > "$DOTFILES_DIR/antigravity-extensions.txt"
    echo "✓ Antigravity extensions exported ($(wc -l < "$DOTFILES_DIR/antigravity-extensions.txt" | tr -d ' ') extensions)"
else
    echo "⚠ Antigravity not found, skipping"
fi

echo ""
echo "Done! Extension lists saved in $DOTFILES_DIR"
