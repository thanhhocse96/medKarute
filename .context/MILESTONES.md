# Milestones

## 0.0.1 — Bootstrap governance

**Trạng thái**: `done` (smoke test 2026-07-03 — project mẫu `1bitllm-world-model`)

**Mục tiêu**: Promote cấu trúc governance từ `docs/raws/` sang file thật; agent có thể onboard project mới mà không cần đọc lại toàn bộ brainstorm.

### Acceptance criteria

- [x] `CLAUDE.md`, `AGENTS.md`, `.context/` tồn tại và nhất quán
- [x] `docs/guides/research/` — 7 file đủ nội dung
- [x] `docs/templates/` — 7 file `.tpl` render được project
- [x] `docs/decisions/endnote-workflow.md` + `docs/guides/mcp/endnote-mcp-tools.md`
- [x] `.local/` scaffold (schema, không path máy thật)
- [x] Onboarding smoke test: `research/1bitllm-world-model/` từ template + `git init` (2026-07-03)

**Ngoài scope 0.0.1**: `insights/QUESTIONS.md` review loop; `tools/pack-share.sh` code; `huong-dan-su-dung.md`.