#!/usr/bin/env bash
# ShelfSense teaser — one POST /v1/generate per shot of video-plan.md.
# High quality: 5s, 1280x720, 30 steps, me.png as first keyframe so the
# founder keeps his face in every shot. Each request can take 10+ minutes;
# the server runs them one at a time and returns the finished MP4.
set -euo pipefail

SERVER=http://127.0.0.1:8188
mkdir -p clips

generate_shot() {
  local n="$1" prompt="$2" out="clips/shot$1.mp4"
  echo "=== Shot $n -> $out ==="
  # Encode to a text file first: jq's --rawfile decodes binary as UTF-8 and corrupts it.
  base64 -w 0 me.png > clips/img.b64
  jq -n --arg prompt "$prompt" --rawfile image_b64 clips/img.b64 '{
    prompt: $prompt,
    image: ("data:image/png;base64," + ($image_b64 | gsub("\n"; ""))),
    seconds: 5,
    width: 1280,
    height: 720,
    steps: 30
  }' > "$out.json.tmp"
  curl -sS --max-time 3600 \
    -H 'Content-Type: application/json' \
    --data-binary @"$out.json.tmp" \
    -o "$out" \
    "$SERVER/v1/generate"
  rm -f "$out.json.tmp"
  echo "=== Shot $n done: $(du -h "$out" | cut -f1) ==="
  echo
}

generate_shot 1 'Late afternoon inside a small family-run grocery store, warm practical lighting mixed with golden window light. Handheld 35mm tracking shot at chest height follows the founder — late 20s, short dark curly hair, light stubble, brown leather jacket — as he walks slowly down a fully stocked aisle, brow furrowed, holding a paper clipboard and pen, scanning shelves with visible frustration. Shelves soften and blur past camera. Shallow depth of field, cinematic film grain, natural color grade. He says: "Three hours a week, just counting shelves by hand." No readable text anywhere.'

generate_shot 2 'Same store, same warm lighting. Medium close-up from a low angle over the founder'\''s shoulder as he raises his phone toward a fully stocked grocery shelf and photographs it in one smooth, confident motion; the phone screen'\''s soft glow briefly brightens his face. A subtle translucent digital scan plane sweeps across the shelf in the background. The phone screen is visible for a beat and shows only the app name "ShelfSense" on a clean interface — no other UI text. 50mm lens, shallow depth of field, soft bokeh on product packaging, crisp modern commercial look. He says: "One photo. The reorder list writes itself." The only readable text is "ShelfSense", spelled exactly.'

generate_shot 3 'Golden hour. Interior of the store near the entrance, warm sunset light streaming through the front window. The founder stands behind his counter, exhales with visible relief, sets the phone down, then looks straight into the lens and gives the same warm, confident smile as his portrait. Slow 40mm push-in from waist-up to medium close-up. Soft golden rim light, cinematic contrast, gentle lens flare. He says: "Your shelves, sorted — in seconds." The only readable text is "Try it", spelled exactly.'

echo "All shots generated."
