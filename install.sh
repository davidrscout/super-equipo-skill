#!/usr/bin/env bash
# Instala la skill super-equipo y sus agentes en ~/.claude
#
#   ./install.sh                          todo: 24 leads + 210 especialistas
#   ./install.sh --solo-leads             solo los 24 leads
#   ./install.sh --areas backend,qa       leads + especialistas de esas areas
#
# Motivo de las opciones: Claude Code carga la description de cada agente en el
# system prompt de TODAS las sesiones. 234 agentes son ~100 KB permanentes.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CLAUDE_HOME:-$HOME/.claude}"

MODE="todo"
AREAS=""
while [ $# -gt 0 ]; do
  case "$1" in
    --solo-leads) MODE="leads"; shift ;;
    --areas)      MODE="areas"; AREAS="${2:-}"; shift 2 ;;
    --areas=*)    MODE="areas"; AREAS="${1#*=}"; shift ;;
    -h|--help)    sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Opcion desconocida: $1 (usa --help)" >&2; exit 2 ;;
  esac
done

if [ "$MODE" = "areas" ] && [ -z "$AREAS" ]; then
  echo "--areas necesita una lista separada por comas, p. ej. --areas backend,frontend" >&2
  exit 2
fi

mkdir -p "$DEST/skills" "$DEST/agents"
rm -rf "$DEST/skills/super-equipo"
cp -r "$SRC/skills/super-equipo" "$DEST/skills/"

# Lista explicita de areas. No se puede deducir del nombre: "bases-de-datos" y
# "datos-ml" llevan guiones, asi que equipo-bases-de-datos.md es un LEAD aunque
# tenga varios guiones. Adivinarlo por la forma del nombre es un bug.
ALL_AREAS="accesibilidad arquitecto automatizacion backend bases-de-datos datos-ml \
devops diseno documentacion embebido frontend i18n integraciones integrador legal \
movil producto qa redes rendimiento revisor seguridad seo web3"

is_lead() {  # $1 = basename sin .md
  for a in $ALL_AREAS; do [ "$1" = "equipo-$a" ] && return 0; done
  return 1
}

leads=0
esp=0
for f in "$SRC"/agents/equipo-*.md; do
  [ -e "$f" ] || continue
  base="$(basename "$f" .md)"

  if is_lead "$base"; then
    cp "$f" "$DEST/agents/"; leads=$((leads+1)); continue
  fi

  [ "$MODE" = "leads" ] && continue

  if [ "$MODE" = "areas" ]; then
    keep=0
    IFS=',' read -ra want <<< "$AREAS"
    for a in "${want[@]}"; do
      a="$(echo "$a" | tr -d ' ')"
      [ -n "$a" ] || continue
      case "$base" in "equipo-$a-"*) keep=1 ;; esac
    done
    [ "$keep" -eq 1 ] || continue
  fi
  cp "$f" "$DEST/agents/"; esp=$((esp+1))
done

echo "OK  Skill instalada en $DEST/skills/super-equipo"
echo "OK  $leads leads y $esp especialistas instalados en $DEST/agents"
[ "$MODE" = "todo" ] || echo "    (instalacion parcial: modo '$MODE'${AREAS:+ -> $AREAS})"
echo "Reinicia Claude Code y comprueba con /skills y /agents."
