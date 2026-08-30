#!/usr/bin/env bash
# state-summary.sh — Projektzustand in <300 Tokens. Sitzungsstart-Protokoll.
# PLATZHALTER: Der Initializer ersetzt dieses Skript (Feature-Zähler, READY-Tasks,
# Kopf des handoff.md). Bis dahin: nur Branch + Handoff.
set -uo pipefail
echo "branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '-')"
echo "features: Initialisierung noch nicht ausgeführt"
echo "--- handoff ---"
[ -f docs/state/handoff.md ] && head -30 docs/state/handoff.md || echo "(kein handoff.md)"
