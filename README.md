# Image Prompt Generator

A Codex skill for creating image prompts and generated image candidates through staged sub-agents, booru reference research, selective reference-image use, and Codex image generation.

This skill is designed specifically for **Codex**. Image generation is assumed to run through Codex's `imagegen` skill and its built-in `image_gen` tool by default.

It can still write prompts for **Midjourney**, **Stable Diffusion**, **DALL-E**, **Flux**, **NovelAI**, and other tools, but the default workflow is Codex-native: draft prompts, generate candidate images, review them, and save every result locally.

## What It Does

1. **Clarifies your vision** - The main agent asks targeted questions and locks success criteria.
2. **Creates three rough concepts** - The main agent drafts `concept_01` to `concept_03`.
3. **Delegates research to sub-agents** - Low-reasoning sub-agents research aesthetics and collect references.
4. **Collects safe references** - Danbooru and Gelbooru are handled by separate sub-agents, with `explicit` and `questionable` ratings excluded before download.
5. **Selects references carefully** - Only images that fit the user's request and a specific prompt are used as reference images.
6. **Writes final prompts** - The main agent enriches the three concepts into `prompt_01` to `prompt_03`.
7. **Generates images in parallel** - Three image-generation sub-agents use Codex `imagegen`; selected references are attached when present.
8. **Reviews images in parallel** - Three review sub-agents evaluate generated images before the main agent presents results.

## Workflow

```text
User request
-> Main agent clarifies requirements
-> Main agent creates concept_01, concept_02, concept_03
-> Sub-agent 1 researches aesthetic expression for all concepts
-> Sub-agent 2 downloads Danbooru references and reviews concept fit
-> Sub-agent 3 downloads Gelbooru references and reviews concept fit
-> Main agent writes final prompt_01, prompt_02, prompt_03
-> Main agent selects only suitable reference images per prompt
-> Sub-agents 4-6 generate images in parallel with Codex imagegen
-> Sub-agents 7-9 review generated images in parallel
-> Main agent presents accepted and rejected outputs
```

## Quick Start

### Prerequisites

- Codex
- Python 3.8+
- `gallery-dl` for Danbooru/Gelbooru reference collection

### Installation

```bash
git clone https://github.com/Saikoro3/image-prompt-generator.git
cd image-prompt-generator
```

#### Linux / macOS

```bash
chmod +x setup.sh && ./setup.sh
```

#### Windows (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -File setup.ps1
```

Restart Codex after installing or updating the global skill.

## API Configuration (Optional)

The skill can run without booru API keys by using anonymous access, but API keys are recommended for reliability and higher rate limits.

To avoid being asked during a run, create a `.env` file in the skill directory:

#### Linux / macOS

```bash
cd skills/image-prompt-generator
cp .env.example .env
```

#### Windows (PowerShell)

```powershell
cd skills\image-prompt-generator
Copy-Item .env.example .env
```

Then edit `.env`:

```env
# Danbooru (optional - enables higher rate limits)
DANBOORU_USERNAME=your_username
DANBOORU_API_KEY=your_api_key

# Gelbooru (recommended)
GELBOORU_API_KEY=your_api_key
GELBOORU_USER_ID=your_user_id
```

**Where to get API keys:**

| Platform | URL |
|----------|-----|
| Danbooru | https://danbooru.donmai.us/profile -> API Key section |
| Gelbooru | https://gelbooru.com/index.php?page=account&s=options |

The skill checks credentials from the skill directory `.env`, the workspace root `.env`, then existing environment variables. If none are available, the main agent asks how to proceed.

## Reference Safety

Danbooru and Gelbooru download sub-agents must exclude `explicit` and `questionable` ratings before download. Queries should prefer safe/general rating filters and include negative rating terms such as:

```text
-rating:explicit -rating:questionable
```

If metadata or tags still show `rating:explicit` or `rating:questionable`, the file is rejected and must not be treated as a valid reference candidate.

## Output Structure

Each run creates a project folder:

```text
[project_name]/
├── reference/
│   ├── img/
│   │   ├── danbooru/
│   │   │   ├── manifest.md
│   │   │   └── fit-review.md
│   │   └── gelbooru/
│   │       ├── manifest.md
│   │       └── fit-review.md
│   ├── prompt/
│   │   ├── prompt_01/
│   │   │   └── prompt.md
│   │   ├── prompt_02/
│   │   │   └── prompt.md
│   │   ├── prompt_03/
│   │   │   └── prompt.md
│   │   └── prompt-index.md
│   └── generated/
│       ├── prompt_01/
│       │   ├── generation-notes.md
│       │   └── review.md
│       ├── prompt_02/
│       │   ├── generation-notes.md
│       │   └── review.md
│       ├── prompt_03/
│       │   ├── generation-notes.md
│       │   └── review.md
│       └── review-summary.md
```

Generated images are saved under `reference/generated/<prompt_id>/` whether accepted or rejected.

## Features

- **Codex-native image generation** - Uses Codex `imagegen` and built-in `image_gen` by default.
- **Staged sub-agent workflow** - Separate low-reasoning sub-agents for aesthetic research, Danbooru, Gelbooru, image generation, and image review.
- **Parallel generation and review** - `prompt_01` to `prompt_03` are generated and reviewed by separate sub-agents.
- **Selective reference images** - References are optional; only suitable images are attached during generation.
- **Rating exclusion** - `explicit` and `questionable` booru results are excluded before download.
- **No proper nouns** - Final prompts replace studio, artist, and IP names with descriptive style terms.
- **Saved evidence** - Prompts, selected references, generated images, notes, and reviews are written to disk.

## Supported Prompt Targets

| Target | Notes |
|--------|-------|
| Codex `imagegen` | Default image generation path |
| Midjourney | Prompt and reference guidance can be written |
| Stable Diffusion / ComfyUI | Prompt and IP-Adapter / ControlNet reference guidance can be written |
| Flux | Prompt and limited reference guidance can be written |
| DALL-E | Text-first prompts; references are described when direct attachment is unavailable |
| NovelAI | Prompt/tag style can be adapted |

## File Overview

```text
image-prompt-generator/
├── skills/
│   └── image-prompt-generator/
│       ├── SKILL.md
│       ├── .env.example
│       └── references/
│           ├── platform-guide.md
│           ├── style-replacements.md
│           └── subagent-prompts.md
├── .gitignore
├── setup.sh
├── setup.ps1
├── LICENSE
└── README.md
```

## License

MIT License - see [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome. If you change the workflow, keep `SKILL.md`, `references/subagent-prompts.md`, and this README aligned.
