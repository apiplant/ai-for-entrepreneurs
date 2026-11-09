# AI for Entrepreneurs

Materials for a 60-minute lesson for entrepreneurship students (no coding background assumed): about 40 minutes of talk, then a 20-minute live demo. The one message: **use AI for everything, verify everything, and point it at hard problems.**

## What's here

| Path | What it is |
| --- | --- |
| `index.html` | The lesson page (single self-contained file, deployable as a static site) |
| `script.md` | Lesson plan and word-for-word script, with timings and a fact sheet |
| `demo/` | Recorded screen captures of each live-demo step (install, Markdown, deck, website, deploy, video) |
| `my-first-project/` | The sample output the demo produces: deck, site, LinkedIn post, video plan, teaser |
| `my-first-project.zip` | Zipped copy of the project above |
| `loops/` | Looping background videos |
| `shots/`, `me.png` | Images used on the page |
| `video/` | Tooling for recording and rendering the demo (git-ignored) |

## Viewing

Open `index.html` in a browser, or serve the folder:

```sh
python3 -m http.server
```

The page loads fonts from Google Fonts, so it needs a connection for the intended look.

## Notes

- Facts, prices and free tiers in `script.md` are as of 9 Nov 2026. Recheck the fact sheet before teaching.
- The demo uses one agent for four jobs after a quick install: Markdown editing, decks, a live Cloudflare website, and video generation.
