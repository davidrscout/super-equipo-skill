#!/usr/bin/env bash
# Instala la skill super-equipo y sus 24 agentes en ~/.claude
set -euo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CLAUDE_HOME:-$HOME/.claude}"

mkdir -p "$DEST/skills" "$DEST/agents"
cp -r "$SRC/skills/super-equipo" "$DEST/skills/"
cp "$SRC"/agents/equipo-*.md "$DEST/agents/"

n=$(ls -1 "$DEST"/agents/equipo-*.md | wc -l)
echo "OK  Skill instalada en $DEST/skills/super-equipo"
echo "OK  $n agentes equipo-* instalados en $DEST/agents"
echo "Reinicia Claude Code y comprueba con /skills y /agents."
