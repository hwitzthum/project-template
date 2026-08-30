# Profil — was dieses Projekt baut

Der Kern des Startkits (CLAUDE.md, scripts/, docs/state/, docs/templates/)
ist projektunabhängig. Alles, was ein konkretes Projekt ausmacht, liegt hier:

| Datei | Inhalt | Liest |
|---|---|---|
| `produkt.md` | Was gebaut wird, für wen, Stack-Vorgabe | Initializer |
| `fragenkatalog.md` | Die Mindestfragen vor der Zerlegung | Initializer |
| `brief-template.md` | Die Auftragsvorlage, die der Auftraggeber ausfüllt | Auftraggeber |
| `skills/` | Optionale Domänen-Skills mit Interview-Prompt zum Ausfüllen | Auftraggeber, dann Claude |

Das mitgelieferte Profil ist **Landingpage-Fabrik**.

## Ein neues Profil für ein anderes Projekt

Ersetze die vier Teile. Am einfachsten per Interview in Claude Code:

> Ich möchte ein neues Profil für dieses Startkit anlegen. Lies
> docs/profil/README.md und die vier bestehenden Profil-Dateien als Muster.
> Mein Projekt: <ein Satz>. Führe mich durch die Erstellung von produkt.md,
> fragenkatalog.md und brief-template.md — Frage für Frage, in
> Alltagssprache. Der Fragenkatalog muss Grenzen, Endzustände und Duplikate
> meiner Domäne abdecken. Frage mich, ob das Projekt eine Skill braucht
> (z.B. Design-, Fach- oder Tonalitätsregeln), und lege dann das Skill-Template
> plus Interview-Prompt in skills/ an. Kein Code.

Regeln für ein gutes Profil:
- `produkt.md`: Business-Sprache, 5–12 Zeilen. Stack nur, wenn vorgegeben.
- `fragenkatalog.md`: jede Frage mit benannten Optionen ("A, B oder C?").
  Keine offenen Themen — offene Themen erzeugen Aufsätze, keine Entscheidungen.
- `brief-template.md`: jeder Abschnitt eine Lücke, die sonst Nacharbeit wird.
  Immer mit Abschnitt "Nicht Teil davon".
- `skills/`: nur, wenn es Regeln gibt, die *anweisen* (verbieten, verorten,
  warnen). Beschreibendes ist eine Doku, keine Skill.
