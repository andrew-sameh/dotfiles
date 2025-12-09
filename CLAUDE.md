# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles managed with GNU Stow for macOS (Apple Silicon - Homebrew at `/opt/homebrew`). Configurations are user/machine-agnostic using `$HOME` for portability.

## Essential Commands

### Stow Operations

```bash
stow <package>              # Create symlinks to $HOME (e.g., stow zsh, stow nvim)
stow -D <package>           # Remove symlinks
stow -R <package>           # Refresh symlinks after updates
stow -nv <package>          # Dry run with verbose output
stow --adopt <package>      # Adopt existing files into stow package
stow */                     # Stow all packages
```

Note: `.stowrc` sets `--target=$HOME/` by default.

### Homebrew Package Management

```bash
brew bundle --file=_brew_air/Brewfile   # Install from Brewfile (MacBook Air)
brew bundle --file=_brew_mini/Brewfile  # Install from Brewfile (Mac mini)
brew bundle dump --force --describe --file=~/Brewfile  # Export current packages
```

### IDE Settings & Extensions

```bash
# Initial setup
./_scripts/code/setup-ide-settings.sh setup   # Create internal symlinks
./_scripts/code/setup-ide-settings.sh stow    # Apply to system
./_scripts/code/import-extensions.sh all      # Install extensions

# Daily workflow
./_scripts/code/export-extensions.sh          # Export current extensions
./_scripts/code/sync-extensions.sh all        # Install missing extensions
```

## Architecture

### Directory Structure

Each top-level directory is a stow package that mirrors `$HOME` structure:
- `zsh/`, `nvim/`, `tmux/`, `git/` - Core development configs
- `vscode/`, `cursor/`, `antigravity/`, `zed/` - IDE configs
- `master_code/` - Shared IDE settings (source of truth for VS Code/Cursor/Antigravity)
- `_brew_air/`, `_brew_mini/` - Machine-specific Brewfiles
- `_scripts/` - Automation scripts

### Machine Detection

The `.zshrc` detects machine via hostname and sets `$MACHINE` to `air`, `mini`, or `unknown`. Use the appropriate Brewfile for each machine.

### IDE Settings Sync

Master settings in `master_code/` are shared across VS Code, Cursor, and Antigravity via symlinks. Run `setup-ide-settings.sh setup` after cloning to create internal symlinks.

### Key Tool Configurations

- **Neovim**: LazyVim framework, plugins in `lua/plugins/`, language configs in `lua/plugins/lang/`
- **Tmux**: TPM plugin manager, Catppuccin theme, prefix `Ctrl+b` (local) / `Ctrl+a` (SSH)
- **Zsh**: Starship prompt, plugins via Homebrew, integrations with zoxide, fzf, pyenv, nvm

### Files Ignored by Stow

Per `.stow-global-ignore`: `README.*`, `LICENSE.*`, `.git*`, `.DS_Store`, `TODO.*`, `*.secrets.*`

## Conventions

### Adding New Stow Packages

1. Create directory: `mkdir myapp`
2. Mirror `$HOME` structure inside (e.g., `myapp/.config/myapp/config.yaml`)
3. Run: `stow myapp`

### Catppuccin Theme

Used across Neovim, Tmux, k9s, Warp, Yazi, and Zed.
