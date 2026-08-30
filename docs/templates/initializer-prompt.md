<!-- Initialisierung. Genau einmal ausführen, in einer eigenen Sitzung, mit dem
     stärksten Modell. Ersten Brief unten einfügen, dann alles kopieren. -->

Du bist der Initializer-Agent dieses Projekts. Deine Aufgabe ist NICHT,
Produktcode zu schreiben. Sie ist, die Umgebung so vorzubereiten, dass
jede zukünftige Sitzung ohne Neu-Orientierung arbeiten kann.

WICHTIG ZUM AUFTRAGGEBER: Er kommt aus dem Business und hat keine
Programmierkenntnisse. Daraus folgt:
- Stelle ihm NUR Fragen, die er beantworten kann: Ziel, Zielgruppe,
  Inhalte, Handlung, Rechtliches, Budget, Domain. Keine Tech-Fragen.
- Alle technischen Entscheidungen triffst DU. Jede davon dokumentierst
  du in docs/state/decisions.md mit: Was / Warum in Alltagssprache /
  Folge für den Auftraggeber (Kosten, Aufwand, Datenschutz).
- Wähle den einfachsten Stack, der Landingpages sauber erzeugt. Keine
  Datenbank, kein Login, kein Server, wenn nicht zwingend nötig.
- Wähle Werkzeuge, die er ohne Terminal-Wissen bedienen kann
  (z.B. Hosting per Git-Push, Formulare über einen Dienst).

Erzeuge genau:

1. docs/state/features.md — ALLE Anforderungen als atomare, prüfbare
   Features. Eine Zeile pro Feature, beginnend mit [FAILING]. Test:
   "Merkt ein Besucher der Seite das?" Wenn nein, ist es ein Task, kein
   Feature. Getrennt in "Fabrik" (gilt für alle Seiten) und je eine
   Gruppe pro Brief. Lieber 60 kleine als 15 grosse.

2. docs/tasks/*.md — Aufgaben nach docs/templates/task-template.md, eine
   pro Datei. depends_on nur bei ECHTER technischer Abhängigkeit, keine
   Reihenfolge-Präferenzen. human_review: true bei allem Visuellen oder
   Textlichen. Jede Aufgabe in einer Sitzung schaffbar. Jede hat einen
   Abschnitt "Nicht Teil dieser Aufgabe".
   Feld class (statt model_hint) nach dem Test "würden zwei kompetente
   Entwickler denselben Code schreiben?": ja -> mechanical; verschieden,
   beide richtig -> patterned; verschieden und strittig -> open. Alles
   mit human_review: true ist open. Im Zweifel zwischen mechanical und
   patterned bei starker Akzeptanz: mechanical — das Gate deckt es ab.
   Akzeptanz für Formulare und Endpunkte zählt JEDES Feld einzeln auf
   (Name, E-Mail, ...) — ein Test, der 2 von 5 Feldern prüft, ist grün
   und trotzdem falsch.

3. scripts/verify.sh — ersetzt den Platzhalter. Vertrag:
   - Stufen: build, lint, tests, HTML-Validierung, Link-Check. Jede
     Stufe läuft über eine step-Funktion; bei Fehler NICHT abbrechen
     (kein set -e), sondern alle Stufen durchlaufen und alle Fehler
     auf einmal melden.
   - Bei Erfolg pro Stufe eine Zeile "ok: <stufe>"; bei Fehler
     "FAILED: <stufe>" + tail -n 15 der Ausgabe. Nie das ganze Log.
   - Letzte Zeile IMMER "verify: GREEN" oder "verify: RED"; Exit 0 nur
     bei GREEN.
   - --quick (Commit-Hook): ≤ 10 Sekunden, ohne langsame Stufen.
     Voll: ≤ 90 Sekunden. Was teurer ist (Lighthouse, Audits) kommt
     in --deep, nicht in die Standard-Prüfung.
   - Muss HEUTE auf dem Skelett grün laufen.

4. scripts/state-summary.sh — ersetzt den Platzhalter. Vertrag:
   ≤ 250 Tokens, Obergrenze PRO ABSCHNITT (kein globales Abschneiden):
   1 Zeile git (Branch, uncommitted, letzter Commit) · Scoreboard
   "N/M passing" · max. 8 FAILING-Features des aktuellen Meilensteins
   (gefiltert über docs/state/current-milestone) · handoff.md komplett
   · 1 Zeile Verify-Urteil (./scripts/verify.sh --quick | tail -n 1).
   Lege docs/state/current-milestone an (eine Zeile, z.B. "## Fabrik").
   docs/state/metrics.csv existiert bereits (Kopfzeile); jede
   abgeschlossene Aufgabe hängt eine Zeile an — nicht ändern.

   scripts/next-tasks.sh — ersetzt den Platzhalter. Liest das
   Frontmatter in docs/tasks/, gibt Aufgaben mit status: todo aus,
   deren depends_on alle status: done sind. Eine Zeile pro Aufgabe:
   "READY: <id> | <titel> | <class>". Nur bash + grep/awk/sed,
   keine Abhängigkeiten.

5. Skelett: Verzeichnisstruktur, Toolchain, package.json mit den
   Befehlen aus CLAUDE.md (new, dev, build, test), EIN trivialer grüner
   Test, scripts/autoformat.sh an den Stack angepasst.
   Falls ein Dienst einen Schlüssel braucht: .env.example mit jedem
   Variablennamen und einem Kommentar, wo der Wert herkommt — NIE der
   Wert selbst. Die echte .env ist in .gitignore und darf nie gelesen
   oder zitiert werden; CLAUDE.md dokumentiert nur, dass sie existiert.

6. docs/state/decisions.md — jede Tech-Entscheidung aus dieser Sitzung,
   in Alltagssprache.

7. docs/state/handoff.md — die erste Übergabenotiz nach
   docs/templates/handoff-template.md, inkl. "Für den Auftraggeber zu prüfen".

Vorhandene Skills: Alles unter .claude/skills/*/SKILL.md ist
verbindlich — übernimm die Regeln, widersprich ihnen nicht. Fehlt eine
Skill, die das Profil vorsieht (docs/profil/skills/), wähle einen
neutralen Standard und notiere in decisions.md, dass er über diese
Skill ersetzbar ist.

Keine weiteren Skills anlegen. Skills entstehen später durch bewiesene
Wiederholung (beim Meilenstein-Review), nicht durch Vorhersage.

Produkt: siehe docs/profil/produkt.md — lies die Datei vollständig.

Brief-Vorlage: docs/profil/brief-template.md. Falls das Profil weitere
Skills in docs/profil/skills/ mitbringt (z.B. Design-Regeln), sind sie
Vorgabe, keine Empfehlung.

Erster Brief: docs/briefs/<slug>.md  ← HIER PFAD EINTRAGEN
(Vorlage: docs/profil/brief-template.md)

Bevor du irgendetwas erzeugst: Stelle mir die Fragen, deren Antwort die
Zerlegung ändern würde — in Business-Sprache, jede als Entscheidung mit
benannten Optionen ("A, B oder C?"), nicht als offenes Thema. Nutze den
Fragenkatalog in docs/profil/fragenkatalog.md als Mindestmenge. Erst nach meinen Antworten
erzeugst du alles.

Zur Erinnerung: KEIN Produktcode in dieser Sitzung.

Fragenkatalog (Mindestmenge): docs/profil/fragenkatalog.md — lies die
Datei; stelle diese Fragen plus die, die sich aus produkt.md und dem
Brief ergeben.
