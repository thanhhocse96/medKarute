# AGENTS.md — MedKarute

> Startup order, invariants, routing. Chi tiết workflow → `CLAUDE.md` + `docs/guides/`.

## §0 Milestone

**0.0.1 Bootstrap** — xem `.context/MILESTONES.md` cho acceptance criteria.

## §1 Startup order

Mỗi phiên mới, đọc theo thứ tự:

1. `.local/ENVIRONMENT.md` — `os_profile`, paths (nếu tồn tại)
2. `.context/GLOBAL.md`
3. `.context/MILESTONES.md`
4. `.context/TENSIONS_OPEN.md`
5. `.context/TENSIONS_ACTIVE.md`
6. `.context/modules/*.md` — chỉ module liên quan task
7. `.local/session.md` — `active_project`, `pending_actions`
8. `.local/claude-agent-summary.md` — nếu stale thì refresh (xem CLAUDE §F)

Không load mặc định: `docs/raws/`, `docs/readme/` (README locale — human-only), `docs/ideations/` scratch, `*HISTORY*`.

## §2 Invariants

| # | Invariant |
|---|-----------|
| 1 | **Chat ≠ storage** — quyết định, insight, paper note ghi vào file; chat chỉ điều phối |
| 2 | **Load một sub-INDEX** — không load đồng thời mọi `papers/` + `sessions/` + `insights/` + `writing/` |
| 3 | **MCP orchestrator-only** — subagent không gọi MCP; mọi `index`/`rebuild_index` qua orchestrator |
| 4 | **Docs protocol** — "docs lại" → session note; governance chỉ khi phiên tag `[governance:path]` |
| 5 | **Mermaid mandatory** — diagram trong file = Mermaid, không ASCII thay thế |
| 6 | **Governance-only-when-mentioned** — không sửa `CLAUDE.md`/`AGENTS.md`/`docs/decisions/` nếu phiên không bàn |
| 7 | **Per-project git** — `git -C research/{slug}/`; root không track `research/` |
| 8 | **Auto-commit** — sau ghi file có nghĩa; báo user một dòng: *"Đã lưu tự động."* |
| 9 | **Semi-tech** — nói thẳng subagent, MCP, orchestrator, INDEX trong chat |
| 10 | **Promote memory** — durable insight → đúng file dự án (`.context/`, `docs/decisions/`, guides); không `AGENT_SHARED.md` |

## §3 Tension format

- **OPEN** → `.context/TENSIONS_OPEN.md` — chưa resolve
- **ACTIVE** → `.context/TENSIONS_ACTIVE.md` — đã resolve, đang hiệu lực
- **HISTORY** — archive khi milestone đóng (không load mặc định)

Mỗi entry: `ID`, mô tả ngắn, options, quyết định (nếu ACTIVE), ngày.

## §4 Routing

| Mode | Khi nào |
|------|---------|
| **CODE_NOW** | User yêu cầu ghi file, ingest paper, docs lại — làm ngay |
| **ASK_ARCHITECTURE** | Thay đổi cấu trúc governance / invariant — hỏi user trước |
| **EXPLAIN** | User hỏi hiểu workflow — trích từ guide, không suy diễn |

## §5 Self-check (trước khi ghi file)

- [ ] Đã đọc guide đúng area (`docs/guides/research/{area}.md`)?
- [ ] Load đúng INDEX (một sub-INDEX)?
- [ ] Nội dung durable — không chỉ trong chat?
- [ ] Diagram = Mermaid?
- [ ] Governance file — phiên có đề cập rõ?
- [ ] Git commit trong `research/{slug}/` (không root)?

## §6 Promote path

```
docs/ideations/ (scratch, gitignored)
    → docs/decisions/ (quyết định chốt)
    → .context/modules/ (invariant module)
    → .context/GLOBAL.md (index active docs)
```

Brainstorm chưa chốt → giữ `docs/raws/` hoặc `docs/ideations/`; không promote.

## §7 Agent skills (symlinks)

Khi task **thêm hoặc vendored skill mới** — đọc `.agents/README.md` trước khi ghi.

| Quy tắc | Chi tiết |
|---------|----------|
| Source of truth | `.agents/skills/<name>/` — chỉ sửa ở đây |
| Symlink bắt buộc | Sau skill mới, tạo symlink `.claude/skills/`, `.codex/skills/`, `.grok/skills/` → cùng skill |
| Không tự sinh | Agent **không** auto-tạo symlink; orchestrator chạy bước symlink + commit root |
| Grok / Claude / Codex | Sản phẩm AI bên ngoài — repo chỉ layout path discovery |

```bash
SKILL=your-skill-name
for dir in .claude/skills .codex/skills .grok/skills; do
  mkdir -p "$dir"
  ln -sfn "../../.agents/skills/$SKILL" "$dir/$SKILL"
done
```

Chi tiết discovery paths và diagram → `.agents/README.md`.