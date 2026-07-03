# Guide — `writing/`

## Vai trò

Prose: section, lit review, bản viết từ insight. *Mình viết ra sao?*

## Draft — placeholder citation

Lúc draft chèn **placeholder ổn định**:

```
[@{endnote_id}]
```

hoặc `[@{slug}]` nếu chưa có id — **không** format sớm (đoạn văn còn sửa/xóa).

## Finalize

1. Quét placeholder trong `writing/{slug}.md`
2. `get_citation` cho inline (style từ README § Citation style)
3. `get_bibliography` cho danh sách cuối
4. Placeholder không resolve (paper chưa EndNote) → liệt kê cho user

## `get_bibtex` vs `get_citation`

| Tool | Khi nào |
|------|---------|
| `get_citation`, `get_bibliography` | Mặc định — Word, Markdown |
| `get_bibtex` | Chỉ khi deliverable LaTeX/Overleaf → xuất `writing/{slug}.bib` |

Không dùng song song 2 đường cho cùng một bản viết.

## Citation map (on-demand)

Placeholder `[@id]` trong text = audit trail (grep được).

Thêm `## Citation map` (Claim → endnote_id → paper note) **chỉ khi user yêu cầu** kiểm tra chéo — không maintain realtime.

## MCP lỗi

Fallback: giữ placeholder `[@slug]`; resolve sau khi MCP sống lại.

## INDEX

| Title | File | Status | Notes |

Cập nhật sau mỗi bản viết có nghĩa.