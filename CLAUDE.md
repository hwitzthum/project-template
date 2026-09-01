# project-template (aktives Profil: landingpage-fabrik)

## Befehle
- Einzige Prüfung: `./scripts/verify.sh` (exit 0 = fertig)
- (weitere Befehle trägt der Initializer ein — z.B. dev, build, new)

## Nicht-offensichtliche Konventionen
- Der Nutzer ist kein Entwickler. Erkläre Entscheidungen in
  docs/state/decisions.md in Alltagssprache, nie nur im Code.
- Tech-Entscheidungen triffst du selbst; Business-Fragen (Texte, Ziel,
  Rechtliches) stellst du IMMER, bevor du rätst.
- Keine externen Dienste (Formular, Analytics) ohne Eintrag in decisions.md
  mit Kosten und Datenschutz-Folge.

## Bekannte Fallen
- (leer — wächst durch Erfahrung, nicht durch Vorhersage)

## Projektzustand
- Profil (was gebaut wird): docs/profil/ · Briefs: docs/briefs/
- Status: docs/state/features.md · Entscheidungen: docs/state/decisions.md
- Letzte Übergabe: docs/state/handoff.md
- Aufgaben: docs/tasks/ (bereit: ./scripts/next-tasks.sh)

## Sitzungsstart
- Der Projektzustand (./scripts/state-summary.sh) wird per SessionStart-Hook
  automatisch eingespielt — bei Start, /clear und nach Komprimierung. Bei
  Bedarf erneut ausführen.
- Am Ende docs/state/handoff.md aktualisieren (max. 30 Zeilen), inkl.
  Abschnitt "Für den Auftraggeber zu prüfen"; pro abgeschlossener Aufgabe eine
  Zeile an docs/state/metrics.csv anhängen.
