# Guide — `research/{slug}/README.md`

## Vai trò

**Single source of truth** cho bối cảnh project. Tạo **một lần** khi onboarding xong (render từ `docs/templates/project-README.md.tpl`).

## Schema

```markdown
# {project-slug}

**Created**: YYYY-MM-DD
**Language**: EN | VI

## Research purpose
(bắt buộc)

## Research topic

## Deliverable

## Citation style

## Scope

## Setup notes
```

## Onboarding

**Bắt buộc** trước `mkdir`:

1. **Project slug** — tên thư mục
2. **Research purpose** — nghiên cứu để làm gì?

**Đề xuất** (có thể bỏ qua): topic, ngôn ngữ, deliverable, citation style, EndNote setup, scope, bắt đầu từ PDF hay search library.

→ Ghi vào README. Không tạo folder trước khi user trả lời slug + purpose.

## Setup notes — EndNote

Chỉ ghi **fact ổn định theo project**:

- Tên library
- Citation style
- Semantic on/off
- Ghi chú: machine state xem `.local/mcp/endnote.md`

**Không** ghi path tuyệt đối — README có thể mở trên máy khác.

## Agent

- Orientation: đọc README trước mọi task trong project
- Thiếu citation style → hỏi user **một lần**, ghi vào README, không hỏi lại