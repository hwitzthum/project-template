# Handoff — 2026-08-31

## Letzte Sitzung

- Kern/Profil-Trennung im Initializer-Prompt vollendet: Landingpage-Details
  aus docs/templates/initializer-prompt.md in die neue Profil-Datei
  docs/profil/technik.md verschoben; Prompt ist jetzt projektunabhängig.
- docs/profil/README.md (Tabelle, Interview-Prompt, Regeln) ergänzt,
  Entscheidung in docs/state/decisions.md dokumentiert.
- Alles über Branch nach main gemergt und gepusht (5ac0e04),
  Branch gelöscht. Arbeitsbaum sauber.

## Achtung nächste Sitzung

- Initialisierung noch NICHT ausgeführt. scripts/*.sh sind Platzhalter (exit 0).
- git push ist per deny-Regel in .claude/settings.json für den Agenten
  gesperrt (Absicht). Pushen macht der Auftraggeber selbst: "! git push".
- Vor der Initialisierung: ersten Brief in docs/briefs/ anlegen
  (Vorlage: docs/profil/brief-template.md).

## Für den Auftraggeber zu prüfen

- Ersten Brief schreiben.

## Vorgeschlagene nächste Aufgabe

- Initialisierung: docs/templates/initializer-prompt.md in neuer Sitzung ausführen.
