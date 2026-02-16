---
description: Use when writing, improving, or debugging image generation prompts or choosing prompt parameters
---

Before writing a prompt, get to know the user by querying his last few prompts using the astria-api skill, as well as retrieving his packs GET /packs, and finding prompts assigned to a relevant pack. For example: if trying to generate a prompt for a shirt, find a pack with main_class_name "shirt" and the find the relevant prompts using GET /prompts?pack_id={pack_id} to understand the style and parameters the user has been using. Use this info to inform your prompt writing and parameter suggestions.

Before writing a prompt, query the user refereences/tunes using the astria-api get GET /tunes and see if any of them are relevant to the prompt they want to generate. If yes, use the tune.name and tune.id to reference the tune in the prompt via <model_type:tune.id:1> tune.name syntax. 

Do not navigate the user to a pack page or to look up prompts himself. Instead query prompts yourself and suggest prompt templates to him. When suggesting you may use the AskUserQuestion and embed images in the questions to help him pick.

Do not navigate the user to his tunes/references page looking for references. Query his tunes and see if you can find any references that match his request. Alternatively see if the current prompt contains references matching his request. If not - ask the user to drag a new reference image into the prompt box or click the + button at the top of the prompt box.

After writing a prompt, present it to the user using [ASTRIA_PROMPT:...] so they can review and suggest changes before generating. Always ask how many images per prompt using AskUserQuestion before calling the API, and only call the generation API after the user confirms.

# Prompt Writing Guide
By default assume using $GEMINI_TUNE_ID. No need to ask user about model type unless they explicitly mention a different one or ask for a recommendation.

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
4. Include background descriptions: "clean white studio", "blurred urban street", "autumn forest"
5. For product shots, describe the surface and arrangement

# For fashion and garments
1. Always work with a conssitent face reference. If user does not have such, suggest using tunes from the public gallery (use API call to check GET /gallery/tunes?model_type=faceid&limit=200) or help them create a prompt (without a reference) and then convert that prompt output images into a tune reference via the API.
2. Figure out if user intent is to create a lookbook - example prompt "look book plain white background #fff", or a campaign outdoor or indoor - example prompt "A direct flash paparazzi style shot of <faceid:3904080:1.0> woman moving through the crowded bar. She is looking straight into the camera lens with an intense or surprised expression. She wears the <faceid:3907553:1.0> dress and the <faceid:3907242:1.0> bag on her shoulder. The background is dark and out of focus. High contrast, sharp flash."
