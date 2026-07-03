# Gap còn mở — không chặn governance (ghi nhận, không giải quyết)

> **Mục đích**: Liệt kê các điểm chưa chốt nhưng **không quan trọng** đủ để trì hoãn viết `CLAUDE.md` / `AGENTS.md`.  
> **Ngày**: 2026-07-03  
> **Nguồn**: `2026-07-03-APPROVAL-DRAFT.md`, `agent-memory-and-load-protocol.md`, `pack-share-script-plan.md`, `2026-07-03-generalization-review-workflow.md`, `endnote-workflow-open-questions.md`  
> **Quy ước**: Mỗi gap có **default tạm** (nếu có) để agent không bị kẹt; resolve sau khi dùng thật hoặc khi user chủ động mở lại.

---

## Phân loại

| Nhãn | Ý nghĩa |
|------|---------|
| **Default** | Có quy ước tạm — đủ để viết governance |
| **Defer** | Chờ dùng thật / promote sau |
| **Out of scope** | Ngoài milestone bootstrap — không làm trong lượt hiện tại |

---

## 1. Ngôn ngữ & tài liệu

| # | Gap | Default tạm | Lý do không giải quyết ngay |
|---|-----|-------------|------------------------------|
| G1 | Session note khi chat **trộn EN/VI** — ghi file bằng ngôn ngữ nào? | Ngôn ngữ **chiếm ưu thế** trong phiên; thuật ngữ AI/y khoa **giữ EN** (APPROVAL §12 #6) | *Không* lấy từ `claude-agents-design-synthesis.md` §10 (lịch sử cũ) |
| G2 | Governance (`CLAUDE.md`, guides) — **VI thuần** hay **song ngữ**? | **VI** + thuật ngữ kỹ thuật EN (subagent, MCP, INDEX…) — khớp persona semi-tech | Không ảnh hưởng cấu trúc; polish khi viết file thật |
| G3 | `huong-dan-su-dung.md` (hướng dẫn end-user tổng hợp) | **Không viết sớm.** Lượt **"viết"**: tạo `docs/guides/research/*` trước; `huong-dan-su-dung.md` chỉ **distill** sau khi guide đủ nội dung, hoặc agent **trích trực tiếp** từ guide + project khi user hỏi — không đoán / không "bằng niềm tin" | APPROVAL §3.5 quy tắc 3; §12 #7 "chưa viết" = đúng thứ tự |
| G4 | `docs/guides/platform/{mac,wsl,windows}.md` | Path/OS lấy từ `.local/ENVIRONMENT.md` + `os_profile`; platform guide **tùy chọn** | ENVIRONMENT đủ cho bootstrap; guide riêng là tiện ích, không invariant |

---

## 2. Memory & context

| # | Gap | Default tạm | Lý do không giải quyết ngay |
|---|-----|-------------|------------------------------|
| M1 | Agent **tự promote** vào `.context/` / `docs/decisions/` hay **hỏi trước** mỗi lần? | Promote **quyết định đã chốt trong chat** hoặc user nói rõ; brainstorm / path máy → không promote | Chi tiết vận hành; khung promote đã chốt (không `AGENT_SHARED`) |
| M2 | Refresh `.local/claude-agent-summary.md`: **mỗi phiên** hay chỉ khi **stale**? | Chỉ khi stale (thiếu file, governance đổi, user nói "refresh") | Tối ưu token; không đổi kiến trúc |
| ~~M3~~ | ~~`.buffer/context.md`~~ | **Không dùng** — chỉ `.local/claude-agent-summary.md` (cache) + promote vào `.context/` / `docs/` | Human chốt 2026-07-03: không cần `.buffer/` |
| M4 | `docs/ideations/` — chi tiết gitignore (file nào commit, scratch nào ignore) | Scratch trong `ideations/` **gitignore**; file đã promote sang `decisions/` **commit** — theo skvn | Hành vi đã có mẫu skvn; không cần spec riêng trước khi có ideation thật |

---

## 3. Pack / share scripts (plan only — chưa code)

| # | Gap | Default tạm | Lý do không giải quyết ngay |
|---|-----|-------------|------------------------------|
| P1 | `unpack-share.sh --merge-into`: quy tắc **đè từng file** (file-by-file vs whole-tree) | Merge **không đè** `.local/`; conflict `research/{slug}` → **dừng** trừ `--force`; chi tiết per-file **best-effort newer-wins** khi code | P1–P5 đã chốt; spec merge chi tiết là implementation detail |
| P2 | Governance zip có **root `.git/`** khi repo đã có remote | Exclude `.git/` ở governance pack (zip = portable tree, không thay `git pull`) | Repo chưa remote; quyết định sau khi có remote |
| P3 | Zip **mã hóa password** (`--password`) | **Không** trong MVP | Air-gap nice-to-have |
| P4 | `docs/guides/tool-pack-share.md` — file riêng hay mục trong `00-overview`? | Một đoạn ngắn trong `00-overview.md` trước; tách file nếu script phình | Tránh over-doc trước khi có script |

---

## 4. EndNote / MCP (workflow chính — chat sau; gap phụ không chặn)

> Workflow EndNote **quan trọng** nhưng đã có draft đủ trong `endnote-workflow-open-questions.md` + APPROVAL §12c. Các mục dưới là **chi tiết phụ** — không chặn viết governance skeleton.

| # | Gap | Default tạm | Lý do không giải quyết ngay |
|---|-----|-------------|------------------------------|
| E1 | **Tần suất** nhắc export XML (ngưỡng ngày) | **7 ngày** khi phiên có task library và XML stale (§6.5 endnote file) | Con số có thể chỉnh sau 1–2 tuần dùng thật |
| E2 | **Semantic embed** — thời điểm bật chính xác | BM25 trước; bật semantic khi library > ~100 ref hoặc `semantic_miss_count` chạm ngưỡng | Cần library thật để calibrate |
| E3 | **Audit log** tool calls MCP — file riêng? | **Không** — gộp `index`/`rebuild`/`embed` vào `.local/mcp/endnote-index.log` | Đã đề xuất trong endnote file §7.2 |
| E4 | **Tự động hóa** phát hiện user sửa/xóa ref trong EndNote (§6.2) | **Không realtime** — chỉ qua re-export XML + mtime + diff ref count | Hạn chế cấu trúc MCP; automation đầy đủ = out of scope |
| E5 | `rebuild_index` khi **đổi PDF attachment** — incremental có đủ không? | Nghi ngờ → `rebuild_index`; **verify 1 lần** khi test MCP thật rồi ghi vào guide | Cần test hành vi endnote-mcp thực tế |
| E6 | **`.ris` gitignore** cùng `.raw.md`? | **Có** gitignore — sinh lại từ paper note | Chi tiết template; không đổi luồng |
| E7 | Cột **EndNote ID** riêng vs ghi trong `Notes` ở `papers/INDEX.md` | Cột **`EndNote ID`** riêng (rõ hơn cho agent) | Cosmetic table layout |
| E8 | MCP config **1.7** — verify cú pháp `.mcp.json` khi setup thật | Skeleton trong repo; path máy trong env / `.local` | Dev đang nghiên cứu — không chặn draft CLAUDE |

---

## 5. Review / tổng quát hóa (`QUESTIONS.md` workflow)

> Toàn bộ thiết kế trong `2026-07-03-generalization-review-workflow.md` — **chưa promote** vào APPROVAL. **Không chặn** bootstrap governance.

| # | Gap | Default tạm | Lý do không giải quyết ngay |
|---|-----|-------------|------------------------------|
| R1 | Promote **insights/QUESTIONS.md** + review loop vào APPROVAL? | **Không** trong milestone 0.0.1 — chỉ `insights/` artifact cơ bản | Feature nâng cao; user chưa nói "promote" |
| R2 | Giá trị **2 knob** (N paper, M phiên im lặng) | **TBD** trong `.local` — không hard-code governance | Calibrate sau khi có project thật |
| R3 | Template chi tiết `QUESTIONS.md` / `QUESTIONS_ARCHIVE.md` | Defer đến lúc promote review workflow | Phụ thuộc R1 |
| R4 | Mermaid `mindmap` render trong **Markpad**? | Dùng `mindmap` trong insight; fallback `flowchart` nếu Markpad lỗi | Verify UI — không chặn CLAUDE |
| R5 | Session review có type riêng trong `sessions/INDEX.md`? | Ghi session note bình thường; tag `type: review` trong frontmatter **nếu có** | Low priority (§8 generalization doc) |
| R6 | **Deduction pass** (soi khung ngược library) — cuối phiên review hay phiên riêng? | **Cuối phiên review** nếu đã promote; hiện **không implement** | Trung bình — sau R1 |

---

## 6. Đã resolve — không còn là gap

| Điểm | Trạng thái |
|------|------------|
| `writing/INDEX.md` scaffold timing | **Resolved** — Hướng B tạo tất cả INDEX lúc onboarding |
| `AGENT_SHARED.md` | **Resolved** — không tạo; promote thẳng file dự án |
| Per-project git + auto-commit | **Resolved** — APPROVAL §3.3 |
| Pack P1–P5 (tools/, .git default, no raws) | **Resolved** — `pack-share-script-plan.md` |
| `.buffer/context.md` | **Resolved** — không dùng (human chốt) |
| Artifact `synthesis/` / `permanent/` | **Resolved** — đổi tên → **`insights/`** (APPROVAL §3.1). File `claude-agents-design-synthesis.md` = **lịch sử chat**, không phải spec cấu trúc |

---

## 7. Gap quan trọng — **không** nằm trong file này

Các mục sau **vẫn mở** và cần chat / lượt **"viết"** — **không** coi là "không quan trọng":

| Mục | File tham chiếu |
|-----|-----------------|
| EndNote workflow promote sang `docs/decisions/` + MCP guides | `endnote-workflow-open-questions.md` (chờ human duyệt lượt 2) |
| MarkItDown MCP guide chi tiết | `research-helper.md` → `docs/guides/mcp/markitdown-mcp.md` (khi viết) |
| Human checklist duyệt APPROVAL | `2026-07-03-APPROVAL-DRAFT.md` cuối file |
| Sinh `CLAUDE.md`, `AGENTS.md`, templates, scripts | Chờ user nói **"viết"** |

---

## 8. Cách agent xử lý gap trong file này

1. **Không** mở lại thảo luận trừ khi user hỏi hoặc default gây lỗi thực tế.
2. Khi viết governance: dùng **default tạm** ở cột trên; có thể ghi một dòng *"chi tiết: deferred-gaps-nonblocking.md"* trong guide nếu cần.
3. Khi gap phụ trở thành blocker → chuyển sang `TENSIONS_OPEN.md` hoặc chat chốt, **không** sửa im lặng default.

---

*Ghi nhận gap không chặn — research-helper, 2026-07-03.*