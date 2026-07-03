# docs/study-case — edge cases & adaptation plans

> Ghi nhận các dự án **không khớp** luồng nghiên cứu học thuật mặc định (PDF → paper note → EndNote), kèm plan adapt tại **cấp project** — không tự sửa governance trừ khi phiên có tag `[governance:...]`.

## Quy ước

| Quy tắc | Mô tả |
|---------|--------|
| Một file / case | `YYYY-MM-DD-{topic-slug}.md` |
| Trạng thái | `draft` → `ready-for-project` → `project-created` |
| Promote | Chỉ human promote insight durable sang `docs/decisions/` hoặc `docs/guides/` |
| Thư mục `research/` | Adapt ghi trong README project; study-case không thay `papers.md` gốc |

## Index

| Date | Case | Status | Tóm tắt |
|------|------|--------|---------|
| 2026-07-03 | [misa-amis-san-xuat-knowledge-translation](2026-07-03-misa-amis-san-xuat-knowledge-translation.md) | `project-created` | `research/amis-docs-digest/` — web ingest, knowledge translation |
| 2026-07-03 | [web-ingest-manifest-token-efficient](2026-07-03-web-ingest-manifest-token-efficient.md) | `manifest-built` | Dựng manifest 83 bài từ helpamis bằng `curl` (tách kéo-về/đọc), sinh guide `web-ingest.md` |