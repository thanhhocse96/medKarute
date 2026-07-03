# Contributing

**MedKarute** (trước đây gọi `research-helper`) không phải sản phẩm đóng gói — governance (`AGENTS.md`, `CLAUDE.md`, `docs/`) là tài liệu sống, đúng đến đâu do có người thật chạy thử và báo lại đến đó. Cảm ơn trước cho ai bỏ thời gian test và cập nhật.

## Cách đóng góp — agent làm hộ, người dùng chỉ duyệt

Người dùng (kể cả không rành kỹ thuật) **không cần tự tay dùng Git**. Quy trình:

### 1. Agent test thật, tự sửa, tự lặp

Agent chạy thử thật trên máy — đặc biệt case chưa smoke-test (xem `.context/TENSIONS_OPEN.md`). Phát hiện sai lệch → tự sửa file → test lại. **Giới hạn: tối đa 3 vòng sửa+test cho cùng 1 vấn đề.** Quá 3 vòng vẫn lỗi → **dừng lại, báo cáo user** đã thử gì/lỗi gì — không tự lặp vô hạn (tốn token, tốn thời gian người dùng chờ).

### 2. Tiêu chí "ổn định" — checklist tối thiểu, không phải "chạy được 1 lần là xong"

- Cài đặt xong (đúng bridge/native theo platform)
- Setup (`endnote-mcp setup` hoặc agent tự ghi config) chạy không lỗi
- `config.yaml` đúng vị trí default platform dir
- `index` chạy thành công (dữ liệu thật hoặc file mẫu)
- MCP handshake (`initialize`) qua stdio trả đúng response
- Ít nhất 1 tool call thật (vd `search_library`) trả kết quả không lỗi
- Tắt/mở lại — config tự nhận diện lại, không hỏi lại từ đầu

Thiếu bất kỳ mục nào → **chưa được tính là ổn định**, chưa qua bước 3.

### 3. Hỏi người dùng trước khi commit — không tự ý

Khi đã ổn định, agent hỏi theo mẫu cố định (không tự bịa mỗi lần):
- Giải thích ngắn: *"PR" (Pull Request) không phải quảng cáo — là cách gửi phần sửa lại cho dự án gốc để người nghiên cứu khác dùng chung*
- Tóm tắt **bằng ngôn ngữ thường**, không thuật ngữ, sửa cái gì / vì sao — vì người dùng review bằng cách **tự chạy thử tính năng** trên máy (thấy chạy được), không đọc diff code
- Kèm theo (không hỏi riêng, làm sẵn): 1 log debug đã **sanitize** (bỏ path cá nhân, tên máy, email...) + mô tả cách sửa, để dev xem lại sau nếu cần

### 4. Người dùng đồng ý → agent tự làm hết

- Tạo **branch riêng** (không commit thẳng `master`/`main`) — agent tự đặt tên, tự xử lý (vd `fix/<platform>-<case>-YYYY-MM-DD`)
- `git commit` + tạo PR
- **Người dùng từ chối** → không sao, không cần lý do — agent giữ nguyên bản đã sửa cục bộ trên máy đó, dùng bình thường, chỉ đơn giản không đẩy PR lên
- **Không có môi trường để commit** (không có git, không có quyền truy cập repo, không có `gh`/mạng, v.v.) → **dừng lại luôn, không cố theo đuổi** (không tự cài git, không tìm cách vòng qua). Báo cho user biết đã sửa xong cục bộ nhưng chưa đẩy lên được, lý do gì — vậy là đủ, agent không có trách nhiệm dựng môi trường commit

### 4b. Nếu gặp edge case — ghi đâu

Chia theo **loại lệch chuẩn** (chốt 2026-07-03):

- **Domain/workflow không khớp** (dự án nghiên cứu không phải PDF/academic — như case MISA AMIS) → ghi vào `docs/study-case/` theo quy ước ở đó
- **Quirk hạ tầng/config trên 1 platform** (như WSL bridge cần `wsl.exe` launcher) → vẫn thuộc `docs/decisions/` + `.context/TENSIONS_*`, **không phải** study-case — tránh study-case phình thành nơi chứa mọi thứ "lạ"
- Vùng xám (vừa domain khác vừa infra khác) — ghi cả 2 chỗ, link nhau, chưa cần quy tắc chặt hơn

**Mở cho agent tự quyết định ghi hay không ghi, PR hay không PR khi gặp gì lạ** — nhưng **duyệt cuối luôn là người dùng** (đúng bước 3: agent hỏi trước khi commit, không tự ý). Agent có thể chủ động đề xuất "cái này nên ghi vào study-case" nhưng không tự merge.

### 5. Tài khoản

Cần tài khoản GitHub để duyệt/nhận PR — người hướng dẫn dự án hỗ trợ tạo 1 lần lúc cần.

## Ghi nhận

Mọi người dùng đã bỏ công chạy thử trên máy thật, báo lỗi, hoặc cập nhật governance — dù chỉ 1 dòng sửa path hay 1 finding nhỏ — đều là đóng góp thật, không kém gì viết code. Governance chính xác hơn sau mỗi lần đó.
