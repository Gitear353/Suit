# Arbeitsregeln für Claude in diesem Projekt

## Workflow-Prinzipien

- **Video-Use first** für Schnitt und Transkription, dann Hyperframes für Motion Graphics
- **Plan-Bestätigung auf Deutsch** (Plain Language) vor jedem Cut und vor jeder Composition — erst nach User-OK rendern
- Outputs landen unter `projects/<name>/renders/`, niemals in Repo-Root oder `raw/`
- `.env` nie committen
- Bei Multi-Scene-Compositions: parallele Sub-Agents (eine Szene pro Agent), wenn unabhängig
- Nach jedem Render Self-Eval per `timeline_view`-Pattern, bevor Preview gezeigt wird

## Brand-Guidelines-Konvention

- Default-Brand: `brand-guidelines/default/`
- Sub-Brands pro Kunde/Kanal: `brand-guidelines/<name>/`
- Wenn keine Brand genannt wird, fällt Claude auf `brand-guidelines/default/` zurück
- Wenn der Nutzer eine Brand nennt, alle Files in diesem Ordner lesen (Hex-Codes, Typeface-Namen, Logo-SVGs, Tone-of-Voice, motion-philosophy-Overrides)

## `.env`-Sync

Wenn Claude bemerkt, dass `./.env` und `./video-use/.env` divergieren, syncen — Projekt-Root ist Wahrheit.

## Skill-Imports (Windows-Hinweis)

Falls Junction nicht angelegt werden konnte, per absolutem Pfad importieren.

## Workflow-Branch nach dem Cut (PFLICHT-Checkpoint)

Vor dem Bauen von HTML-Compositions immer per `AskUserQuestion` klären:

**Frage 1 — HTML-Quelle:**
- Claude Design (claude.ai) — Claude exportiert nur das Output-Timeline-Transkript, wartet aktiv auf Bundle
- Direkt Hyperframes — Claude baut Storyboard und HTML-Compositions selbst

**Frage 2 (nur bei Direkt Hyperframes) — Brand-Guidelines:**
- `brand-guidelines/default/` (Fallback)
- `brand-guidelines/<name>/` (Sub-Brand)
- keine Brand (Test-Modus)

Bei Claude Design: Brand-Frage weglassen — Brand kommt aus dem hochgeladenen Skill.

## Cut-Standards (nicht verhandelbar)

### Versprecher-Detection (vor jedem Cut Pflicht)

1. `pack_transcripts.py --silence-threshold 0.4` ausführen
2. `ffmpeg -af silencedetect=noise=-30dB:duration=0.25` auf die Source
3. Verdächtige Sub-Slices isoliert nochmal an Scribe schicken

### Cut-Padding nach Typ

| Cut-Typ | Tail (nach Wort) | Lead (vor Wort) |
|---|---|---|
| Mid-sentence (Komma) | 100ms | 80ms |
| Sentence-boundary (Punkt) | 200ms | 130–150ms |
| Video-Anfang | — | 130–150ms |
| Video-Ende | 600–700ms (nach echtem Word-End via Re-Scribe) | — |

### EDL-Konvention

Jede `edl.json` enthält einen `_padding_params`-Block. Keine Magic-Numbers.

### Two-Step Pflicht-Verifikation des letzten Wortes

1. Full-Context Scribe markiert letztes Wort oft 1–2s zu spät → Sub-Slice per ffmpeg + Re-Scribe
2. Echten Word-End aus Slice-Transkription nehmen, NICHT aus Full-Context
3. Range-End = echter Word-End + 600–700ms

## Claude-Design-Bundle — Pflicht-Hinweise

- Render-Mode via `evaluateOnNewDocument` setzen, KEIN `?render=1` Query-String
- Speaker-Video Keyframe-Conversion vor jedem Bundle-Render (`-g 1 -keyint_min 1`)
- Format-Check vor Patch-Versuch (Format A: ~400KB, `#main`; Format B: ~1.5MB, `#root`, JSX-Files)
- NICHT `npx hyperframes preview/render` für Claude-Design-Bundles
- NICHT `page.screencast()` — frame-by-frame via `renderSeek(t)` / `__setStageTime(t)`
