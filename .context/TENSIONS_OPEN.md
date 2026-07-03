# Tensions — Open

> Conflict chưa resolve. Promote sang `TENSIONS_ACTIVE.md` sau khi human quyết.

## T-001 — RESOLVED 2026-07-03, xem `TENSIONS_ACTIVE.md`

## T-002 — Mac (persona chính) chưa smoke-test thật

**Ngày**: 2026-07-03
**Ngữ cảnh**: Sau khi bridge Windows+WSL được smoke-test thật (JSON-RPC handshake thật qua `wsl.exe`, xem T-001/`TENSIONS_ACTIVE.md`) — nhận ra **toàn bộ test thật hôm nay chỉ chạy trên Windows+WSL**. Mac — persona chính theo `docs/decisions/endnote-workflow.md §1` ("Mac ưu tiên") — **chưa có 1 lần chạy thật nào**, chỉ verify qua đọc source code (`config.py`, `cli.py` trong sandbox `_endnote-mcp-sandbox`).

**Gap cụ thể**:

| # | Gap | Mức độ | Nguồn đã biết (source code, chưa chạy thật) |
|---|---|---|---|
| 1 | Chưa smoke-test `endnote-mcp setup`/`serve` thật trên máy Mac | Cao — persona chính | `get_config_dir()` → `~/Library/Application Support/endnote-mcp/config.yaml` (đọc source, không phải suy đoán) |
| 2 | QA1/QA2 — chưa có hướng dẫn cài `uv`/`uvx` (`brew install uv`) ở guide nào, kể cả Mac | Trung bình — chặn bước đầu | Không có trong raws — gap thật, chưa từng ghi |
| 3 | `setup` wizard heuristic scan XML/PDF trên Mac (bỏ qua `iCloud`/`.Library` để tránh treo) chưa test với iCloud Drive bật thật | Trung bình | `_find_or_ask_xml`/`_find_or_ask_pdf_dir` trong `cli.py` — đọc code, chưa chạy |
| 4 | QA3 — `endnote-mcp install` (đăng ký `claude_desktop_config.json` tại `~/Library/Application Support/Claude/`) chưa test thật trên Mac | Thấp-trung bình | `_install_claude_desktop()` trong `cli.py` — đọc code, chưa chạy |

**Blind spot cần nói rõ**: không có máy Mac để tự test (làm việc trên Windows) — không thể tự lấp gap này bằng cách đọc code thêm.

**Hướng giải quyết đã chốt (user, 2026-07-03)**:
1. **Tài liệu trước** — tổng hợp mọi thứ đã biết qua source code vào 1 chỗ rõ ràng (không rải rác như hiện tại), đánh dấu rõ "biết qua source code, chưa chạy thật" cho từng điểm — **Đã làm**: `docs/decisions/endnote-workflow.md §Mac — status verify`
2. **Cập nhật khi có máy Mac thật** — agent (không phải người dùng) tự chạy onboarding thật trên máy Mac, phát hiện sai lệch thì tự sửa file, lặp lại tới khi ổn định
3. **Quy trình PR — agent làm hộ, người dùng chỉ duyệt** (chốt lại 2026-07-03, sửa lại hướng ban đầu — ban đầu tưởng người dùng tự tay PR, **sai**): sau khi agent sửa + test ổn định, agent **hỏi lại người dùng** trước khi commit — giải thích ngắn "PR = Pull Request, không phải quảng cáo (public relations) — cách gửi bản sửa lại cho dự án gốc để người nghiên cứu khác dùng chung". Người dùng đồng ý → agent tự `git commit` + tạo PR. Không tự ý commit/PR khi chưa hỏi. Chi tiết đầy đủ (checklist "ổn định", giới hạn 3 vòng lặp, branch riêng, review bằng cách tự chạy thử thay vì đọc diff, log debug sanitize, không quan tâm nếu user từ chối PR) → `CONTRIBUTING.md`

**Việc cần làm (chưa làm)**: chưa có máy Mac thật để agent tự chạy bước 2 — chờ tới khi có.

<!-- none khác đang mở -->

<details><summary>Lịch sử T-001 (đã archive nội dung đầy đủ vào TENSIONS_ACTIVE.md)</summary>

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

**Bổ sung 2 (Claude, spawn Haiku sandbox test trong WSL Debian, 2026-07-03)** — verify hands-on bằng cách cài thật trong `D:\Github\_endnote-mcp-sandbox` (env cô lập, xoá được không ảnh hưởng máy). **Lưu ý độ tin cậy**: subagent claim đã ghi `VERIFY-REPORT.md` nhưng file đó **không tồn tại** — không nhận nguyên văn tóm tắt, chỉ giữ lại phần có bằng chứng vật lý còn sót (uv cache chứa gói thật `pymupdf`/`uvicorn`/`httpx`/`starlette`/`typer`, `test-config.yaml` sinh ra khớp field name Grok đã ghi):

- Xác nhận `ENDNOTE_XML_PATH` không tồn tại, `ENDNOTE_MCP_CONFIG` có tác dụng — khớp claim Grok
- **Phát hiện tinh hơn**: `index`/`embed`/`status` nhận flag `--config PATH`; **riêng `serve` thì KHÔNG** — chỉ đọc qua env var `ENDNOTE_MCP_CONFIG`. Đây là lý do kỹ thuật **bắt buộc** phải dùng wrapper set env var cho `serve` — không phải chỉ vì persona bác sĩ. Củng cố phương án B là lựa chọn đúng, không chỉ là lựa chọn "dễ hơn"
- `max_pdf_pages=30` default — chưa test được (cần runtime, không thấy trong `--help`)
- Ghi chú phụ: WSL Debian thật (không phải sandbox) đã có sẵn `~/.cache/uv`, `~/.config/uv`, thư mục `.grok/` — cho thấy Grok verify T-001 gốc nhiều khả năng chạy trên máy thật (không phải bịa), nhưng cũng nghĩa là **không cô lập môi trường** — lưu ý cho lần test sau.

**Vẫn cần user quyết**: giữ wrapper B (đã verify 2 lần độc lập, kỹ thuật đúng) hay thử luôn `endnote-mcp install` xem có đơn giản hoá được không.

**Bổ sung 3 (Claude, đọc source code thật `endnote_mcp==1.4.8` trong sandbox, 2026-07-03)** — báo cáo đầy đủ: `docs/raws/2026-07-03-endnote-mcp-verify-report.md`. Tóm tắt: `serve()` không nhận flag nào; `Config.load()` tự fallback default platform config dir nếu không có `ENDNOTE_MCP_CONFIG`. Hệ quả: nếu `endnote-mcp setup` (wizard có sẵn, tự tìm XML/PDF dir tốt hơn wrapper) chạy **một lần lúc cài máy**, `.mcp.json` có thể bare 3 dòng, **bỏ hẳn wrapper**. Đánh đổi: cần 1 bước terminal 1-lần (dev làm hộ hoặc hướng dẫn). Đề xuất 3 hướng trong report §5 — **user quyết**, chưa tự đổi `docs/decisions/endnote-workflow.md`.

</details>