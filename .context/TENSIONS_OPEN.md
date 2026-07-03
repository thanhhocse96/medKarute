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