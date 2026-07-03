# Guide — INDEX phân tầng

## Vấn đề

Một INDEX chứa hết → phình token mỗi lần load.

## Giải pháp

Router mỏng ở root + sub-INDEX theo thư mục.

## Root `INDEX.md` (~20–40 dòng)

Chỉ bảng 4 area + count + link sub-INDEX. **Không** bảng paper/session chi tiết ở root.

## Sub-INDEX

### `papers/INDEX.md`

| # | Title | PDF | Paper note (.md) | Sections | Tags | Status | Source | EndNote ID | Notes |

- `Status`: `new` / `processed` / `in-endnote` / `linked-insight`
- `Source`: `markitdown` / `endnote-mcp`
- Đường dẫn **relative**

### `sessions/INDEX.md`

| Date | Topic | File | Tags | Status |

### `insights/INDEX.md`

| Title | File | Related papers | Tags | Status |

### `writing/INDEX.md`

| Title | File | Status | Notes |

## Load map

| Task | Load |
|------|------|
| Orientation / phiên mới | `README.md` → root `INDEX.md` |
| Paper ingest / đọc paper | `papers/INDEX.md` (+ 1 paper note nếu cần) |
| Ingest nguồn **web** (không PDF) | [web-ingest.md](web-ingest.md) + `papers/INDEX.md` |
| docs lại | `sessions/INDEX.md` |
| Mental model | `insights/INDEX.md` + [insights.md](insights.md) |
| Soạn section / prose | `writing/INDEX.md` + [writing.md](writing.md) |
| Hướng dẫn user | [00-overview.md](00-overview.md) hoặc trích nhiều guide |

## Cấm

Load đồng thời mọi sub-INDEX + mọi `.md` trong project.