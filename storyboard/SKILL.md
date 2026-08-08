---
name: storyboard
description: Turn a rough scene, image prompt, or reference-led visual idea into a text-only cinematic video storyboard. Use for /storyboard, "turn this into a cinematic scene", "storyboard this video", or direct text-to-video planning. Write the finished shot sequence into video_prompt and clear the image prompt; never generate a storyboard-grid image.
---

# Video Storyboard

Turn the current draft into a cinematic shot sequence written directly in the
video prompt. Never generate a 4x4 artboard, storyboard image, contact sheet, or
first-frame image.

## Use the current draft

Read the current image prompt, reference tokens, aspect ratio, and any existing
video prompt from page context. Treat a handoff such as "Turn this into a
cinematic scene" as permission to make the missing creative choices when the
draft already contains a reference, scene, and general idea of the frame. Do
not ask the user to repeat those details.

Preserve every `<lora:...>` and `<faceid:...>` token exactly. Keep the same
character, products, wardrobe, location, time of day, lighting, and grade
throughout the sequence unless the requested story deliberately changes one.

## Write the storyboard

Default to 16 numbered shots for an approximately 15-second video:

- Give each shot one camera scale, one subject, and one filmable action.
- Do not repeat a camera scale twice in a row. Rotate among extreme close-up,
  close-up, medium, long, and extreme long shots.
- Vary angles with front, back, profile, low-angle, top-down, and
  over-the-shoulder views where useful.
- Use shots 1-3 to establish the hero, environment, and motion; shots 4-13 for
  the action montage; and shots 14-16 for a product/detail beat and a closing
  wide shot.
- Put the global light, color grade, grain, and atmosphere in shot 1, then keep
  them continuous.
- Use the identical reference token whenever its subject appears. Chain
  continuity with phrases such as "the same woman", "she", and "her".

Write only the numbered shots in the finished video prompt. Do not add a grid
header or describe storyboard tiles.

## Apply it to the composer

Call `present_generation` exactly once with the complete current generation
draft. Put the completed sequence in `video_prompt`, set `text` to the empty
string, and preserve the remaining fields from Current generation draft JSON.
Use the current video model or its default when the draft has none. This writes
the sequence directly to video mode with no image/first-frame prompt. Do not
repeat the storyboard in assistant text and do not emit an `ASTRIA_PROMPT` or
`ASTRIA_VIDEO_PROMPT` command.

If the current image prompt already contains the completed storyboard or the
user asks to move the current prompt into video mode, copy it into the
`present_generation` `video_prompt` field verbatim and set `text` to the empty
string. Do not summarize, prefix, trim, or rewrite it.

## Generate video

When the user explicitly asks to generate, pass the exact approved storyboard
as `--video-prompt` and omit `--text` entirely:

- If `prompt.text` still contains the content and `video_prompt` is empty, move
  `prompt.text` into `video_prompt` byte-for-byte and clear `prompt.text` before
  generation. Do not expand, summarize, prefix, trim, or otherwise rewrite it
  during this generation step.
- If `video_prompt` is already populated, use it as-is.

```bash
astria video --video-model seedance2_720p --duration 15 --num-images 1 \
  --video-prompt "<the exact approved storyboard>"
```

Use the current aspect ratio when it is available. Do not create or pass an
artboard image, an input image, or an image/first-frame prompt unless the user
explicitly asks for one.
