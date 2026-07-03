# Tensions — Open

> Conflict chưa resolve. Promote sang `TENSIONS_ACTIVE.md` sau khi human quyết.

## T-001 — endnote-mcp native config (phương án D) vs wrapper (B)

**Ngày**: 2026-07-03  
**Ngữ cảnh**: Verify `uvx endnote-mcp --help` (v1.4.8) trước khi code wrapper QA4.

**Bằng chứng**:
- Tool có `config.yaml` mặc định theo OS (`~/Library/Application Support/endnote-mcp/` trên Mac, v.v.)
- `Config.load()` đọc `ENDNOTE_MCP_CONFIG` trỏ tới file YAML (`endnote_xml`, `pdf_dir`, `db_path`)
- `endnote-mcp serve` **không** có flag `--config` trên CLI
- `endnote-mcp setup` là wizard interactive — không phù hợp bác sĩ tự chạy terminal
- Biến `ENDNOTE_XML_PATH` trong skeleton `.mcp.json` cũ **không tồn tại** trong package

**Đề xuất (chưa đổi quyết định)**:
- Giữ wrapper B (đã code) làm bridge `.local/mcp/endnote.md` → runtime YAML
- Hoặc sau onboarding agent ghi thẳng `config.yaml` OS-default + bỏ wrapper — cần đồng bộ 2 nguồn với `endnote.md`

**Cần user quyết**: Có muốn thử phương án D (agent sync vào OS `config.yaml` lúc onboarding) thay wrapper không?

**Bổ sung (Claude QA, 2026-07-03)** — verify độc lập qua web search (máy dev không có `uv`/`uvx` để re-run trực tiếp `--help`): xác nhận repo thật `github.com/gokmengokhan/endnote-mcp`, field config khớp chính xác (`endnote_xml`, `pdf_dir`, `db_path`, `max_pdf_pages=30`) — bằng chứng Grok đưa ra đáng tin. Thêm 1 phát hiện Grok chưa nhắc: package có lệnh **`endnote-mcp install`** — "register with Claude Desktop" tự động. Nếu đúng, có thể thay được cả wrapper lẫn sửa tay `.mcp.json`. Đáng verify thêm (`uvx endnote-mcp install --help`) trước khi chốt T-001.