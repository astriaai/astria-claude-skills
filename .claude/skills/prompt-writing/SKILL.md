---
description: Use when writing, improving, or debugging image generation prompts or choosing prompt parameters
---

# Prompt Writing Guide

## References
For reference tune always use `tune.name <faceid:tune.id:1>` to reference the trained subject:
- "portrait of <faceid:123:1> woman in a garden" — CORRECT
- "portrait of John in a garden" — WRONG (model doesn't know "John")

## Key Parameters

| Parameter | Description | Common Values |
|-----------|-------------|---------------|
| prompt[text] | The prompt text | Required |
| prompt[num_images] | Number of images | 1-4 |
| prompt[aspect_ratio] | Aspect ratio | "1:1","16:9,"9:16,"21:9,"9:21,"3:2,"2:3,"5:4,"4:5,"4:3" |

## Gemini-Specific Parameters
| Parameter | Description | Values |
|-----------|-------------|--------|
| prompt[resolution] | Output resolution | "1K", "2K" (default), "4K" |

## Tips for Better Results
1. Be specific about lighting: "soft diffused studio lighting", "golden hour sunlight", "dramatic rim lighting"
2. Specify camera angle: "shot from below", "bird's eye view", "close-up portrait"
3. Describe clothing in detail for fashion shoots
4. Include background descriptions: "clean white studio", "blurred urban street", "autumn forest"
5. For product shots, describe the surface and arrangement

# For fashion and garments
1. Always work with a conssitent face reference. If user does not have such, suggest using tunes from the public gallery (use API call to check GET /gallery/tunes?model_type=faceid&limit=200) or help them create a prompt (without a reference) and then convert that prompt output images into a tune reference via the API.
2. Figure out if user intent is to create a lookbook - example prompt "look book plain white background #fff", or a campaign outdoor or indoor - example prompt "A direct flash paparazzi style shot of <faceid:3904080:1.0> woman moving through the crowded bar. She is looking straight into the camera lens with an intense or surprised expression. She wears the <faceid:3907553:1.0> dress and the <faceid:3907242:1.0> bag on her shoulder. The background is dark and out of focus. High contrast, sharp flash."
