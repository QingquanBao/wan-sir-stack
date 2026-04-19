# Wan Sir Agent Plan

## Goal

Build a public-facing plugin with an independent agent that acts like a
"Wan Wei Gang style thinking companion" rather than a generic chatbot or a
course-summary bot.

The product should:

- keep a stable worldview loaded at all times
- route users into challenge-solving or concept-exploration flows
- use challenge-oriented skills instead of article-oriented skills
- use concept cards as supporting assets instead of exposing all concepts as
  separate skills
- avoid long verbatim source reuse and instead rely on distilled viewpoints,
  biases, and execution guidance

## Product Scope

This plugin is meant to be focused and usable, not an everything-system.

It should do two things especially well:

- continuously distill new Wan Sir articles into usable internal assets
- answer user challenges with practical advice shaped by Wan-style values and
  judgment

It should not try to own every adjacent concern. Features like rich long-term
memory, cross-plugin personal history, or broad life-OS infrastructure can be
left to other plugins or later versions.

Priority framing:

- `P0`: new article distillation pipeline
- `P0`: challenge skills that produce concrete, high-signal advice
- `P1`: richer routing, artifacts, and multi-step session structure
- `P2`: long-term memory, preference learning, broader ecosystem integrations

## Core Product Thesis

The system is not a knowledge base of 100 articles.

It is a runtime system with:

1. an always-on worldview layer
2. an intent router
3. challenge overlays loaded on demand
4. concept and high-view cards loaded on demand

This structure is meant to preserve Wan-style bias and coherence while keeping
context small and purposeful.

## Runtime Model

### 1. Always-On Worldview Layer

This layer is always loaded, no matter what the user asks.

Its job is not to contain all source material. Its job is to encode the stable
thinking style and judgment bias of the system.

It should include durable principles such as:

- the world is a complex system, not a simple linear chain
- start from objective function before methods
- improve world models before making strong judgments
- watch feedback loops, bandwidth limits, path dependence, and heavy tails
- avoid both naive hard-work worship and cynical opportunism
- prefer generation, cooperation, compounding, and structural change
- encourage "big-picture / da cheng" thinking: not only self-optimization, but
  also changing environment and system design
- answer with framing, variables, and action guidance rather than slogan-level
  motivation

This layer should be compact and highly reusable. It is the persistent
personality and bias anchor of the agent.

### 2. Intent Router

Each user message is first classified into one of two top-level modes:

- `challenge mode`
- `concept mode`

#### Challenge Mode

Use when the user is asking about:

- life direction
- career decisions
- emotional regulation
- learning strategy
- relationships and social reality
- wealth and opportunity
- leadership and organization
- higher-level reflection tied to an immediate real problem

#### Concept Mode

Use when the user is asking about:

- a specific concept
- a high-level viewpoint
- the meaning of a framework
- how two concepts differ
- what Wan-style interpretation of an idea would be

The user should not need to pick a mode manually. The router should infer it.

### 3. Challenge Overlays

If the message enters `challenge mode`, the agent loads exactly one
challenge-oriented skill first, then optionally supplements it with a few
concept cards.

Challenge skills should not teach generic concepts the LLM already knows.
They should only inject:

- Wan-style framing priorities
- preferred tool combinations
- common mistakes in this type of problem
- execution tricks and advice that are specific enough to change the answer

Example challenge skills for v1:

- `career-direction`
- `decision-under-uncertainty`
- `negative-emotion`
- `learning-and-growth`
- `relationships-and-social-systems`
- `wealth-and-opportunity`
- `leadership-and-organization`
- `high-view-reflection`

Each challenge skill should define:

- when to use it
- which framing comes first
- which concept cards are primary
- which concept cards are secondary
- what bad answers to avoid
- a preferred answer structure

### 4. Concept and High-View Cards

If the message enters `concept mode`, the agent should not load a challenge
skill by default. It should retrieve one or more cards instead.

Cards are small assets used for explanation and linking. They are not
full-length article summaries.

Each card should focus on:

- what the concept means
- why it matters
- the non-obvious or counterintuitive point
- when it is useful
- what it is often confused with
- which worldview principles it connects to
- which challenge skills typically call it

Cards fall into three useful groups:

- worldview cards
- concept/tool cards
- high-view cards

## Procedural User Flow

### Flow A: User asks a real-life problem

1. Always-on worldview is already active.
2. Router classifies the message as `challenge mode`.
3. System selects one primary challenge skill.
4. The challenge skill calls a small set of relevant cards.
5. Agent answers using:
   - worldview framing
   - problem diagnosis
   - key variables
   - Wan-style advice or experiments

Example:

User: "I feel my current work has no meaning, but I also don't dare to switch."

System behavior:

- worldview layer: active
- router -> `challenge mode`
- selected skill -> `career-direction`
- supporting cards -> `compounding`, `field`, `explore-exploit`,
  `ability-seeking`, `resonance`

### Flow B: User asks about a concept or a high viewpoint

1. Always-on worldview is already active.
2. Router classifies the message as `concept mode`.
3. System retrieves one target card plus a few linked cards if needed.
4. Agent answers using:
   - definition
   - non-obvious interpretation
   - use case
   - relation to larger worldview

Example:

User: "What does 'shi' mean in this system?"

System behavior:

- worldview layer: active
- router -> `concept mode`
- target card -> `shi`
- optional linked cards -> `generation`, `big-picture`, `morality`

### Flow C: Multi-turn switching

The conversation can switch between challenge mode and concept mode.

Examples:

- challenge -> concept:
  user first asks for life advice, then asks "what exactly do you mean by field?"
- concept -> challenge:
  user first asks what "Moloch" means, then asks how to avoid being trapped in it
  at work

The worldview layer remains active across all turns.

## Distillation Strategy

Each source article should eventually be compressed into an internal asset, but
the asset is not a normal summary.

A useful internal distillation format is:

- `thesis`: 1-3 core claims
- `biases`: 3-5 preferred judgments, recommendations, or recurring insights
- `challenge_map`: what kinds of user problems this helps with
- `worldview_hooks`: which stable worldview principles it strengthens
- `misreadings`: how users or models may oversimplify it

This allows the system to preserve judgment style without storing or replaying
large chunks of original text.

### Distillation Is P0

The most important operational capability is to absorb newly published material
quickly and convert it into plugin-ready assets.

That means the first serious system capability should be:

1. retrieve a new article
2. identify its strongest 1-3 claims
3. extract 3-5 Wan-style biases, recommendations, or "default leanings"
4. map it to one or more challenge types
5. map it to worldview hooks and linked cards
6. save a compact internal representation for later runtime retrieval

If this pipeline is weak, the plugin goes stale. If it is strong, the rest of
the system can stay relatively simple and still feel alive.

## Why Skills Should Be Challenge-Oriented

The user does not arrive with concept names. The user arrives with problems.

Therefore:

- challenge skills are the front door
- concept cards are the supporting layer
- article boundaries are internal only

For example, "How should I regulate negative emotion?" should be one skill that
can combine:

- cognitive decoupling
- identity
- WOOP
- security / support

Instead of forcing the user to know which term to ask for.

### Challenge Skills Must Be Concrete

The value of a challenge skill is not generic advice. The base model can
already produce generic advice.

The value is:

- better framing
- better prioritization
- more reality-based tradeoffs
- more Wan-style value judgments
- more usable next actions

Each challenge skill should therefore bias toward advice that is:

- practical rather than encyclopedic
- opinionated rather than neutral-by-default
- structurally aware rather than emotionally reactive
- aligned with Wan-style preferences such as compounding, system design,
  cooperation, generation, and changing the environment when needed

If a skill does not materially change the user's next move, it is too weak.

## Minimal v1 Structure

Possible internal structure:

- `worldview-core.md`
- `router.md`
- `challenge/`
- `cards/worldview/`
- `cards/concepts/`
- `cards/high-view/`

Conceptually, the plugin is:

- one main independent agent
- one always-on worldview core
- a small number of challenge skill overlays
- a larger card library

## Design Constraints

- do not mirror article structure directly in the user interface
- do not overload context with too many skills at once
- do not rely on generic advice the base model already knows
- do not optimize for quoting source material
- do optimize for judgment style, tool choice, and decision framing
- do keep the plugin narrow enough that it can ship and stay fresh without
  becoming a full personal operating system

## Open Questions for Next Iteration

- how small can `worldview-core.md` be while still preserving strong style?
- should some high-frequency concepts be promoted from cards into mini-overlays?
- should challenge routing be purely automatic, or should the agent sometimes
  explicitly confirm a detected problem frame?
- what is the minimum set of v1 challenge skills that already feels
  substantially useful to users?
- how should public-facing safety and tone be tuned so the system is strong in
  judgment without sounding preachy or overconfident?
- what is the minimum viable workflow for turning each new article into runtime
  assets within hours, not weeks?
