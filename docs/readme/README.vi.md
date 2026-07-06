# MedKarute (メドカルテ) - research-helper

**AI Orchestrator + Amanuensis for Research**
研究を支えるAIオーケストレーターと書記

> **English**: [README.md](../../README.md) (canonical)

**MedKarute** (trước gọi `research-helper`) là chat-driven research assistant: agent (orchestrator) điều phối workflow nghiên cứu qua chat, ghi kết quả vào file Markdown trong `research/{slug}/`, và gọi hai MCP — **MarkItDown** (PDF mới) và **endnote-mcp** (thư viện EndNote đã curate). Governance (`AGENTS.md`, `CLAUDE.md`, `docs/`) mô tả cách agent hoạt động; dữ liệu nghiên cứu tách riêng per-project.

## Bắt đầu

1. Clone/mở repo này.
2. Dùng **agent coding tool** (Claude Code, Grok CLI, Cursor, …) **hoặc** CLI thuần (`claude`, `grok`, …) — trong thư mục repo, nói **"bắt đầu"**.
3. Agent đọc `AGENTS.md` / `CLAUDE.md` → chạy onboarding (slug + purpose) → tạo `research/{slug}/` nếu chưa có project.

**Không có gì phức tạp.** Coding tool/IDE chỉ giúp nhìn file, diff, tree rõ hơn — bản chất vẫn là agent đọc các file `.md` đã commit. Dùng thuần CLI, không mở IDE, **vẫn chạy y hệt**; không phụ thuộc tool cụ thể.

> Hướng dẫn sử dụng cho người nghiên cứu (không phải cho agent): [`docs/guides/huong-dan-su-dung.md`](../guides/huong-dan-su-dung.md).

## Workflow (sơ lược)

```
                         +------------------+
                         | EndNote via user |
                         +--------+---------+
                                  ^
                                  |
  +---------+              +------+--------+              +-------------+
  | PDF mới |------------->|   paper note  |------------->|   insight   |
  +---------+              +---------------+              +------+------+
                                                                  |
  +--------------+         +---------------+                     |
  |  phiên chat  |-------->| session note  |---------------------+
  +--------------+         +---------------+                     |
                                                                  v
                                                           +-------------+
                                                           |   writing   |
                                                           +-------------+
```

Chi tiết artifact, INDEX, git per-project → [00-overview.md](../guides/research/00-overview.md).

## Công cụ & vai trò

| Công cụ | Vai trò trong MedKarute |
|---------|-------------------------------|
| **[MarkItDown MCP](https://github.com/microsoft/markitdown/tree/main/packages/markitdown-mcp)** | Convert PDF mới → Markdown token-efficient cho agent đọc (paper chưa vào EndNote). `uvx markitdown-mcp` |
| **[endnote-mcp](https://github.com/gokmengokhan/endnote-mcp)** | Đọc thư viện EndNote đã curate — search, đọc PDF sâu, format citation/bibliography. Read-only (write qua EndNote desktop). `uvx endnote-mcp serve` |
| **[WhySchools / context-mapping](https://github.com/WhySchools/context-mapping)** (context-gen) | **Cùng một nguồn** — workflow agentic *Human is the brain* của [WhySchools](https://github.com/WhySchools): bộ nhớ dự án trong `.context/` (GLOBAL, MILESTONES, TENSIONS, modules). Repo này áp dụng layout governance đó → [`.context/GLOBAL.md`](../../.context/GLOBAL.md). Brainstorm MCP sớm lưu tại [`research-helper.md`](../raws/research-helper.md). **Không phải dependency chạy** khi làm nghiên cứu hằng ngày |
| **Markpad** | App mở file `.md` local cho user xem note — không phải MCP, chỉ viewer |
| **[md-to-docx](https://github.com/pickle-an/md-to-docx-skill)** (agent skill) | Convert `writing/*.md` → Word `.docx` có format (version, TOC, front-matter). Bản vendored → [`.agents/skills/md-to-docx/`](../../.agents/skills/md-to-docx/) (`SKILL.md` + scripts). Không phải MCP — agent gọi qua skill discovery |

## Link nhanh

| File | Mục đích |
|------|----------|
| [AGENTS.md](../../AGENTS.md) | Invariants, startup order |
| [CLAUDE.md](../../CLAUDE.md) | Orchestrator playbook |
| [00-overview.md](../guides/research/00-overview.md) | Chi tiết workflow `research/` |
| [endnote-workflow.md](../decisions/endnote-workflow.md) | EndNote workflow (canonical) |
| [md-to-docx](../../.agents/skills/md-to-docx/) | Skill Markdown → Word (`SKILL.md`, link upstream) |
| [.agents/README.md](../../.agents/README.md) | Layout agent skills, symlink cross-agent |