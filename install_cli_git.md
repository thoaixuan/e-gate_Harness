# Cài nhanh e-Gate CLI (1 lệnh, mọi hệ điều hành)

Script tự nhận OS/arch/musl/AVX2 và tải đúng bản trong `dist/`. Không cần chọn file tay.

## macOS / Linux

```bash
curl -fsSL https://github.com/thoaixuan/e-gate_Harness/raw/main/install | bash
```

## Windows (PowerShell)

```powershell
irm https://github.com/thoaixuan/e-gate_Harness/raw/main/install.ps1 | iex
```

## Pin phiên bản cụ thể

```bash
curl -fsSL https://github.com/thoaixuan/e-gate_Harness/raw/main/install | bash -s -- --version 3.0.33
```

```powershell
& ([scriptblock]::Create((irm https://github.com/thoaixuan/e-gate_Harness/raw/main/install.ps1))) -Version 3.0.33
```

## Kiểm tra sau cài

1. Đóng terminal cũ, mở **terminal mới** (hoặc chạy `source ~/.zshrc` trong cửa sổ hiện tại).
   macOS chỉ load `~/.zshrc` khi mở shell mới — cửa sổ mở từ trước lúc cài sẽ vẫn báo
   `zsh: command not found: egatecode` dù file đã có trong `~/.egatecode/bin`.
2. `which -a egatecode` — dòng đầu phải là `~/.egatecode/bin/egatecode` (macOS/Linux)
   hoặc `%USERPROFILE%\.egatecode\bin\egatecode.exe` (Windows).
3. `egatecode --version` — phải ra đúng bản vừa cài.
4. Chạy `egatecode` → chọn `Agent.e-Gate.vn` → nhập API key của bạn → chọn model.

## Port service riêng (không xung đột OpenCode gốc)

Từ bản `3.0.33`, `egatecode` mặc định dùng port service `49474` (OpenCode gốc dùng
`49374`) nên hai bản chạy song song được ngay, không cần sửa gì. Hai bản cũng dùng
thư mục riêng (`~/.config/egatecode` và `~/.config/opencode`) nên không ảnh hưởng
cấu hình của nhau.

Muốn đổi port khác vẫn được:

```bash
egatecode service set port <port>
```

## Ghi chú về bản build

Repo hiện có 5 bản trong `dist/`: `v2.18.30`, `v3.0.29`, `v3.0.30`, `v3.0.31` và `v3.0.33` (mặc định).
Giao diện/logo của bản `v3.0.33` khác OpenCode gốc và có thể khác ảnh minh họa
trong tài liệu — đó là do bản build của repo, không phải do cài đặt sai.
Muốn thử bản cũ:

```bash
curl -fsSL https://github.com/thoaixuan/e-gate_Harness/raw/main/install | bash -s -- --version 2.18.30
```

## Xử lý nhanh khi lỗi

| Hiện tượng | Cách xử lý |
|---|---|
| Báo "already installed" nhưng muốn cài đè | `rm ~/.egatecode/bin/egatecode` rồi chạy lại lệnh cài |
| `egatecode: command not found` | Mở terminal mới; kiểm tra PATH có `~/.egatecode/bin` |
| Chạy nhầm bản cũ (wrapper source) | Xóa/đổi tên `~/.local/bin/egatecode`, chỉ giữ bản trong `~/.egatecode/bin` |
| macOS chặn ("cannot be verified") | `xattr -d com.apple.quarantine ~/.egatecode/bin/egatecode` |
| Windows SmartScreen chặn | Chuột phải file → Properties → **Unblock** → "More info → Run anyway" |
| `Illegal instruction` lúc mở | CPU thiếu AVX2 — cài lại, script sẽ tự chọn bản `-baseline` |
