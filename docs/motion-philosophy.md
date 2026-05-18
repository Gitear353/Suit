# Motion Philosophy

## Stil-Prinzipien

Modern, hochwertig, clean, dynamisch. Jede Animation soll sich anfühlen wie etwas, das man in einem Top-Tier-Produktionsstudio gebaut hätte.

## Easings

- **Reveals:** `power3.out` — schnell rein, weich landen
- **Loops:** `sine.inOut` — gleichmäßig, nie hektisch
- **NIEMALS `linear`** — wirkt billig und maschinell

Mindestens **3 verschiedene Easings pro Szene**.

## Anchor-Word-Sync

Animation landet **mit** dem Wort, ±100ms. Niemals früher, niemals mehr als 100ms später.

## Verbotene Fonts (Banned Fonts)

Folgende Fonts sind gesperrt — sie wirken generisch und werden mit "KI-Outputs" assoziiert:

Inter, Roboto, Open Sans, Lato, Poppins, Outfit, Sora, Fraunces, Playfair Display, Cormorant Garamond, Syne, Cinzel, Nunito, Source Sans, PT Sans, Arimo

## Empfohlene Ansätze

- Variable Fonts für dynamische Weight-Übergänge
- Clip-path-Reveals für Text
- SVG-Stroke-Animationen für Diagramme
- Blur + scale für Background-Layers (nie im Vordergrund)
- Color-Token-System aus `brand-guidelines/<name>/colors.md` konsequent nutzen
