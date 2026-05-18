# nova-intro

A HyperFrames video composition. Plain HTML + GSAP; rendered to MP4 by the `hyperframes` CLI.

## Background music

Drop a `music.mp3` file into this folder before rendering. The HyperFrames renderer mixes it
automatically. For a 10-second intro, a 10–15s ambient loop works well. Any royalty-free
instrumental will do — sources: Pixabay Music, Freesound, or Artlist.

## Requirements

- **Node.js 22+** — [nodejs.org](https://nodejs.org/)
- **FFmpeg** — `brew install ffmpeg` (macOS) or `sudo apt install ffmpeg` (Debian/Ubuntu) or [ffmpeg.org/download](https://ffmpeg.org/download.html) (Windows)

Verify: `npx hyperframes doctor`

## Preview

```bash
npx hyperframes preview
```

Opens the HyperFrames Studio at `http://localhost:3002` with frame-accurate scrubbing.

## Customise

Edit `index.html` directly:

- **Brand name** — search for `NOVA` and replace with your product name
- **Tagline** — update the `s3-tagline` paragraph text
- **URL / CTA** — update the `s4-sub` paragraph
- **Palette** — change CSS custom properties in `:root` (bg, ink, accent, muted)
- **Fonts** — swap the Google Fonts link and `--font-display` / `--font-body` values

## Refine with Claude Code

```bash
npx skills add heygen-com/hyperframes   # install HyperFrames skills (one-time)
npx hyperframes lint                     # verify structure (should pass with zero errors)
npx hyperframes preview                  # open the studio for live feedback
```

Then open in Claude Code and iterate:

- "Make the title entrance snappier"
- "Change the shader to glitch for more energy"
- "Extend the brand close scene to 3 seconds"
- "Add a counter animation to the stat"

## Render

```bash
npx hyperframes render index.html -o nova-intro.mp4
```

1920×1080 / 30fps by default. Use `--fps 60` for a smoother output.
