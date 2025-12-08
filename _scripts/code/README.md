# VS Code-based IDE Management Scripts

Scripts for managing settings, keybindings, and extensions across VS Code, Cursor, and Antigravity IDEs.

## Overview

These scripts help you:
- **Sync settings and keybindings** across all three IDEs using a master configuration
- **Track extensions** as portable text files (instead of large binary folders)
- **Set up new machines** quickly with your preferred IDE configuration

## Directory Structure

```
~/dotfiles/
├── master_code/              # Master settings (source of truth)
│   ├── settings.json
│   └── keybindings.json
├── vscode/                   # VS Code stow package
├── cursor/                   # Cursor stow package
├── antigravity/             # Antigravity stow package
├── vscode-extensions.txt    # VS Code extension list
├── cursor-extensions.txt    # Cursor extension list
└── antigravity-extensions.txt  # Antigravity extension list
```

## Scripts

### 1. Settings & Keybindings Management

#### `setup-ide-settings.sh`
Manages settings and keybindings synchronization across IDEs.

**Commands:**
```bash
# Setup internal symlinks (run once after git clone)
./setup-ide-settings.sh setup

# Apply settings to system (backs up existing files)
./setup-ide-settings.sh stow

# Remove stowed settings
./setup-ide-settings.sh unstow

# Refresh symlinks (unstow + stow)
./setup-ide-settings.sh restow

# Verify setup is correct
./setup-ide-settings.sh verify
```

**How it works:**
- All three IDEs share the same `settings.json` and `keybindings.json` from `master_code/`
- Uses relative symlinks (portable across machines)
- Stow creates final symlinks from system to dotfiles
- Automatically backs up existing settings before stowing

---

### 2. Extension Management

#### `export-extensions.sh`
Export currently installed extensions to text files.

**Usage:**
```bash
./export-extensions.sh
```

**When to use:**
- After installing new extensions manually
- Before pushing dotfiles changes
- To update your extension lists

**Output:**
- `~/dotfiles/vscode-extensions.txt`
- `~/dotfiles/cursor-extensions.txt`
- `~/dotfiles/antigravity-extensions.txt`

---

#### `import-extensions.sh`
Install extensions from text files (fresh install).

**Usage:**
```bash
# Install all IDE extensions
./import-extensions.sh all

# Install for specific IDE
./import-extensions.sh vscode
./import-extensions.sh cursor
./import-extensions.sh antigravity
```

**When to use:**
- Fresh machine setup
- After cloning dotfiles
- Clean install scenario

---

#### `sync-extensions.sh`
Install missing extensions and update lists (non-destructive).

**Usage:**
```bash
# Sync all IDEs
./sync-extensions.sh all

# Sync specific IDE
./sync-extensions.sh vscode
./sync-extensions.sh cursor
./sync-extensions.sh antigravity
```

**When to use:**
- Daily workflow
- Keep extensions in sync across machines
- Update lists after manual installs

**What it does:**
- ✅ Installs missing extensions from list
- ✅ Updates extension list with current state
- ❌ Does NOT remove extra extensions

---

#### `override-extensions.sh`
Make IDE match the list exactly (destructive).

**Usage:**
```bash
# Override all IDEs
./override-extensions.sh all

# Override specific IDE
./override-extensions.sh vscode
./override-extensions.sh cursor
./override-extensions.sh antigravity
```

**When to use:**
- Reset to exact list
- Clean up unwanted extensions
- Enforce consistency

**What it does:**
- ✅ Installs missing extensions from list
- ⚠️ **REMOVES** extensions not in list
- ✅ Makes IDE match list exactly

---

## Workflows

### Initial Setup (New Machine)

```bash
# 1. Clone dotfiles
git clone <your-repo> ~/dotfiles
cd ~/dotfiles

# 2. Setup internal symlinks
./scripts/code/setup-ide-settings.sh setup

# 3. Apply settings to system
./scripts/code/setup-ide-settings.sh stow

# 4. Install extensions
./scripts/code/import-extensions.sh all

# 5. Verify everything
./scripts/code/setup-ide-settings.sh verify
```

### Daily Workflow

```bash
# After installing new extensions manually
./scripts/code/export-extensions.sh

# After pulling dotfiles changes
./scripts/code/sync-extensions.sh all

# Commit changes
git add *-extensions.txt master_code/
git commit -m "Update IDE configuration"
git push
```

### Updating Master Settings

The master settings are in `~/dotfiles/master_code/`. To update:

```bash
# 1. Edit master settings
vim ~/dotfiles/master_code/settings.json

# 2. Changes automatically reflect in all IDEs (via symlinks)
# No need to restow unless you want to verify

# 3. Commit changes
git add master_code/
git commit -m "Update IDE settings"
git push
```

### Reset to Clean State

```bash
# Reset extensions to match lists exactly
./scripts/code/override-extensions.sh all

# Refresh settings symlinks
./scripts/code/setup-ide-settings.sh restow
```

## IDE-Specific Notes

### VS Code
- CLI command: `code`
- Extensions: `~/.vscode/extensions/`
- Settings: `~/Library/Application Support/Code/User/`

### Cursor
- CLI command: `cursor`
- Extensions: `~/.cursor/extensions/`
- Settings: `~/Library/Application Support/Cursor/User/`

### Antigravity
- CLI command: `agy`
- Extensions: `~/.antigravity/extensions/`
- Settings: `~/Library/Application Support/Antigravity/User/`

## Tips

1. **Keep extensions separate per IDE** - Use different extension lists for IDE-specific features
2. **Share settings via master_code** - All IDEs use the same settings for consistency
3. **Use sync for daily work** - `sync-extensions.sh` is safe and non-destructive
4. **Use override carefully** - `override-extensions.sh` will remove extensions not in your list
5. **Commit regularly** - Keep extension lists and settings in sync with git

## Troubleshooting

### Symlinks not working
```bash
./scripts/code/setup-ide-settings.sh setup
./scripts/code/setup-ide-settings.sh verify
```

### Settings not applying
```bash
# Restow to refresh symlinks
./scripts/code/setup-ide-settings.sh restow
```

### Extensions out of sync
```bash
# Export current state
./scripts/code/export-extensions.sh

# Or sync from lists
./scripts/code/sync-extensions.sh all
```

### Clean slate
```bash
# Unstow everything
./scripts/code/setup-ide-settings.sh unstow

# Remove all extensions
./scripts/code/override-extensions.sh all

# Restow
./scripts/code/setup-ide-settings.sh stow
```

## Contributing

When adding new scripts to this directory:
1. Make them executable: `chmod +x script-name.sh`
2. Follow the naming convention: `action-target.sh`
3. Include help text with `--help` flag
4. Update this README with usage examples
