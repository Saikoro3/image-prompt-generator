# Image Prompt Generator

A Claude Code / Cowork skill that generates optimized image prompts through reference research, visual analysis, and structured prompt creation.

Works with **Midjourney**, **Stable Diffusion**, **DALL-E**, **Flux**, **NovelAI**, and other image generation tools.

## What It Does

1. **Clarifies your vision** — Asks targeted questions to nail down every visual detail
2. **Collects reference images** — Downloads from Danbooru & Gelbooru via gallery-dl
3. **Analyzes references** — Rates, tags, and compares each image
4. **Generates a structured prompt** — Natural language + style keywords, organized by scene, character, effects, and mood

## Quick Start

### Prerequisites

- Python 3.8+
- [Claude Code](https://claude.com/claude-code) or Cowork mode

### Installation

```bash
git clone https://github.com/jekn2740/image-prompt-generator.git
cd image-prompt-generator
chmod +x setup.sh && ./setup.sh
```

### API Configuration

Copy the example environment file and add your credentials:

```bash
cp .env.example .env
```

Then edit `.env`:

```env
# Danbooru (optional — enables higher rate limits)
DANBOORU_USERNAME=your_username
DANBOORU_API_KEY=your_api_key

# Gelbooru (recommended)
GELBOORU_API_KEY=your_api_key
GELBOORU_USER_ID=your_user_id
```

**Where to get API keys:**

| Platform | URL |
|----------|-----|
| Danbooru | https://danbooru.donmai.us/profile → API Key section |
| Gelbooru | https://gelbooru.com/index.php?page=account&s=options |

> **Note:** The skill works without API keys (anonymous access), but authenticated requests provide higher rate limits and more reliable access.

## Output Structure

Each generation creates a project folder:

```
[project_name]/
├── reference/
│   ├── img/           # Downloaded reference images + analysis.md
│   └── prompt/        # Final prompt + selected reference images
│       ├── prompt.md  # The generated prompt
│       ├── primary_ref.jpg
│       └── style_ref.png
```

## Features

- **Multi-platform support** — Generates prompts optimized for different AI image generators
- **Reference image tagging** — PRIMARY_REF, STYLE_REF, EFFECT_REF, COLOR_REF, COMPOSITION_REF, DETAIL_REF
- **Platform-specific weights** — Includes recommended settings (e.g., Midjourney `--iw`, SD IP-Adapter weights)
- **No proper nouns** — Automatically replaces studio/artist names with descriptive style terms
- **Structured prompts** — Markdown format with scene overview, character, environment, effects, and technical details

## Supported Platforms

| Platform | Reference Images | Notes |
|----------|-----------------|-------|
| Midjourney | `--cref`, `--sref`, `--iw` | Full support |
| Stable Diffusion | IP-Adapter, ControlNet | Full support |
| ComfyUI | IPAdapter node | Multi-reference blending |
| Flux | Style reference | Single image recommended |
| DALL-E 3 | Text-only | Describes references in prompt |
| NovelAI | Text-only | Optimized tag format |

## File Overview

```
image-prompt-generator/
├── skills/
│   └── image-prompt-generator/
│       ├── SKILL.md         # Main skill instructions
│       └── references/
│           ├── platform-guide.md        # Platform-specific attachment guide
│           └── style-replacements.md    # Proper noun → description mapping
├── .env.example             # API key template
├── .gitignore
├── setup.sh                 # One-click setup script
├── LICENSE
└── README.md
```

## License

MIT License — see [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

If you add support for a new platform, please update `references/platform-guide.md` with the attachment method and recommended weights.
