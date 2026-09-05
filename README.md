# project-template

Startkit für Projekte mit Claude Code — Zustand in Dateien, eine Prüfung,
Schichtarbeit zwischen Sitzungen. Mitgeliefertes Profil: **Landingpage-Fabrik**.

**So startest du:**

1. Oben rechts «Use this template» → «Create a new repository».
2. Dein neues Repo auf den Rechner holen (GitHub Desktop → «Clone repository»).
3. `KURSANLEITUNG.docx` lesen (Quelle: `docs/KURSANLEITUNG.md`) — sie führt dich Schritt für Schritt.

Für ein anderes Projekt als Landingpages: `docs/profil/README.md`.

---

## Scripts — Zusammenarbeit mit Claude

Dieses Projekt steuert Claude durch Bash-Scripts. Jedes Script ist ein Vertrag: Claude kann die Befehle ausführen, der Output bestimmt was passiert.

### Hauptscripts (für dich und Claude)

**`./scripts/verify.sh`** — Die einzige Prüfung  
Läuft beim Commit (Hook) und vor jeder Aufgaben-Fertigstellung. Exit-Code 0 = alles bestanden.

- Letzte Zeile ist immer `verify: GREEN` oder `verify: RED`
- Was geprüft wird: definiert in `docs/profil/technik.md` (Stack, Linter, Tests)
- **Placeholder:** Initial nur `exit 0` — der Initializer ersetzt es später durch echte Prüfungen

**`./scripts/finish-task.sh <id> [modell] [runden] [tokens]`** — Aufgaben abschliessen  
Der _einzige_ Weg, eine Aufgabe als erledigt zu markieren.

```bash
./scripts/finish-task.sh aufgaben-001
```

Was es macht:

1. Vollständiges `verify.sh` ausführen
2. Alle Akzeptanz-Tests der Aufgabe ausführen (aus dem `acceptance:`-Feld im Frontmatter)
3. Status in `docs/tasks/aufgaben-001.md` auf `done` setzen
4. Eine Zeile in `docs/state/metrics.csv` schreiben (für Statistik)
5. Alles committen

Wenn eine Prüfung rot ist: Das Script ändert **nichts** (exit 1). Ein normaler Commit reicht nicht — nur dieser Befehl ist der Zustandsübergang.

**`./scripts/next-tasks.sh`** — Verfügbare Aufgaben  
Zeigt Tasks, deren Abhängigkeiten alle erfüllt sind (Vorlage — der Initializer macht es später intelligent).

**`./scripts/state-summary.sh`** — Projektzustand in ≤250 Token  
Läuft automatisch beim Sitzungsstart (Hook in `.claude/settings.json`). Ausgabe:

- Aktueller Branch
- Feature-Zähler (`n/m Features fertig`)
- Erste 30 Zeilen von `docs/state/handoff.md`

Dieser Output steht direkt am Anfang jeder neuen Sitzung mit Claude — er weiss sofort, wo der Stand ist.

### Schutz-Hooks (automatisch, laufen im Hintergrund)

**`bash-guard.sh`** — Blockiert unsichere Bash-Befehle  
Claude darf **nicht**:

- Hochladen: `git push`, `curl`, `wget`
- Rekursiv löschen: `rm -r…`
- Ungespeicherte Arbeit verwerfen: `git reset --hard`, `git clean -f`, `git restore`

Wenn Claude so einen Befehl versucht, blockiert das Script ihn und sagt warum. Du machst solche Befehle selbst (oder über `! befehl` im Terminal).

**`stop-guard.sh`** — Erzwingt Handoff-Übergabe  
Wenn Claude seit Sitzungsbeginn Produktarbeit committet hat, darf die Sitzung nicht enden, bis **`docs/state/handoff.md` aktualisiert ist**. Das Script blockiert das Sitzungsende und sagt:

```
Stopp blockiert: n Commit(s) seit Sitzungsbeginn.
Jetzt handoff.md aktualisieren und committen — danach beenden.
```

Vorlage: `docs/templates/handoff-template.md` (max. 30 Zeilen, inkl. «Für den Auftraggeber zu prüfen»).

Ausnahme: Commits, die **nur** Startkit-Dateien berühren (scripts/, .claude/, docs/templates/, CLAUDE.md) — dann läuft alles unangetastet.

**`commit-gate.sh`** — Prüfung vor jedem Commit  
Läuft als Pre-Commit-Hook. Führt `./scripts/verify.sh --quick` aus — schnelle Prüfungen (Tests, Linter). Wenn rot: Commit blockiert.

### Wartungs-Scripts

**`session-mark.sh`** — Sitzungsanfang markieren  
Läuft als SessionStart-Hook, speichert den aktuellen Commit-Hash in `.claude/session-head` — das ist die Marke für `stop-guard.sh`, um zu erkennen, was seit der Sitzung neu committet wurde.

**`autoformat.sh`** — Code formatieren  
Stack-spezifisch (wird vom Initializer übernommen). Beispiel: `prettier` für JS/React, `black` für Python.

---

## Projektzustand — Dateien

- **`docs/profil/`** — _Was_ gebaut wird (Ziele, Design, technische Anforderungen)
- **`docs/briefs/`** — Aufträge an Claude (Einzelbriefe für Aufgaben)
- **`docs/state/`**
  - `features.md` — Feature-Liste (`[ ] Feature A` / `[x] Feature B`)
  - `decisions.md` — Entscheidungen und Begründungen (extern sichtbar)
  - `handoff.md` — Übergabe zwischen Sitzungen (was läuft, was der Auftraggeber prüfen soll)
  - `metrics.csv` — Aufgaben-Statistik (automatisch gefüllt von `finish-task.sh`)
- **`docs/tasks/`** — Aufgaben (je eine `.md`, Frontmatter mit Status)

---

## Zusammenhang: Claude, Scripts, Hooks

```
Claude startet eine Sitzung
  ↓ SessionStart-Hook
  └─→ state-summary.sh → Output in seinen Kontext

Claude schreibt Code und committet
  ↓ Pre-Commit-Hook
  └─→ commit-gate.sh → verify.sh --quick
      Wenn rot: Commit blockiert

Claude beendet eine Aufgabe
  ↓ (Claude ruft auf)
  └─→ finish-task.sh <id>
      - verify.sh (voll)
      - acceptance-Befehle
      - status: done
      - metrics.csv
      - Commit

Claude versucht zu beenden
  ↓ Stop-Hook
  └─→ stop-guard.sh
      Wenn commits aber kein handoff.md: blockiert
```
