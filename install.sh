#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"

TARGETS=(
    "$HOME/.copilot/skills"
    "$HOME/.claude/skills"
)

for target in "${TARGETS[@]}"; do
    mkdir -p "$target"
    cp -r "$SKILLS_SRC"/* "$target"/
    echo "Installed skills to $target"
done
