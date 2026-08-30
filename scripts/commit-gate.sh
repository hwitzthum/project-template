#!/usr/bin/env bash
# commit-gate.sh — PreToolUse-Hook, läuft nur vor `git commit` (siehe
# .claude/settings.json, Feld "if"). Führt verify.sh --quick aus.
# Exit 2 = Commit wird blockiert (Hook-Vertrag von Claude Code); Exit 0 = frei.
set -uo pipefail
cat >/dev/null   # Hook-JSON auf stdin wird nicht benötigt
out=$(./scripts/verify.sh --quick 2>&1)
if [ $? -ne 0 ]; then
  echo "Commit blockiert — verify.sh --quick ist RED:" >&2
  echo "$out" | tail -n 20 >&2
  exit 2
fi
exit 0
