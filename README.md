# MedKarute (メドカルテ) - research-helper

**AI Orchestrator + Amanuensis for Research**
研究を支えるAIオーケストレーターと書記

> **Languages**: [Tiếng Việt](docs/readme/README.vi.md) — more in [docs/readme/](docs/readme/) (human-only, not in agent load map)

**MedKarute** (formerly `research-helper`) is a chat-driven research assistant: an agent (orchestrator) runs the research workflow via chat, writes results to Markdown under `research/{slug}/`, and calls two MCP servers — **MarkItDown** (new PDFs) and **endnote-mcp** (curated EndNote library). Governance (`AGENTS.md`, `CLAUDE.md`, `docs/`) defines how the agent behaves; research data lives in separate per-project folders.

## Getting started

1. Clone or open this repo.
2. Use an **agent coding tool** (Claude Code, Grok CLI, Cursor, …) **or** a plain CLI (`claude`, `grok`, …) — from the repo root, say **"bắt đầu"** (or "start").
3. The agent reads `AGENTS.md` / `CLAUDE.md` → runs onboarding (slug + purpose) → creates `research/{slug}/` if you have no project yet.

**Nothing fancy.** A coding tool or IDE only makes files, diffs, and the tree easier to see — the agent still works from committed `.md` files. Plain CLI without an IDE **works the same**; no specific tool is required.

> End-user guide (distilled, for the researcher — not the agent): [`docs/guides/huong-dan-su-dung.md`](docs/guides/huong-dan-su-dung.md).

## Workflow (overview)

```
                         +------------------+
                         | EndNote via user |
                         +--------+---------+
                                  ^
                                  |
  +---------+              +------+--------+              +-------------+
  | New PDF |------------->|   paper note  |------------->|   insight   |
  +---------+              +---------------+              +------+------+
                                                                 |
  +--------------+         +---------------+                     |
  | chat session |-------->| session note  |---------------------+
  +--------------+         +---------------+                     |
                                                                 v
                                                           +-------------+
                                                           |   writing   |
                                                           +-------------+
```

Artifacts, INDEX routing, per-project git → [docs/guides/research/00-overview.md](docs/guides/research/00-overview.md).

## Tools & roles

| Tool | Role in MedKarute |
|------|-------------------------|
| **MarkItDown MCP** | Convert new PDFs → token-efficient Markdown for the agent (papers not yet in EndNote) |
| **endnote-mcp** | Read curated EndNote library — search, deep PDF read, citation/bibliography. Read-only (writes via EndNote desktop) |
| **[WhySchools / context-mapping](https://github.com/WhySchools/context-mapping)** (context-gen) | **Same lineage** — [WhySchools](https://github.com/WhySchools) *Human is the brain* agentic workflow: shared memory in `.context/` (GLOBAL, MILESTONES, TENSIONS, modules). This repo adopts that governance layout → [`.context/GLOBAL.md`](.context/GLOBAL.md). Early MCP brainstorm archived in [`docs/raws/research-helper.md`](docs/raws/research-helper.md). **Not a runtime dependency** for research sessions |
| **Markpad** | Local `.md` viewer for the user — not an MCP, viewer only |

## Quick links

| File | Purpose |
|------|---------|
| [AGENTS.md](AGENTS.md) | Invariants, startup order |
| [CLAUDE.md](CLAUDE.md) | Orchestrator playbook |
| [docs/guides/research/00-overview.md](docs/guides/research/00-overview.md) | `research/` workflow detail |
| [docs/decisions/endnote-workflow.md](docs/decisions/endnote-workflow.md) | EndNote workflow (canonical) |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Đóng góp — test thật, báo lỗi, sửa governance |
