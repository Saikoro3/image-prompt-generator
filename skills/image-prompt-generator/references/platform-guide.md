# Platform-Specific Reference Image Attachment Guide

## Tagging System

Assign one or more tags to each downloaded reference image:

| Tag | Meaning | When to Attach |
|-----|---------|----------------|
| `PRIMARY_REF` | Main style & composition reference | **Always attach** — anchor image |
| `STYLE_REF` | Art style reference | When style is critical |
| `COMPOSITION_REF` | Layout/framing reference | When composition matters |
| `COLOR_REF` | Color palette reference | When color accuracy matters |
| `EFFECT_REF` | Specific effect reference | When replicating visual effects |
| `DETAIL_REF` | Fine detail reference | Selectively for specific details |
| `DO_NOT_ATTACH` | For analysis only | Should NOT be sent to the generator |

## Platform Attachment Methods

| Platform | Method | Weight/Settings |
|----------|--------|-----------------|
| **Midjourney** | `--cref [URL]` for composition, `--sref [URL]` for style, or image prompt with `--iw 0.3-0.7` | PRIMARY_REF: `--iw 0.5`, EFFECT_REF: `--iw 0.3` |
| **Stable Diffusion (IP-Adapter)** | Load via IP-Adapter node | PRIMARY_REF: weight 0.6-0.7, EFFECT_REF: weight 0.3-0.4 |
| **ComfyUI** | IPAdapter node, can blend multiple references | PRIMARY_REF as main, blend EFFECT_REF |
| **Flux (with ref)** | Attach as style reference | PRIMARY_REF only (1 image recommended) |
| **DALL-E 3** | Text-only (no image reference) | Describe in prompt instead |
| **Stable Diffusion (ControlNet)** | Preprocessed reference (canny/depth/pose) | Use for specific structural guidance |

## Selection Criteria (Priority Order)

1. **Composition Match** — Closest overall layout/framing to target
2. **Style Match** — Closest art style/rendering quality
3. **Color Palette Match** — Closest color scheme to target
4. **Effect/Detail Reference** — Demonstrates specific effects to replicate
5. **Mood/Atmosphere Match** — Conveys the target emotional tone

## Output Format in analysis.md

```markdown
## Reference Image Selection for Generation

### Recommended Attachments:

| Image | Tags | Attach? | Purpose | Platform Weight |
|-------|------|---------|---------|-----------------|
| ref01_xxx.jpg | PRIMARY_REF, STYLE_REF | YES | Main composition & style anchor | MJ: --iw 0.5 / SD: 0.6-0.7 |
| ref02_xxx.jpg | EFFECT_REF | YES | Particle effects & glow rendering | MJ: --iw 0.3 / SD: 0.3-0.4 |
| ref03_xxx.jpg | COLOR_REF | OPTIONAL | Color reference only | Only if color is off |
| ref04_xxx.jpg | DO_NOT_ATTACH | NO | Used for text analysis only | N/A |

### Key Differences from References (What to Change):
1. [Element to add that's not in any reference]
2. [Element to remove from references]
3. [Element to modify from references]
```
