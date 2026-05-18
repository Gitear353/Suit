# KI Video Editing Studio

Vollständiges KI Video Editing Studio mit zwei Workflows:

1. **Edit-Workflow** — Rohvideo → Transkription → Cuts → Motion Graphics → finaler Render
2. **Pure-Animation-Workflow** — Animationsvideos ohne Rohvideo (Website, Promos, Erklärvideos)

## Voraussetzungen

- **ElevenLabs API-Key** — [kostenlos holen](https://elevenlabs.io/app/settings/api-keys) (Free-Tier reicht für erste Tests)
- Node ≥ 22, Python ≥ 3.11, ffmpeg ≥ 4, uv, git

## Quickstart

### 1. ElevenLabs-Key eintragen

```bash
# .env im Projekt-Root bearbeiten:
ELEVENLABS_API_KEY=dein_key_hier
# video-use/.env muss identisch sein
```

### 2. Edit-Workflow starten

Rohvideo in `raw/<projektname>/` legen, dann Claude sagen:

```
Edit @raw/<projektname>/<datei>.mp4 in eine Folge mit Brand default.
```

### 3. Pure-Animation-Workflow

```
Bau mir ein 60-Sekunden-Erklärvideo zum Thema [X] mit Brand default.
```

## Struktur

```
raw/                    Rohvideos (gitignored)
projects/               Video-Projekte
  example/
    assets/             Speaker-Video (keyframe-converted)
    clips/              Cut-Output
    transcripts/        master.json, master.srt
    compositions/       HTML Motion Graphics
    previews/
    renders/            final.mp4, final-4k.mp4
brand-guidelines/
  default/              Fallback-Brand
  <sub-brand>/          Eigene Brand pro Kunde/Kanal
docs/                   Workflow-Doku
video-use/              Transkription + Cut-Engine
.claude/skills/         Verlinkte Skills
```

## Troubleshooting

**FFmpeg nicht gefunden:**
```bash
sudo apt install -y ffmpeg          # Ubuntu/Debian
brew install ffmpeg                  # macOS
winget install Gyan.FFmpeg           # Windows
```

**ElevenLabs-Limit erreicht:**
OpenAI Whisper als Fallback: `OPENAI_API_KEY=...` in `.env` eintragen.

**Studio-Port belegt (localhost:3002):**
```bash
npx hyperframes preview --port 3003
```

**video-use uv sync schlägt fehl:**
```bash
cd video-use && uv sync --python 3.11
```

## Referenzen

- [Hyperframes Docs](https://hyperframes.heygen.com/quickstart)
- [Hyperframes Catalog](https://hyperframes.heygen.com/catalog/blocks/data-chart)
- [Video-Use SKILL.md](https://github.com/browser-use/video-use/blob/main/SKILL.md)
