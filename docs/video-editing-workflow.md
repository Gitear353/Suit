# Video Editing Workflow

Schritt für Schritt vom Rohvideo bis zum finalen Render.

## Edit-Workflow

### Schritt 1 — Rohvideo ablegen

```
raw/<projektname>/take_001.mp4
```

### Schritt 2 — Transkription

Claude transkribiert via ElevenLabs Scribe (`/v1/speech-to-text`).
Output: `projects/<name>/transcripts/master.json` + `master.srt`

### Schritt 3 — Versprecher-Detection

```bash
# Silence-Map erzeugen
ffmpeg -hide_banner -nostats -i raw/<projekt>/<file>.mp4 \
  -af "silencedetect=noise=-30dB:duration=0.25" -f null - 2>&1 | grep "silence_"

# Pack Transcripts
uv run --project ./video-use python ./video-use/helpers/pack_transcripts.py \
  --edit-dir "projects/<projektname>" --silence-threshold 0.4
```

### Schritt 4 — Cut-Plan (auf Deutsch, Plain Language)

Claude legt Cut-Plan mit Versprecher-Findings und Padding pro Range vor. Erst nach User-OK rendern.

### Schritt 5 — Cut rendern

```bash
uv run --project ./video-use python ./video-use/helpers/render.py \
  projects/<projekt>/edl.json -o projects/<projekt>/clips/edited.mp4
```

### Schritt 6 — Motion Graphics

**Workflow-Branch wählen (immer fragen):**
- **Claude Design** → Transkript exportieren, Nutzer baut HTMLs in claude.ai, Bundle zurückliefern
- **Direkt Hyperframes** → Claude baut Storyboard + HTML-Compositions selbst

### Schritt 7 — Preview

```bash
# Nur für Direkt-Hyperframes:
npx hyperframes preview
# Studio läuft auf localhost:3002
```

### Schritt 8 — Keyframe-Conversion (vor Bundle-Render Pflicht)

```bash
ffmpeg -i projects/<projekt>/clips/edited.mp4 \
  -c:v libx264 -preset fast -crf 18 \
  -g 1 -keyint_min 1 -sc_threshold 0 \
  -pix_fmt yuv420p -r 30 \
  -c:a aac -b:a 192k \
  projects/<projekt>/assets/speaker.mp4
```

### Schritt 9 — Final-Render

```bash
# Direkt Hyperframes:
npx hyperframes render

# Output: projects/<name>/renders/final.mp4 (1920×1080 / 30fps)
#         projects/<name>/renders/final-4k.mp4 (auf Anfrage)
```

### Schritt 10 — Self-Eval

`timeline_view`-Pattern nach jedem Render, bevor Preview gezeigt wird.

## Pure-Animation-Workflow

Identisch ab Schritt 6 — Nutzer beschreibt das Video, Claude erzeugt Storyboard und baut Compositions.

## EDL-Format

```json
{
  "sources": { "name": "raw/<projekt>/<file>.mp4" },
  "grade": null,
  "_padding_params": {
    "mid_sentence_tail_ms": 100,
    "mid_sentence_lead_ms": 80,
    "sentence_boundary_tail_ms": 200,
    "sentence_boundary_lead_ms": 140,
    "video_end_tail_ms": 630
  },
  "ranges": [
    { "start": 1.13, "end": 4.20 },
    { "start": 5.80, "end": 10.35 }
  ]
}
```
