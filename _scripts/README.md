# Dotfiles Scripts

Automation scripts for managing dotfiles and development environment.

## Directory Structure

```
scripts/
├── code/              # VS Code-based IDE management scripts
│   ├── README.md     # Detailed documentation
│   ├── setup-ide-settings.sh
│   ├── export-extensions.sh
│   ├── import-extensions.sh
│   ├── sync-extensions.sh
│   └── override-extensions.sh
└── README.md         # This file
```

## Available Script Categories

### Code IDEs (`code/`)

Scripts for managing VS Code, Cursor, and Antigravity:
- **Settings sync** across all three IDEs
- **Extension management** (export, import, sync, override)
- **Setup automation** for new machines

See [code/README.md](code/README.md) for detailed documentation.

**Quick Start:**
```bash
# Setup settings and keybindings
./code/setup-ide-settings.sh stow

# Export current extensions
./code/export-extensions.sh

# Sync extensions from lists
./code/sync-extensions.sh all
```

## Adding New Scripts

When adding scripts to this directory:

1. **Organize by category** - Create subdirectories for different purposes
2. **Make executable** - `chmod +x script-name.sh`
3. **Add documentation** - Include a README.md in each subdirectory
4. **Follow conventions:**
   - Use kebab-case: `action-target.sh`
   - Include help text: `--help` flag
   - Add comments and usage examples
   - Handle errors gracefully

## Future Categories

Ideas for additional script categories:
- `system/` - System configuration scripts
- `homebrew/` - Homebrew management
- `git/` - Git utilities
- `backup/` - Backup and restore scripts
