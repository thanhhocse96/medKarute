# MedKarute — Giới thiệu bản cập nhật (2026-07-06)

> Dành cho người nhận file **`medkarute-share-2026-07-06.zip`** — không cần Git.  
> So với bản share trước (~4 Jul 2026).

---

## Tóm tắt một dòng

Bản này thêm **xuất Word từ bản viết Markdown** (skill `md-to-docx`), cập nhật **hướng dẫn sử dụng** và **README**, đồng thời bổ sung quy trình **OCR PDF scan** trong guide papers.

---

## Bạn cần làm gì?

1. **Giải nén** ZIP vào thư mục làm việc (vd. `D:\medkarute`) — có thể **thay thế** bản cũ hoặc giải nén sang folder mới.
2. **Không** copy đè `research/` hoặc `.local/` từ máy cũ nếu bạn đã có dữ liệu nghiên cứu — hai thư mục đó **không nằm trong ZIP** (riêng từng máy).
3. Mở folder trong **Claude Code / Grok / Cursor**, gõ **`bắt đầu`** như trước.
4. Đọc nhanh: `docs/guides/huong-dan-su-dung.md` (đã cập nhật mục xuất Word).

---

## Các phần mới (chưa có ở bản share cũ)

| Phần | Đường dẫn | Là gì |
|------|-----------|--------|
| **Skill xuất Word** | `.agents/skills/md-to-docx/` | Convert `writing/*.md` → `.docx` (bìa, mục lục, V1/V2…). Font mặc định Times New Roman |
| **Agent skills — hướng dẫn** | `.agents/README.md` | Cách các AI (Claude, Grok, Codex) tìm skill trong project |
| **Script đóng gói ZIP** | `tools/pack-share.sh` | Người maintain repo dùng để tạo ZIP share (bạn có thể bỏ qua) |
| **Symlink skill (đã copy thật)** | `.claude/skills/`, `.codex/skills/`, `.grok/skills/` | Cùng nội dung `md-to-docx` — ZIP đã copy sẵn, không cần Git/symlink |

---

## Các file đã cập nhật nội dung

### Cho người nghiên cứu (đọc trước)

| File | Thay đổi chính |
|------|----------------|
| **`docs/guides/huong-dan-su-dung.md`** | Thêm việc **xuất Word**; bảng công cụ MarkItDown / endnote-mcp / md-to-docx; diagram luồng; mẹo YAML front-matter cho bìa Word |
| **`README.md`** (EN) | Bảng Tools & roles: link GitHub MCP + skill md-to-docx |
| **`docs/readme/README.vi.md`** | Bản tiếng Việt tương ứng |

### Cho AI (orchestrator) — không bắt buộc đọc

| File | Thay đổi chính |
|------|----------------|
| **`AGENTS.md`** | Mục **§7 Agent skills** — khi thêm skill mới phải tạo symlink (đã làm sẵn trong ZIP) |
| **`.context/GLOBAL.md`** | Index thêm mục Agent skills |
| **`docs/guides/research/papers.md`** | Thêm luồng **OCR** khi PDF là bản scan (MarkItDown ra text rỗng) |
| **`docs/guides/research/00-overview.md`** | Ghi chú cách tạo ZIP share |
| **`.gitignore`** | Bỏ qua `__pycache__`, `.venv` của skill Python |

### Trong skill `md-to-docx`

| File | Ghi chú |
|------|---------|
| `SKILL.md` | Hướng dẫn agent khi user muốn `.md` → `.docx` |
| `README.md` | Chi tiết kỹ thuật, so sánh upstream |
| `scripts/md_to_docx.py` | Converter chính (Python) |
| `assets/template.docx` | Template Word |

**Upstream tham khảo khi cập nhật sau:**  
[pickle-an/md-to-docx-skill](https://github.com/pickle-an/md-to-docx-skill) (code) ·  
[awesome-copilot SKILL.md](https://github.com/github/awesome-copilot/blob/main/skills/md-to-docx/SKILL.md) (docs)

---

## Cách dùng tính năng mới — xuất Word

Trong chat, ví dụ:

- *"Xuất Word file writing/case-01-….md"*
- *"Convert sang docx"*

AI sẽ chạy skill và tạo file cạnh bản `.md`, ví dụ:

- `case-01_….md` → `case-01_…_V1.docx` (lần đầu)
- Lần sau → `_V2.docx`, `_V3.docx`… (không ghi đè bản cũ)

**Tùy chọn** — thêm đầu file `.md` để bìa đẹp:

```yaml
---
title: Tên đề tài — Tóm tắt
date: 2026-07-06
version: V1
audience: Nhóm nghiên cứu
---
```

---

## Không đổi / không nằm trong ZIP

| Mục | Ghi chú |
|-----|---------|
| **`research/`** | Dữ liệu đề tài của bạn — giữ trên máy cũ |
| **`.local/`** | Cấu hình máy (EndNote path, MCP…) — giữ trên máy cũ |
| **`.mcp.json`** | Copy từ `.mcp.json.tpl` hoặc để AI hướng dẫn lại |
| **EndNote workflow** | Vẫn như cũ: bạn export XML, AI `index` |

---

## Câu hỏi thường gặp

**Có cần cài thêm gì để xuất Word?**  
Không trên máy bạn — AI chạy script Python trong skill. Người maintain cần `python-docx` trong môi trường agent; bạn chỉ cần **Word** để mở file `.docx`.

**Bản cũ và bản mới chạy song song được không?**  
Được, nhưng nên dùng **một folder** để tránh lẫn governance cũ/mới. Dữ liệu `research/` copy sang folder mới nếu cần.

**Gặp lỗi?**  
Nói trong chat — xem mục 5 trong `huong-dan-su-dung.md`.

---

*MedKarute share ZIP · build 2026-07-06 · commit nguồn `6d4e823` + `e816c52`*