# MarkItDown MCP

> Server config đã verify thật (2026-07-03) — xem `docs/decisions/endnote-workflow.md §MCP config resolution` cho bảng platform case đầy đủ (áp dụng chung cho mọi server `uvx`-based, không riêng endnote-mcp).

## Server config

- Cài `uv`/`uvx` — xem `docs/guides/mcp/endnote-mcp-tools.md §Cài đặt` (chung cho cả 2 server, không lặp lại ở đây)
- `.mcp.json` sinh từ `.mcp.json.tpl` (gitignored, không commit) — mặc định bare `uvx markitdown-mcp`
- **Case Windows+WSL bridge**: `markitdown` cũng phải bridge qua `wsl.exe` giống `endnote-mcp` — máy chọn case này thường **không có `uvx` trên Windows native PATH** (chỉ cài trong WSL), nên giữ `command: uvx` trực tiếp sẽ lỗi khởi động MCP. Test thật xác nhận: `wsl.exe -d <distro> -e bash -lc "uvx markitdown-mcp"` → handshake OK (`serverInfo: markitdown v1.8.1`)
- Không cần path cá nhân (không đọc XML library) — lý do cần bridge chỉ là "PATH có `uvx` không", không phải library path

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
- Warning vô hại lúc khởi động (`ffmpeg`/`avconv` not found) — chỉ ảnh hưởng convert audio, không ảnh hưởng PDF

<!-- TODO: limits, prompt mẫu — chưa test thật convert PDF cụ thể -->