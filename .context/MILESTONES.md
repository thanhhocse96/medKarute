# Milestones

## 0.0.1 — Bootstrap governance

**Trạng thái**: `in_progress`

**Mục tiêu**: Promote cấu trúc governance từ `docs/raws/` sang file thật; agent có thể onboard project mới mà không cần đọc lại toàn bộ brainstorm.

### Acceptance criteria

- [ ] `CLAUDE.md`, `AGENTS.md`, `.context/` tồn tại và nhất quán
- [ ] `docs/guides/research/` — 7 file đủ nội dung
- [ ] `docs/templates/` — 7 file `.tpl` render được project
- [ ] `docs/decisions/endnote-workflow.md` + `docs/guides/mcp/endnote-mcp-tools.md`
- [ ] `.local/` scaffold (schema, không path máy thật)
- [ ] Onboarding smoke test: scan script chạy, có thể tạo `research/{slug}/` từ template

**Ngoài scope 0.0.1**: `insights/QUESTIONS.md` review loop; `tools/pack-share.sh` code; `huong-dan-su-dung.md`.