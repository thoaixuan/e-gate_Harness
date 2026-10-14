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
curl -fsSL https://github.com/thoaixuan/e-gate_Harness/raw/main/install | bash -s -- --version 3.0.29
```

```powershell
& ([scriptblock]::Create((irm https://github.com/thoaixuan/e-gate_Harness/raw/main/install.ps1))) -Version 3.0.29
```

## Kiểm tra sau cài

1. Mở **terminal mới** (để PATH reload).
2. `which -a egatecode` — dòng đầu phải là `~/.egatecode/bin/egatecode` (macOS/Linux)
   hoặc `%USERPROFILE%\.egatecode\bin\egatecode.exe` (Windows).
3. `egatecode --version` — phải ra đúng bản vừa cài.
4. Chạy `egatecode` → chọn `Agent.e-Gate.vn` → nhập API key của bạn → chọn model.

## Xử lý nhanh khi lỗi

| Hiện tượng | Cách xử lý |
|---|---|
| Báo "already installed" nhưng muốn cài đè | `rm ~/.egatecode/bin/egatecode` rồi chạy lại lệnh cài |
| `egatecode: command not found` | Mở terminal mới; kiểm tra PATH có `~/.egatecode/bin` |
| Chạy nhầm bản cũ (wrapper source) | Xóa/đổi tên `~/.local/bin/egatecode`, chỉ giữ bản trong `~/.egatecode/bin` |
| macOS chặn ("cannot be verified") | `xattr -d com.apple.quarantine ~/.egatecode/bin/egatecode` |
| Windows SmartScreen chặn | Chuột phải file → Properties → **Unblock** → "More info → Run anyway" |
| `Illegal instruction` lúc mở | CPU thiếu AVX2 — cài lại, script sẽ tự chọn bản `-baseline` |
