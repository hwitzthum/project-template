#!/usr/bin/env bash
# autoformat.sh — PostToolUse-Hook (Edit|Write). Formatiert die bearbeitete
# Datei. Still bei Erfolg. Liest den Dateipfad aus dem Hook-JSON auf stdin
# (.tool_input.file_path); alternativ als Argument.
# Der Initializer ergänzt die Formatter (prettier etc.), sobald der Stack feststeht.
set -uo pipefail
f="${1:-}"
if [ -z "$f" ] && [ ! -t 0 ]; then
  f=$(sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1)
fi
[ -n "$f" ] || exit 0
case "$f" in
  *.ts|*.tsx|*.js|*.mjs|*.astro|*.css|*.json)
    command -v npx >/dev/null 2>&1 && [ -f package.json ] \
      && npx prettier --write "$f" >/dev/null 2>&1 || true ;;
esac
exit 0
