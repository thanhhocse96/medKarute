# Guide — `insights/`

## Vai trò

**Mental model** của người nghiên cứu: khung khái niệm, quan hệ giữa paper, giả thuyết, gap, góc lập luận.

**Không** phải:

- Tóm tắt từng bài → `papers/{slug}.md`
- Log chat → `sessions/`

## Insight note — schema gợi ý

```markdown
---
type: insight
project: {slug}
title: ...
related_papers: [papers/foo.md, papers/bar.md]
date: YYYY-MM-DD
---

# {title}

## Mental model

## Evidence from papers
- Paper A: …
- Paper B: …

## My position / critique

## Open questions

## Diagrams

```mermaid
...
```
```

## Liên kết paper

- Bắt buộc link `papers/foo.md` trong Evidence
- `endnote_id` **không** bắt buộc ở insight — tra qua paper note (tránh duplicate drift)
- Chiều tra cứu: insight → paper note → `endnote_id`

## INDEX

| Title | File | Related papers | Tags | Status |

Khi insight reference paper → cập nhật `papers/INDEX` status lên `linked-insight` nếu chưa cao hơn.

## Khi nào tạo insight

- Sau đọc nhiều paper, cần khung tổng hợp
- Sau session có quyết định/thiết kế mental model
- Trước viết Related Work / section lớn

## `list_references_by_topic`

Dùng lúc **khởi tạo insight mới** — liệt kê ứng viên trong library trước khi đọc sâu. Không dùng cho tra cứu hằng ngày.

## Ngoài scope 0.0.1

`insights/QUESTIONS.md` review loop — xem `docs/raws/2026-07-03-generalization-review-workflow.md` (chưa promote).