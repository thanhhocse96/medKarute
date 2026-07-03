# docs/raws — trạng thái & quy ước liên-agent (Claude + Grok)

> **Đọc file này TRƯỚC khi sửa bất kỳ file nào trong `docs/raws/`.**
> Thư mục này là vùng brainstorm dùng chung giữa **Claude** (Sonnet, chủ yếu ghi doc/design) và **Grok** — hai góc nhìn khác nhau nên sẽ có bất đồng, file này để tránh ghi đè hoặc "tái thảo luận" thứ đã duyệt.

---

## Vai trò hiện tại (từ 2026-07-03, có thể đổi lại — xem dòng cập nhật cuối bảng)

| Agent | Vai trò | Được làm | Không làm |
|---|---|---|---|
| **Grok** | **Thực thi (execute)** | Ghi thật `CLAUDE.md`, `AGENTS.md`, `.context/`, `docs/decisions/`, `docs/guides/`, `docs/templates/`, `.local/` scaffold — theo đúng nội dung đã CHỐT trong bảng trên + `2026-07-03-governance-promotion-plan.md` | Tự quyết kiến trúc mới ngoài phạm vi đã chốt; tự promote thứ còn "brainstorm mở" mà chưa qua user |
| **Claude** | **QA (review)** | Đọc lại file Grok ghi ra, đối chiếu với raws đã CHỐT, báo sai lệch/thiếu sót/mâu thuẫn cho user — **không** tự sửa file governance trực tiếp trừ khi user yêu cầu | Không tự ghi `CLAUDE.md`/`AGENTS.md`/`docs/decisions/`/`docs/guides/` mới trong giai đoạn này |

Đổi vai trò → user nói lại trong chat, cập nhật dòng này.

---

## Quy ước bắt buộc

1. **"Đã chốt" (CHỐT / human đã duyệt) = không tự sửa nội dung gốc.** Muốn phản biện → thêm section mới cuối file gốc, đặt tên rõ ràng ví dụ `## Phản biện của Grok — YYYY-MM-DD`, giữ nguyên phần đã chốt bên trên.
2. **Mâu thuẫn thật sự** (không phải góc nhìn bổ sung mà là phủ quyết quyết định đã duyệt) → **không** tự sửa, không tự chọn bên nào đúng. Ghi vào `## Mâu thuẫn cần human quyết` trong file liên quan + báo user trong chat.
3. File **chưa có nhãn CHỐT** (xem bảng dưới, cột Trạng thái = "brainstorm mở") → tự do đề xuất, sửa, viết thêm bình thường.
4. **Không** xoá nội dung của agent kia. Thêm, không thay thế — lịch sử tranh luận có giá trị.
5. Chỉ **human** (user) mới promote file từ `docs/raws/` sang `docs/decisions/`, `CLAUDE.md`, `AGENTS.md`, `docs/guides/`. Agent nào cũng không tự promote.

---

## Bảng trạng thái từng file (cập nhật 2026-07-03)

| File | Trạng thái | Tóm tắt đã chốt (nếu có) |
|---|---|---|
| `research-helper.md` | Brainstorm gốc — **đã bị thay thế một phần** | MCP + 12 tools endnote-mcp vẫn đúng (nguồn cho `docs/guides/mcp/endnote-mcp-tools.md`). Phần note-taking kiểu Obsidian/`notes/literature/` **đã bỏ** — xem APPROVAL-DRAFT §3.2 (đổi tên `papers/`, `insights/`, `writing/`) |
| `2026-07-03-claude-agents-design-synthesis.md` | **Lịch sử chat — không phải spec** | Cấu trúc cũ (`notes/literature/`, `drafts/`, `synthesis/`) đã bị **APPROVAL-DRAFT ghi đè**. Chỉ đọc để hiểu tại sao chốt vậy, không lấy tên thư mục từ đây |
| `2026-07-03-APPROVAL-DRAFT.md` | **CHỐT — cấu trúc chính** (chờ 1 lệnh "viết" để ghi ra file thật) | Cấu trúc `research/{slug}/` (papers/sessions/insights/writing), 2 lớp file governance vs research, git local per-project + auto-commit, INDEX phân tầng, onboarding hỏi trước khi mkdir, docs-lại protocol, Mermaid bắt buộc. Checklist duyệt cuối file — mọi mục đã tick |
| `endnote-workflow-open-questions.md` | **CHỐT** — user đã đánh "Đồng ý" toàn bộ §1–§8 (2026-07-03) | mtime-check thay vì hỏi mỗi phiên; `.ris` (không BibTeX) để import EndNote; EndNote read-only qua MCP, write qua user; EndNote attachment = bản chính sau `in-endnote`; status flow paper `new→processed→in-endnote→linked-insight`. §6.2 (tự động hoá phát hiện user sửa EndNote) = **không khả thi**, đã trả lời trong `governance-promotion-plan.md` §2 |
| `pack-share-script-plan.md` | **CHỐT plan** (P1–P5), **chưa code** | `tools/pack-share.sh` + `tools/unpack-share.sh` (commit), 2 mode `governance`/`research`, research zip mặc định gồm `.git/`, không pack `docs/raws/` |
| `deferred-gaps-nonblocking.md` | **Sổ tay default tạm** — không phải quyết định cần duyệt, mà là danh sách "đừng chặn governance vì gap này" | Mỗi gap có default + lý do defer. Cập nhật cột "Default" nếu có quyết định mới, đừng xoá dòng |
| `agent-memory-and-load-protocol.md` | **Phần lớn đã chốt qua deferred-gaps** | Không có `AGENT_SHARED.md`; promote thẳng vào file dự án theo bảng §3.3; `.local/claude-agent-summary.md` chỉ là cache. Câu hỏi M2–M5 còn treo trong file này **đã có default** ở `deferred-gaps-nonblocking.md` (M1, M2, G4) |
| `2026-07-03-generalization-review-workflow.md` | **Brainstorm đã chốt kỹ (3 vòng phản biện) nhưng NGOÀI milestone 0.0.1** | Toàn bộ thiết kế QUESTIONS.md review loop hợp lệ để dùng sau — **không** promote lượt governance hiện tại. Xem `deferred-gaps-nonblocking.md` §R1 |
| `2026-07-03-governance-promotion-plan.md` | **Đã thực thi** (2026-07-03) | Governance đã promote — xem file list §1; smoke test onboarding khi tạo project thật |

---

## Nếu bạn là Grok đọc file này lần đầu

- Đừng đề xuất lại cấu trúc thư mục `research/{slug}/` từ đầu — đã chốt ở APPROVAL-DRAFT §3, qua nhiều vòng phản biện, có checklist duyệt.
- Đừng đề xuất lại tên `insights/`/`writing/` (từng là `synthesis/`/`drafts/`/`permanent/` — đã đổi, đã chốt).
- Muốn thảo luận điểm mới → viết vào file `docs/raws/` mới hoặc thêm section vào file liên quan, đừng sửa trực tiếp phần đã chốt.
- Governance thật (`CLAUDE.md`, `AGENTS.md`, `docs/decisions/`, `docs/guides/`, `docs/templates/`, `.context/`) **đã tồn tại** từ 2026-07-03. Brainstorm tiếp tục ở `docs/raws/`.

---

*File này do Claude tạo theo yêu cầu user (2026-07-03) — cập nhật bảng trạng thái mỗi khi có file raws mới hoặc quyết định mới được chốt.*
