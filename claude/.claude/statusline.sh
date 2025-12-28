#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract data from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name')
output_style=$(echo "$input" | jq -r '.output_style.name // "default"')
context_window=$(echo "$input" | jq -r '.context_window')

# Catppuccin Mocha colors (matching your Starship theme)
rosewater='\033[38;2;245;224;220m'
flamingo='\033[38;2;242;205;205m'
pink='\033[38;2;245;194;231m'
orange='\033[38;2;203;166;247m'
red='\033[38;2;243;139;168m'
maroon='\033[38;2;235;160;172m'
peach='\033[38;2;250;179;135m'
yellow='\033[38;2;249;226;175m'
green='\033[38;2;166;227;161m'
teal='\033[38;2;148;226;213m'
sky='\033[38;2;137;220;235m'
sapphire='\033[38;2;116;199;236m'
blue='\033[38;2;137;180;250m'
lavender='\033[38;2;180;190;254m'
text='\033[38;2;205;214;244m'
subtext1='\033[38;2;186;194;222m'
subtext0='\033[38;2;166;173;200m'
overlay2='\033[38;2;147;153;178m'
reset='\033[0m'

# Build status line (mimicking your Starship format)
output=""

# Shell indicator (zsh with lightning bolt)
output+=$(printf "${lavender}⚡${reset} ")

# Directory (shortened path with icon)
dir_name=$(basename "$cwd")
output+=$(printf "${blue}  ${dir_name} ${reset}")

# Git branch (if in git repo)
if cd "$cwd" 2>/dev/null && git rev-parse --git-dir >/dev/null 2>&1; then
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        output+=$(printf "${pink} ${branch} ${reset}")

        # Git status icons (matching your Starship config)
        if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
            modified=$(git status --porcelain 2>/dev/null | grep -c '^ M')
            untracked=$(git status --porcelain 2>/dev/null | grep -c '^??')

            [ "$modified" -gt 0 ] && output+=$(printf "${peach}!${modified} ${reset}")
            [ "$untracked" -gt 0 ] && output+=$(printf "${sky}?${untracked} ${reset}")
        fi
    fi
fi

# Python version (if in Python project)
if cd "$cwd" 2>/dev/null && [ -f "pyproject.toml" ] || [ -f "requirements.txt" ] || [ -f "setup.py" ]; then
    py_version=$(python3 --version 2>/dev/null | cut -d' ' -f2 | cut -d'.' -f1-2)
    [ -n "$py_version" ] && output+=$(printf "${yellow} ${py_version} ${reset}")
fi

# Model info (Claude-specific)
output+=$(printf "${teal} ${model} ${reset}")

# Output style (if not default)
if [ "$output_style" != "default" ]; then
    output+=$(printf "${flamingo}[${output_style}] ${reset}")
fi

# Context window percentage
usage=$(echo "$context_window" | jq '.current_usage')
if [ "$usage" != "null" ]; then
    current=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    size=$(echo "$context_window" | jq '.context_window_size')
    if [ "$current" != "null" ] && [ "$size" != "null" ] && [ "$size" -gt 0 ]; then
        pct=$((current * 100 / size))

        # Color code based on usage percentage
        if [ "$pct" -lt 50 ]; then
            ctx_color="$green"
        elif [ "$pct" -lt 75 ]; then
            ctx_color="$yellow"
        else
            ctx_color="$red"
        fi

        output+=$(printf "${ctx_color}${pct}%% ctx${reset}")
    fi
fi

# Print the final status line
printf "%b\n" "$output"
