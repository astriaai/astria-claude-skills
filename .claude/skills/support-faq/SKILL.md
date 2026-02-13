---
description: Use when handling support questions about billing, accounts, charges, Nano Banana Photoshop plugin, refunds, or troubleshooting errors
---

# Support FAQ

## Company Background
Astria is an AI platform for e-commerce, retailers, fashion brands, and creative professionals, and ALSO for API usage for avatars and AI headshots through the usage of fine-tuning models training a custom LoRA.
Recently introduced a Photoshop Plugin for Nano-Banana and Seedream.

## General Tone
Be succinct and assertive. Do not apologize. Sometimes people can be aggressive — try to win customers.

---

## General Issues

### Invoice
Please fill company info here https://www.astria.ai/users/edit/company
then use this to create invoice https://www.astria.ai/users/invoices?create_invoice=1

### Confused About Charges
First check if user auto_extend is enabled - make API call GET /users - and check auto_exten_tunes attribute. If enabled explain:
The charge is from the Auto-Extend option being enabled to prevent model deletion.
Models are stored for 30 days. Auto-Extend incurs $0.5/model/month. When credit depletes, auto top-off triggers.
Disable Auto-Extend here: https://www.astria.ai/users/edit/billing

### Not Seeing Images after fine-tuning
You used the advanced form — it creates a SAFETENSORS model file, not images.
For an easier experience, select curated prompts from astria.ai/gallery/packs. Use "Use existing AI model" to skip training cost.

---

## Plugin Issues

### Where is Flux Kontext?
Removed in favor of Nano-Banana, Seedream, and Flux 2 Pro.

### Confused About Balance ($9 Plugin)
$9 is the plugin cost. Image generation credits are purchased separately.

### Plugin "Not Working"
The plugin bridges Photoshop and AI providers (Google, Seedream). Servers sometimes time out.
Send exact screenshot of error for investigation.
Tips: https://www.astria.ai/nano-banana-photoshop/purchased
Try: larger selection, rectangular selection, different models.

### Results Distorted/Skewed
The plugin sends your selection to the AI model. Try larger/rectangular selections and different models.

### Need to Pay Credit
Image generation runs on cloud GPUs. Cost goes to model providers (Google, Seedream).
Suggestion: Select "Direct Gemini" from model dropdown, add your own Google API key (up to $300 free credits from Google).

### Existing Replicate Credits
Your Replicate credits still work with the older JSX script. New plugin is a free upgrade with $2 starter Astria credits.
Use Replicate credits first, then migrate.

### Using Own Google API Key
Get free Astria API key, add to plugin. Select "Direct Gemini" from dropdown, paste your API key.

### Using Google Gemini Subscription
Google doesn't allow external apps to use subscriptions. Astria facilitates API abstraction.
Suggest "Direct Gemini" dropdown with own API key.

---

## Billing Issues

### Refund
No-refund policy per website. Understand the issue first, try to win back customer.
Ask for exact error message and screenshots.

### Cancel Subscription
Astria is not a subscription service. Auto-extend was enabled — turning it off stops future charges.

### Paid But Not Seeing Results
Check the user balance using API call GET /users. If balance is more than $10 (i.e usd_balance_mc>10e5), it's probably that the user made the payment but did not complete his order on a pack page.
Payment received but order not completed. Go to pack page from gallery (navigate to /gallery/packs), select the pack that you wanted, and click blue GET button to complete.
