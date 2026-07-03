# Plan promote governance — Milestone 0.0.1 (chờ duyệt)

> **Mục đích**: Danh sách đầy đủ file sẽ ghi khi user nói "viết", nguồn quyết định của từng file, và các điểm còn mở cần xác nhận trước.
> **Ngày**: 2026-07-03
> **Nguồn**: toàn bộ `docs/raws/*.md` hiện có.
> **Trạng thái**: **Đã ghi** — user duyệt 2026-07-03.
> **Ngôn ngữ file governance**: VI + thuật ngữ kỹ thuật EN (deferred-gaps G2).

---

## 0. Phạm vi milestone 0.0.1 — trong / ngoài

| # | Hạng mục | Scope | Deliverable chi tiết | Lý do defer (nếu ngoài) |
|---|---|---|---|---|
| 0.1 | Root governance | **Trong** | `CLAUDE.md`, `AGENTS.md`, `.gitignore`, `.mcp.json` (skeleton) | — |
| 0.2 | AI memory | **Trong** | `.context/GLOBAL.md`, `MILESTONES.md`, `TENSIONS_*.md`, `modules/` (rỗng) | — |
| 0.3 | Research guides | **Trong** | 7 file `docs/guides/research/*.md` — đủ nội dung dùng thật, không skeleton trống | — |
| 0.4 | Templates | **Trong** | 7 file `docs/templates/*.tpl` + placeholder đã chốt | — |
| 0.5 | EndNote decision | **Trong** | `docs/decisions/endnote-workflow.md` — distill §1–§8 endnote file | — |
| 0.6 | MCP guides | **Trong** | `endnote-mcp-tools.md` (đầy đủ); `markitdown-mcp.md` (**stub** ~15–25 dòng) | Chi tiết MarkItDown defer E7 |
| 0.7 | Machine scaffold | **Trong** | `.local/` schema + script scan — **không** điền path máy dev | Path runtime = user setup sau |
| 0.8 | Review loop | **Ngoài** | — | `QUESTIONS.md` workflow — deferred-gaps §R1 |
| 0.9 | Pack/share scripts | **Ngoài** | Chỉ 1 dòng mention trong `00-overview.md` | P1–P5 chốt plan, chưa code |
| 0.10 | Platform guides | **Ngoài** | — | `docs/guides/platform/{mac,wsl,windows}.md` — ENVIRONMENT đủ bootstrap (G4) |
| 0.11 | End-user distill | **Ngoài** | — | `huong-dan-su-dung.md` — distill sau khi guide đủ (G3) |
| 0.12 | `.mcp.json` verify | **Một phần** | Ghi skeleton + `// TODO: verify khi setup thật` | Cú pháp final chờ test MCP thật (E8) |

**Tổng file sẽ tạo**: ~**32 file** (4 root + 4 `.context` + 1 decision + 2 mcp guides + 7 research guides + 7 templates + 6 `.local` + 1 `.gitignore` đã tính trong root).

---

## 1. File governance sẽ ghi — bảng đầy đủ

### 1.1 Root

| File | Nguồn quyết định | Nội dung chính | Sections / outline chi tiết | Ước tính | Không ghi / placeholder |
|---|---|---|---|---|---|
| `CLAUDE.md` | APPROVAL §10 (A–J) + endnote §9 + agent-memory §3.3 + §5.6 load map | Orchestrator playbook — workflow, MCP, memory, docs | **A** Quick workflow (MCP + `research/` + README + INDEX). **B** MCP routing table (§9 APPROVAL). **C** Template pointers → `docs/templates/`. **D** Docs protocol + governance-only-when-mentioned (§7). **E** Subagent: cold, không ghi file, không gọi MCP (endnote §7.1). **F** `.local/` cache + promote rules (bảng §3.3 agent-memory). **G** Onboarding §6 (câu hỏi bắt buộc/đề xuất). **H** Response style: semi-tech, EN/VI, thuật ngữ EN (§12 #3,6). **I** Mermaid mandatory (§8). **J** Load map `docs/guides/research/{area}.md` (§5.6). **+** EndNote quick ref → link `endnote-mcp-tools.md` | ~250–350 dòng | Không hard-code path Mac/Win; không `AGENT_SHARED.md` |
| `AGENTS.md` | APPROVAL §11 | Agent startup + invariants | **§0** Milestone 0.0.1 acceptance (bootstrap xong khi nào). **§1** Startup: GLOBAL → MILESTONES → TENSIONS_OPEN → TENSIONS_ACTIVE → modules. **§2** Invariants: chat≠storage; load 1 sub-INDEX; MCP orchestrator-only; docs protocol; mermaid; governance chỉ khi phiên đề cập; per-project git + auto-commit + 1 dòng "Đã lưu tự động." **§3** Tension format (OPEN/ACTIVE/HISTORY). **§4** Routing: CODE_NOW / ASK_ARCHITECTURE / EXPLAIN. **§5** Self-check trước ghi file. **§6** ideations → decisions promote | ~120–180 dòng | Không duplicate toàn bộ CLAUDE — chỉ invariant + startup |
| `.gitignore` | APPROVAL §3.3 + deferred P2 | Tách governance vs research | 3 dòng chính: `research/`, `.local/`, `share/out/` | ~10 dòng | Không ignore `docs/raws/` (brainstorm commit) |
| `.mcp.json` | endnote §1.7 + APPROVAL §12c | MCP server entries | 2 server: `endnote-mcp` + `markitdown` — command/args chung; env var placeholder `ENDNOTE_XML_PATH` (không path thật); comment block hướng dẫn Claude Desktop vs Claude Code | ~30–50 dòng | `// TODO verify syntax` — không commit secret |

### 1.2 `.context/` (AI memory — commit)

| File | Nguồn | Nội dung | Chi tiết sẽ ghi | Seed lúc bootstrap |
|---|---|---|---|---|
| `GLOBAL.md` | agent-memory §3.1 | Invariants + module index | Header + bảng module (papers/sessions/insights/writing/MCP) trỏ `docs/guides/`; danh sách "active docs" (7 research guides + 2 MCP guides + endnote decision); 1 đoạn cách dùng `modules/` | Có nội dung seed — không trống |
| `MILESTONES.md` | APPROVAL §0, §11 | Milestone tracking | **0.0.1 Bootstrap**: acceptance criteria (file list §1 tồn tại; onboarding chạy được; chưa cần project thật); trạng thái `in_progress` → user đánh `done` sau smoke test | Có nội dung seed |
| `TENSIONS_OPEN.md` | agent-memory §3.3 | Conflict chưa resolve | Template header + `<!-- none -->` | Rỗng có header |
| `TENSIONS_ACTIVE.md` | như trên | Quyết định đã resolve | Template header + `<!-- none -->` | Rỗng có header |
| `modules/` | agent-memory §3.1 | Invariant theo module | Thư mục rỗng; hướng dẫn trong `GLOBAL.md`: tạo `modules/papers.md` khi có invariant module-specific | Không tạo file con |

### 1.3 `docs/decisions/`

| File | Nguồn | Nội dung | Sections outline | Invariant phải có |
|---|---|---|---|---|
| `endnote-workflow.md` | `endnote-workflow-open-questions.md` §1–§8 (đã "Đồng ý") | Decision record — canonical EndNote | **1** Setup (mtime-check 1.2, BM25 trước semantic 1.6, schema `.local/mcp/endnote.md` 7.4). **2** Paper mới (luồng 8 bước + mermaid từ §2). **3** Tra cứu (tool routing §3). **4** Citation/writing (placeholder `[@id]` §4). **5** Insight/session link (status flow §5.3, pending_actions §5.2). **6** Bảo trì (event-driven index §6.1; **§6.2 không realtime** — chỉ re-export + diff count; rebuild rules §6.3–6.4; nhắc XML 7 ngày §6.5). **7** Agent rules (orchestrator-only MCP §7.1). **8** Git/privacy (XML/SQLite không commit §8; PDF độc lập §8.3) | mtime-check; `.ris` not BibTeX; read-only MCP; EndNote attachment = bản chính sau `in-endnote`; status `new→processed→in-endnote→linked-insight` |

### 1.4 `docs/guides/mcp/`

| File | Nguồn | Nội dung | Sections outline | Ước tính |
|---|---|---|---|---|
| `endnote-mcp-tools.md` | `research-helper.md` (12 tools) + endnote §3, §7 + §2 phản biện chung | Hướng dẫn vận hành MCP | **Prereq**: export XML + `.local/mcp/endnote.md`. **Bảng 12 tools** (tên, mô tả, khi nào). **Routing**: search_library ★ → semantic → find_related (§3.1). **Read strategy**: read_pdf_section theo task (§3.2). **Maintain**: index vs rebuild_index (§6.3) + log. **Prompt mẫu** 2–3 cái (từ research-helper.md). **Invariant**: mọi thay đổi library = re-export XML + index. **Fallback** khi MCP lỗi (§7.3). **Mermaid**: persist flow (từ APPROVAL §12c) | ~150–220 dòng |
| `markitdown-mcp.md` | `research-helper.md` §Paper mới | Stub convert PDF | 1 đoạn vai trò; input/output (`papers/{slug}.raw.md`); gitignore `.raw.md`; link `papers.md` cho luồng đầy đủ; `TODO: chi tiết khi test MarkItDown thật` | ~15–25 dòng (stub) |

### 1.5 `docs/guides/research/` (APPROVAL §3.5 — 7 file, 1 guide/thư mục)

| File | Nội dung nguồn | Sections outline | Mermaid | Cross-ref |
|---|---|---|---|---|
| `00-overview.md` | APPROVAL §3.1–3.3, §3.5 | **Mục đích** `research/`; **4 artifact** (paper/session/insight/writing) + diagram luồng; **git local per project** + auto-commit; **agent rule**: đọc guide trước task; **1 dòng** `tools/pack-share.sh` (defer); link 6 guide còn lại | Có — flowchart 4 artifact | → mọi guide con |
| `readme.md` | APPROVAL §4, §6 | Schema `README.md`: Created, Language, Research purpose (**bắt buộc**), topic, deliverable, citation style, scope, setup notes (EndNote fact ổn định — không path); khi nào tạo (onboarding); single source of truth | Không | → `index-routing.md`, endnote §1.5 |
| `index-routing.md` | APPROVAL §5 | Root INDEX router (~20–40 dòng); 4 sub-INDEX schema (papers/sessions/insights/writing); **bảng load map** (task → file load); **cấm** load đồng thời mọi sub-INDEX | Không | → CLAUDE §J |
| `papers.md` | APPROVAL §3.1, §5.2 + endnote §2–§3 | `papers/` layout; INDEX columns (Title, PDF, Paper note, Sections, Tags, Status, Source, **EndNote ID**, Notes); status flow; luồng PDF→MarkItDown→note→`.ris`→user import→index→verify; paper từ EndNote không cần duplicate PDF (§2.6); dedup DOI first (§2.7) | Có — luồng paper mới (§2 mermaid) | → `endnote-workflow.md`, `endnote-mcp-tools.md` |
| `sessions.md` | APPROVAL §7 | Trigger "docs lại"/"tổng kết"; orchestrator vs subagent; governance tag `[governance:path]`; session note template (frontmatter + sections); mặc định 0 file governance; cập nhật `sessions/INDEX.md` | Có — workflow docs lại (§7 mermaid) | → CLAUDE §D, §E |
| `insights.md` | APPROVAL §3.1, §5.4–5.5 | Mental model vs paper note; insight note schema (frontmatter, Mental model, Evidence, Position, Open questions, Diagrams); INDEX columns; link `papers/foo.md` bắt buộc (§5.1); **không** QUESTIONS.md review loop | Có — ví dụ mindmap/flowchart trong note | Không ref generalization-review |
| `writing.md` | endnote §4 + APPROVAL §3.1 | Prose trong `writing/`; placeholder `[@{endnote_id}]` lúc draft; finalize → `get_citation` + `get_bibliography`; `get_bibtex` chỉ khi LaTeX deliverable; Citation map on-demand (§4.4); cảnh báo cite paper chưa EndNote (§3.3) | Không | → `endnote-mcp-tools.md` Cite group |

### 1.6 `docs/templates/`

| File | Placeholder | Nội dung sinh ra | Cột INDEX / field đặc biệt |
|---|---|---|---|
| `project-README.md.tpl` | `{slug}`, `{date}`, `{purpose}`, `{topic}`, `{language}`, `{deliverable}`, `{citation_style}`, `{scope}`, `{setup_notes}` | `research/{slug}/README.md` | Setup notes: library name, style — không path |
| `project-INDEX-root.md.tpl` | `{slug}`, `{date}` | Root `INDEX.md` router | Bảng 4 area + count 0 |
| `project-INDEX-papers.md.tpl` | `{slug}`, `{date}` | `papers/INDEX.md` | 8 cột incl. **EndNote ID** (deferred-gaps E7) |
| `project-INDEX-sessions.md.tpl` | `{slug}`, `{date}` | `sessions/INDEX.md` | Date, Topic, File, Tags, Status |
| `project-INDEX-insights.md.tpl` | `{slug}`, `{date}` | `insights/INDEX.md` | Title, File, Related papers, Tags, Status |
| `project-INDEX-writing.md.tpl` | `{slug}`, `{date}` | `writing/INDEX.md` | Title, File, Status, Notes |
| `project-.gitignore.tpl` | — | `research/{slug}/.gitignore` | `papers/*.pdf`, `papers/*.raw.md`, `papers/*.ris`, `.DS_Store` (E6) |

Mỗi INDEX tpl: link guide `docs/guides/research/{area}.md` + 2–3 dòng hướng dẫn agent (APPROVAL §3.4).

**Sau render**: `git init` + initial commit trong `research/{slug}/` (APPROVAL §3.3).

### 1.7 `.local/` (gitignore — scaffold schema, không điền path máy thật)

| File | Nguồn | Schema / fields | Giá trị lúc bootstrap |
|---|---|---|---|
| `ENVIRONMENT.md` | agent-memory §3.2, §3.5, APPROVAL §12 #4–5 | `os_profile:` (mac \| windows \| wsl); `markpad_path:`; `research_root:`; `context_mapping_initialized: false`; block comment ví dụ path Mac/Win (không điền thật) | Placeholder + comment |
| `session.md` | APPROVAL §6 + endnote §5.2 | `active_project:`; `session_language:`; `pending_actions:` (list `- [ ] …`) | Rỗng có key |
| `known_projects.txt` | APPROVAL §6 | 1 slug/line | Rỗng hoặc comment `# one slug per line` |
| `claude-agent-summary.md` | agent-memory §3.2, deferred M2 | `last_refresh:`; `active_project:`; `guides_loaded:`; pointer tới `.context/GLOBAL.md` | Template ngắn — refresh khi stale |
| `scripts/scan_research_projects.sh` | APPROVAL §6 | Adapt clinical-ocr `scan_studies.sh`: `research/` thay `data/`, output `ACTION: Hỏi user`, **không** mkdir | Script thật — logic đơn giản |
| `mcp/endnote.md` | endnote §7.4 | 9 field: `xml_export_path`, `sqlite_index_path`, `library_name`, `last_xml_export`, `last_indexed`, `xml_mtime_at_index`, `index_log_path`, `semantic_enabled`, `semantic_miss_count`, `default_citation_style`, `notes` | Key rỗng + comment giải thích từng field |
| `mcp/endnote-index.log` | endnote §1.3, §7.2 | — | Không tạo — tạo khi index lần đầu |
| `mcp/markitdown.md` | APPROVAL §12c | `server_config:` placeholder | Optional stub 3 dòng |

---

## 2. Điểm cần anh xác nhận trước khi ghi

| # | Điểm | Đề xuất mặc định | Nếu gật → hành động khi "viết" | Cần gật hay sửa |
|---|---|---|---|---|
| 1 | `generalization-review-workflow.md` ngoài 0.0.1? | Có — deferred-gaps R1 | `insights.md` không mention QUESTIONS.md; không template review | Gật / đưa vào |
| 2 | `.mcp.json` skeleton dù chưa verify? | Ghi skeleton + TODO | Tạo file với env placeholder; không path thật | Gật / bỏ |
| 3 | `pack-share.sh` chỉ mention, không code? | 1 dòng trong `00-overview.md` | Không tạo `tools/` trong lượt này | Gật |
| 4 | `.context/modules/` rỗng + hướng dẫn trong GLOBAL? | Tạo thư mục rỗng | `mkdir modules/` + đoạn trong GLOBAL | Gật / bỏ hẳn |
| 5 | §6.2 — chốt "không tự động hóa realtime"? | Ghi thẳng vào decision §6 | Đoạn rõ: chỉ re-export + mtime + diff ref count; không hứa sync live | Gật / bàn thêm |

---

## 3. Thứ tự ghi (batch)

| Batch | Thứ tự | File | Lý do |
|---|---|---|---|
| **1** | Đầu tiên | `.context/*` → `CLAUDE.md` → `AGENTS.md` → `.gitignore` | Agent memory + invariant trước; guide/template bám theo |
| **2** | Tiếp | `docs/templates/*.tpl` → `docs/guides/research/*.md` | Template + guide cross-ref nhau |
| **3** | Tiếp | `docs/decisions/endnote-workflow.md` → `docs/guides/mcp/*.md` | Decision trước; MCP guide link decision |
| **4** | Cuối | `.local/*` scaffold → `.mcp.json` | Machine-specific cuối; không lẫn vào commit logic |
| **5** | Một lần (dev) | `context-mapping init.py` trên WSL | APPROVAL §12 #5 — flag `context_mapping_initialized` trong ENVIRONMENT |

---

## 4. Checklist duyệt nhanh (tick trước khi nói "viết")

- [ ] §0 — 12 hạng mục scope đúng ý
- [ ] §1.1–1.7 — ~32 file, outline đủ, không thiếu/thừa
- [ ] §1.6 — `.ris` trong project `.gitignore` (E6)
- [ ] §2 — 5 điểm xác nhận đã trả lời (cột "Cần gật")
- [ ] §3 — đồng ý thứ tự 4 batch + context-mapping WSL

---

*Plan đã thực thi — governance promote xong milestone 0.0.1 bootstrap. Smoke test onboarding còn lại khi user tạo project thật.*

---

## 5. QA findings (Claude, sau khi rà file Grok đã ghi — 2026-07-03)

**Verify**: đã check filesystem, toàn bộ ~32 file trong §1 tồn tại thật, đúng vị trí. Đối chiếu nội dung `.mcp.json`, `docs/guides/mcp/*.md`, `.local/mcp/*.md`:

| # | Thiếu | Nguồn có sẵn trong raws (chưa được carry vào guide) | Nên ghi vào đâu |
|---|---|---|---|
| QA1 | **Cài `uv`/`uvx`** — `.mcp.json` giả định có sẵn, không nói cài từ đâu | — (chưa có trong raws nào, cần bổ sung: `pip install uv` hoặc link astral.sh) | `docs/guides/mcp/endnote-mcp-tools.md` + `markitdown-mcp.md`: thêm mục "## Cài đặt" đầu file, trước "Prerequisite" |
| QA2 | **Cài `endnote-mcp[semantic]`** — optional, cho `search_semantic`/`find_related` | `research-helper.md` §"Những điểm quan trọng cần biết": `uv pip install "endnote-mcp[semantic]"` + `endnote-mcp embed` | `endnote-mcp-tools.md` — mục "## Cài đặt", nhánh optional; liên kết tiêu chí bật semantic đã có trong `endnote-workflow-open-questions.md` §1.6 (BM25 trước, bật khi >100 ref hoặc `semantic_miss_count` chạm ngưỡng) |
| QA3 | **Đăng ký MCP server vào client** — Claude Desktop vs Claude Code đọc config khác nhau, `.mcp.json` hiện tại không giải thích | `endnote-workflow-open-questions.md` §1.7: Claude Desktop → `claude_desktop_config.json` (Mac: `~/Library/Application Support/Claude/`, Win: `%APPDATA%\Claude\`); Claude Code → `.mcp.json` root repo (đã có file, chỉ thiếu giải thích) | Thêm 1 đoạn ngắn trong `00-overview.md` (first-run) hoặc file mới `docs/guides/mcp/setup.md` — tuỳ Grok chọn, không bắt buộc file riêng cho 2 đoạn |
| QA4 | `ENDNOTE_XML_PATH` trong `.mcp.json` là env var — chưa có hướng dẫn set var này ở đâu (`.local/ENVIRONMENT.md`? shell profile?) | Không có trong raws — **gap thật, cần quyết định mới** | Đề xuất: set trong `.local/ENVIRONMENT.md` rồi user export trước khi mở Claude Desktop/Code, hoặc agent đọc từ `.local/mcp/endnote.md` và không dùng env var — **cần chọn 1 trong 2**, không để lửng |

**Đề xuất xử lý QA4** (Claude phản biện, chờ user/Grok chốt): dùng env var cho path cá nhân từng máy là hợp lý (đúng tinh thần "không hard-code path vào governance"), nhưng nếu bác sĩ semi-tech phải tự `export ENDNOTE_XML_PATH=...` trong terminal thì trái persona đã chốt (bác sĩ không mở terminal). Nghiêng về: `.mcp.json` đọc trực tiếp path từ `.local/mcp/endnote.md` (agent ghi lúc onboarding) thay vì đòi env var — nhưng cần verify **kỹ thuật MCP server thật có hỗ trợ đọc path kiểu này không** (E8 — "verify khi setup thật", vẫn treo).

### QA4 — CHỐT (2026-07-03, user chọn phương án B — wrapper script)

**Quyết định**: dùng wrapper script (phương án B trong 4 lựa chọn A/B/C/D đã phân tích trong chat), không dùng env var thô (A), không ghi path thật vào file commit (C), chưa verify D (tool có tự đọc config riêng hay không).

**Phản biện đã áp dụng**: không để wrapper script chỉ nằm trong `.local/` — máy mới / lần đầu clone sẽ mất, phải sinh lại từ đầu (đúng cái user muốn tránh). Tách 2 lớp — code (giống mọi máy) vs state (khác từng máy):

| Lớp | File | Vị trí | Nội dung |
|---|---|---|---|
| **Code (commit)** | `tools/mcp-wrappers/run-endnote-mcp.sh` + `run-endnote-mcp.cmd` (Windows) | Commit — cùng nhóm `tools/pack-share.sh` | Đọc `xml_export_path` từ `.local/mcp/endnote.md` (parse key đơn giản) → `export ENDNOTE_XML_PATH=<value>` → `exec uvx endnote-mcp` |
| **Config trỏ vào wrapper (commit)** | `.mcp.json` | Root, đã tồn tại | Sửa `command`: từ gọi `uvx` trực tiếp → gọi `tools/mcp-wrappers/run-endnote-mcp.sh` (hoặc `.cmd` theo OS — hoặc 1 launcher tự detect OS) |
| **State + rationale nhanh (gitignore)** | `.local/mcp/endnote.md` | Đã có field `notes:` | Không thêm field mới — field `xml_export_path` đã đủ cho wrapper đọc; `notes:` ghi 1 dòng "config qua wrapper, xem docs/decisions/endnote-workflow.md" |
| **Pointer đầu phiên (gitignore)** | `.local/claude-agent-summary.md` | Đã có | Thêm 1 dòng: "MCP endnote-mcp launch qua wrapper `tools/mcp-wrappers/run-endnote-mcp.sh` — xem endnote-workflow.md nếu cần sửa" — để phiên sau đọc summary là biết ngay, không cần đọc lại toàn bộ decision |
| **Quyết định đầy đủ (commit)** | `docs/decisions/endnote-workflow.md` | Thêm subsection mới | "## MCP config resolution" — liệt kê 4 phương án đã cân nhắc (A/B/C/D), lý do chọn B (persona bác sĩ không terminal + giữ `.mcp.json` commit-shaped theo kiến trúc gốc), sơ đồ luồng |

**Việc Grok cần làm**:
1. Viết `tools/mcp-wrappers/run-endnote-mcp.sh` (bash, cho Mac — persona chính) + `.cmd` (Windows, cho dev test)
2. Sửa `.mcp.json` — command trỏ wrapper
3. Thêm subsection "MCP config resolution" vào `docs/decisions/endnote-workflow.md`
4. Thêm 1 dòng pointer vào `.local/mcp/endnote.md` (`notes:`) và `.local/claude-agent-summary.md`
5. **Chưa verify** — vẫn cần dev/Grok chạy thử `uvx endnote-mcp --help` xem có phương án D (tool tự đọc config) đơn giản hơn không; nếu có, đây là thay thế wrapper, ghi tension mới thay vì sửa đè quyết định này

**Việc còn treo cho markitdown**: `markitdown-mcp` không cần path cá nhân (không đọc XML library) — không cần wrapper, giữ nguyên `uvx markitdown-mcp` trực tiếp trong `.mcp.json`. Chỉ endnote-mcp cần lớp này.

**Đã làm — 2026-07-03 (Grok)**: 5 việc QA4 hoàn tất — `tools/mcp-wrappers/run-endnote-mcp.sh` + `.cmd`, `.mcp.json` trỏ wrapper, `endnote-workflow.md` §MCP config resolution, pointer `.local/mcp/endnote.md` + `claude-agent-summary.md`. Verify D: ghi `TENSIONS_OPEN.md` T-001 (`ENDNOTE_MCP_CONFIG` + native yaml; `ENDNOTE_XML_PATH` không tồn tại). Runtime: wrapper sinh `.local/mcp/endnote-mcp-config.yaml`.

---

## 6. QA pass — file Grok đã ghi (Claude, 2026-07-03)

**Kết quả chung**: Đã đọc toàn bộ ~30 file trong `.context/`, `CLAUDE.md`, `AGENTS.md`, `docs/decisions/`, `docs/guides/`, `docs/templates/`, `.local/`. Nội dung bám sát quyết định đã CHỐT trong raws, nhất quán giữa các file, mermaid đầy đủ, relative path trong templates tính đúng. Không có sai lệch kiến trúc so với plan §1.

**2 finding**:

| # | Mức | Vấn đề | Hành động |
|---|---|---|---|
| F1 | **Cần dọn** | `.local/research-helper.md` — bản copy nguyên `docs/raws/research-helper.md` (trùng lặp, sai vị trí — `.local/` chỉ chứa machine-state scaffold, không phải nơi lưu doc; gitignore nên "backup" kiểu này mất khi máy mới) | **Xóa file này** — bản gốc đã có sẵn ở `docs/raws/research-helper.md` |
| F2 | **Việc còn lại, không phải lỗi** | Quyết định QA4 (§5, wrapper script) chốt **sau** khi Grok ghi đợt đầu → `.mcp.json`, `docs/decisions/endnote-workflow.md`, `tools/mcp-wrappers/`, `.local/mcp/endnote.md notes:`, `.local/claude-agent-summary.md` chưa cập nhật theo | Grok làm theo 5 việc đã liệt kê cuối §5 |

*QA không tự sửa 2 điểm trên — chờ Grok xử lý theo vai trò đã phân công.*

**Đã làm — 2026-07-03 (Grok)**:
- **F1**: Đã xóa `.local/research-helper.md`
- **F2**: Đã hoàn QA4 wrapper (chi tiết cuối §5)

**Không phải lỗi Grok** — nằm ngoài phạm vi §1 gốc (plan không liệt kê "cài đặt" như một mục riêng, chỉ có "usage guide" + "`.mcp.json` skeleton"). Ghi nhận là gap mới, không phải sai lệch so với chốt.