# Tensions — Active

> Quyết định đã resolve trong milestone hiện tại.

## T-001 — endnote-mcp config: bỏ wrapper, chọn 1 trong 2 hướng lúc onboarding

**Resolved**: 2026-07-03 (user quyết, sau 3 vòng verify — web search, sandbox test, đọc source code thật `endnote_mcp==1.4.8`)

**Bối cảnh đầy đủ**: xem lịch sử trong `TENSIONS_OPEN.md` (archived) + `docs/raws/2026-07-03-endnote-mcp-verify-report.md`. Tóm tắt kỹ thuật: `endnote-mcp serve` không nhận flag; `Config.load()` tự tìm `config.yaml` ở **default platform dir** (`~/Library/Application Support/endnote-mcp/` Mac, `%APPDATA%\endnote-mcp\` Win, `~/.config/endnote-mcp/` Linux) nếu không có `ENDNOTE_MCP_CONFIG`. Wizard `endnote-mcp setup` tự ghi đúng vào default dir này.

**Quyết định**: **Bỏ wrapper script** (`tools/mcp-wrappers/run-endnote-mcp.sh`/`.cmd`) — cả 2 hướng thay thế dưới đây đều kết thúc bằng việc `config.yaml` nằm đúng default platform dir, nên `.mcp.json` trở lại **bare**:

```json
{ "mcpServers": { "endnote-mcp": { "command": "uvx", "args": ["endnote-mcp", "serve"] } } }
```

**Thiết kế mới — hỏi lúc onboarding, lưu lựa chọn, không hỏi lại**:

Khi phiên đầu tiên cần EndNote MCP mà `.local/mcp/endnote.md` chưa có `setup_method` — agent hỏi trong chat, đưa 2 lựa chọn kèm phân tích ngắn lợi/hại, để user tự chọn:

| # | Lựa chọn | Cách làm | Ưu | Nhược |
|---|----------|----------|-----|-------|
| **1** | **Setup thủ công (native wizard)** | User tự mở terminal, chạy `endnote-mcp setup` — 1 lần lúc cài máy. Tool tự tìm XML/PDF dir (heuristic có sẵn, tốt hơn agent đoán), tự ghi `config.yaml` default dir | Chịu khó 1 lần, nhưng **dễ kiểm soát** (đúng tool gốc, auto-detect mạnh), **tiết kiệm** — không tốn token agent | Cần tự tay mở terminal, đọc prompt tiếng Anh cơ bản |
| **2** | **Agent làm hộ (qua chat)** | Agent hỏi path XML/PDF trong chat → tự ghi trực tiếp `config.yaml` vào đúng default platform dir (biết trước theo `os_profile` trong `.local/ENVIRONMENT.md`) → tự chạy `index` | **Nhàn** — không đụng terminal, hoàn toàn qua chat | **Tốn token** (agent xử lý path, lỗi format, retry); **khó kiểm soát hơn** — không có auto-detect mạnh như wizard, rủi ro path sai mà agent không phát hiện ngay |

- Lưu lựa chọn: field mới `setup_method: native | agent` trong `.local/mcp/endnote.md`
- Nếu `native`: agent chỉ hướng dẫn 1 lần, chờ user xác nhận đã chạy xong (check `config.yaml` tồn tại ở default dir), không tự ghi gì
- Nếu `agent`: agent hỏi path trong chat → tự ghi `config.yaml` (4 field: `endnote_xml`, `pdf_dir`, `db_path`, `max_pdf_pages: 30`) vào default dir theo `os_profile` → tự `index`
- Cả 2 nhánh: sau khi có `config.yaml`, mọi thứ khác (mtime check, re-index, v.v.) giữ nguyên như `docs/decisions/endnote-workflow.md` đã chốt — không đổi gì ở §2–§8

**Việc cần làm (Grok)**:
1. Xóa `tools/mcp-wrappers/run-endnote-mcp.sh` + `.cmd`
2. Sửa `.mcp.json` — trả về bare `uvx endnote-mcp serve`, bỏ `command: bash`/wrapper
3. Sửa `docs/decisions/endnote-workflow.md §MCP config resolution` — thay toàn bộ nội dung phương án A/B/C/D bằng bảng 2-lựa-chọn ở trên + luồng onboarding
4. Thêm field `setup_method:` vào schema `.local/mcp/endnote.md` (trong decision doc §Schema + trong file `.local/mcp/endnote.md` thật)
5. Thêm bước hỏi 2-lựa-chọn vào `CLAUDE.md §G First-run onboarding` (chỉ khi phiên cần EndNote MCP mà chưa có `setup_method`) và `docs/guides/mcp/endnote-mcp-tools.md` (mục Prerequisite — sửa lại theo luồng mới)
6. Cập nhật `.local/mcp/endnote.md notes:` và `.local/claude-agent-summary.md` — bỏ pointer cũ trỏ tới wrapper, trỏ tới decision mới