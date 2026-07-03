# MarkItDown MCP (stub)

> Chi tiết đầy đủ defer — verify khi test MarkItDown thật.

## Vai trò

Convert **PDF mới** → Markdown token-efficient cho agent đọc.

## Input / output

- Input: `papers/{slug}.pdf`
- Output: `papers/{slug}.raw.md` (gitignore — sinh lại được)

## Khi nào dùng

Paper chưa trong EndNote library — luồng đầy đủ → [papers.md](../research/papers.md).

## Giới hạn

- Chỉ orchestrator gọi MCP
- Không thay EndNote cho paper đã trong library (`read_pdf_section`)

<!-- TODO: server config, limits, prompt mẫu — khi setup thật -->