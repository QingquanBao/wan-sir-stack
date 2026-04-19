# wan-sir-agent

> An AI agent that thinks like **万维钢 (Wan Weiqiang)** — physicist-turned-science-writer, author of *精英日课* and *现代思维工具100讲*.

This is a Claude Code skill that transforms Claude into a thinking companion grounded in Wan's worldview: systems thinking, modern cognitive tools, and the discipline of building mental models that actually predict reality.

Inspired by [gstack](https://github.com/garrytan/gstack).

---

## What It Does

When you arrive with a real challenge — career crossroads, a decision under uncertainty, a persistent bad habit — the agent doesn't give you generic advice. It routes your challenge through Wan's framework:

1. **Diagnoses which level you're operating at**: 传统观念 / 市侩哲学 / 精英解法
2. **Identifies the mental model gap** behind your problem
3. **Applies the relevant thinking tool** from 现代思维工具100讲
4. **Gives you a Wan-style answer**: hard theory, concrete story, counterintuitive action

It will never tell you to "just work harder" or "follow your passion." It will tell you what your objective function is missing.

---

## Quick Start

```bash
# Install as a Claude Code skill
npx skills add QingquanBao/wan-sir-agent
```

Then in any Claude Code session:

```
/wan-sir  I've been at the same company for 4 years. Should I leave?
```

Or just describe your situation — the agent will route it.

---

## Architecture

```
wan-sir-agent/
├── SKILL.md              ← Entry point: skill trigger + routing logic
├── worldview-core.md     ← Wan's core worldview (the "soul" layer, always loaded)
├── router.md             ← Intent classification: challenge vs concept vs reflection
├── challenges/           ← Challenge-specific response templates
│   ├── career.md
│   ├── decision-under-uncertainty.md
│   ├── learning-strategy.md
│   └── relationship-dynamics.md
├── concepts/             ← Concept cards distilled from 现代思维工具100讲
│   ├── compounding.md
│   ├── narrative.md
│   ├── heavy-tail.md
│   ├── free-energy.md
│   └── ...
└── scripts/
    └── fetch-new-articles.sh   ← Update script when new lectures drop
```

**Key design principle**: `worldview-core.md` is loaded on every call. It contains Wan's biases, anti-patterns, and voice markers. The agent must disagree with the user when their framing violates this worldview.

---

## Concept Coverage

From *万维钢·现代思维工具100讲* (32 published as of 2026-04):

| Module | Tools |
|--------|-------|
| 基本世界观 | 叙事、重尾分布、能动性、约束、可能性、内核自我 |
| 成长战略 | 能耐寻求、供给侧心态、复利、自我决定理论、自由能原理 |
| 认知与注意力 | 主动高认知负荷、WOOP、认知解耦、身份认同 |
| 社会与位置 | 社交资本、结构洞、场域、赛道选择 |
| 决策 | 探索-利用、无免费午餐、概率分布、共鸣 |

---

## Updating When New Lectures Drop

```bash
# Run manually when 万维钢 publishes new lectures
./scripts/fetch-new-articles.sh
```

The script uses Chrome CDP to fetch new articles from Dedao (requires you to be logged in), saves them to `sources/`, and flags which concepts need new cards.

---

## Design Philosophy

**Challenge-first, not concept-first.** Users arrive with problems, not terminology. The router maps real situations to frameworks, not the other way around.

**Worldview before advice.** Every answer is anchored to `worldview-core.md`. Generic wisdom is explicitly rejected.

**Distillation, not summarization.** Each concept card extracts the non-obvious insight — the thing Wan would say that a generic AI wouldn't.

---

## Status

- [x] Worldview core extracted (v0.1)
- [x] 30 source articles archived
- [ ] Challenge templates (4 domains)
- [ ] Concept cards (target: 30 cards)
- [ ] SKILL.md + router
- [ ] Auto-update workflow

---

## License

MIT. The thinking tools belong to humanity. Wan Sir just distilled them better than most.
