# GLOBAL — research-helper

> AI memory dùng chung (commit). Cập nhật khi có invariant mới hoặc promote từ phiên chat.

## Invariants (tóm tắt)

- Chat ≠ storage — nội dung durable ghi vào `research/{slug}/` hoặc `docs/`
- `research/{slug}/` = git repo riêng; root ignore `research/`
- Agent auto-commit sau mỗi lượt ghi có nghĩa — báo *"Đã lưu tự động."*
- INDEX phân tầng — load **một** sub-INDEX theo task
- EndNote MCP: orchestrator-only; read-heavy; write library qua user
- Mermaid bắt buộc cho diagram trong session/workflow doc
- Governance (`CLAUDE.md`, `AGENTS.md`, `docs/decisions/`) chỉ sửa khi phiên **đề cập** rõ

## Module index

| Module | Guide | Ghi chú |
|--------|-------|---------|
| Overview | `docs/guides/research/00-overview.md` | Phiên mới / orientation |
| README | `docs/guides/research/readme.md` | Identity project |
| INDEX | `docs/guides/research/index-routing.md` | Router + load map |
| Papers | `docs/guides/research/papers.md` | PDF, paper note, EndNote |
| Sessions | `docs/guides/research/sessions.md` | "docs lại", subagent |
| Insights | `docs/guides/research/insights.md` | Mental model |
| Writing | `docs/guides/research/writing.md` | Prose, citation |
| EndNote MCP | `docs/guides/mcp/endnote-mcp-tools.md` | 12 tools |
| MarkItDown | `docs/guides/mcp/markitdown-mcp.md` | PDF convert (stub) |
| EndNote decision | `docs/decisions/endnote-workflow.md` | Canonical workflow |

## Active docs (bootstrap)

- `docs/guides/research/*.md` (7)
- `docs/guides/mcp/endnote-mcp-tools.md`, `markitdown-mcp.md`
- `docs/decisions/endnote-workflow.md`
- `docs/templates/*.tpl` (7)

**Không** trong active docs: `docs/raws/`, `docs/readme/` (README locale cho human — root `README.md` EN là canonical).

## `modules/` — cách dùng

Thư mục `.context/modules/` rỗng lúc bootstrap. Tạo file khi có invariant **theo module**, ví dụ:

- `modules/papers.md` — quy tắc đặc thù papers (ngoài guide chung)
- `modules/mcp-endnote.md` — state machine index nếu phình

Không duplicate nội dung đã có trong `docs/guides/` — module chỉ ghi delta/invariant ngắn.