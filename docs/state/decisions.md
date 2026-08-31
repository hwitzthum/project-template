# Entscheidungen

<!-- Jede Tech-Entscheidung: Was / Warum in Alltagssprache / Folge für den Auftraggeber.
     Wird bei der Initialisierung gefüllt und danach bei jeder neuen Entscheidung ergänzt. -->

## 2026-08-31 — Projektwissen aus der Initialisierungs-Anleitung ins Profil verschoben

- **Was:** Die Anleitung für die Projekt-Initialisierung
  (docs/templates/initializer-prompt.md) enthielt Landingpage-Details
  (z.B. HTML-Prüfung, Befehl "new", Gruppe "Fabrik"). Diese Details
  stehen jetzt in einer neuen Profil-Datei docs/profil/technik.md;
  die Anleitung selbst ist projektunabhängig und verweist nur noch dorthin.
- **Warum:** Das Startkit trennt "Kern" (gilt für jedes Projekt) von
  "Profil" (gilt für dieses Projekt). Die Anleitung gehörte zum Kern,
  enthielt aber Profil-Wissen — bei einem Profilwechsel hätte sie
  weiterhin Landingpage-Anweisungen gegeben.
- **Folge für den Auftraggeber:** Keine Kosten, kein Aufwand. Wer später
  ein anderes Projekt mit diesem Startkit baut, tauscht nur den Ordner
  docs/profil/ — die Anleitung passt dann automatisch.
