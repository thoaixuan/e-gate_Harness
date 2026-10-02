# e-Gate CLI — Quick Install

[![version](https://img.shields.io/badge/version-2.18.30-blue)](./dist/v2.18.30)
[![macOS](https://img.shields.io/badge/macOS-arm64%20%7C%20x64-black)](./dist/v2.18.30)
[![Linux](https://img.shields.io/badge/Linux-x64%20%7C%20arm64-orange)](./dist/v2.18.30)
[![Windows](https://img.shields.io/badge/Windows-x64%20%7C%20arm64-blue)](./dist/v2.18.30)

> **e-Gate CLI** is a terminal AI coding assistant (a fork of OpenCode).
> One API key from the gateway unlocks every model the gateway supports.
> The binary is fully standalone — no Node.js, Bun, or Python needed.

This repo exists for one purpose: **install e-Gate CLI with a single command on
any OS**. Binaries live in [`dist/`](./dist) (pinned per version, no account or
login required to download).

---

## Quickstart — one command

**macOS / Linux** (bash, zsh, fish…):

```bash
curl -fsSL https://raw.githubusercontent.com/thoaixuan/e-gate_Harness/main/install | bash
```

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/thoaixuan/e-gate_Harness/main/install.ps1 | iex
```

Install a specific version:

```bash
curl -fsSL https://raw.githubusercontent.com/thoaixuan/e-gate_Harness/main/install | bash -s -- --version 2.18.30
```

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/thoaixuan/e-gate_Harness/main/install.ps1))) -Version 2.18.30
```

Verify: `egatecode --version` → prints `2.18.30` (open a **new** terminal first so `PATH` reloads).

---

## Manual download

Pick the **ONE** file that matches your computer. Everything else can be ignored.

| Your computer | Download this file |
|---|---|
| **Windows** 10/11 (Intel/AMD) | `egatecode-windows-x64.zip` |
| **Windows** on old CPU (no AVX2) | `egatecode-windows-x64-baseline.zip` |
| **Windows** ARM (Surface Pro X…) | `egatecode-windows-arm64.zip` |
| **macOS** Apple Silicon (M1/M2/M3/M4) | `egatecode-darwin-arm64.zip` |
| **macOS** Intel | `egatecode-darwin-x64.zip` |
| **macOS** Intel old CPU (no AVX2) | `egatecode-darwin-x64-baseline.zip` |
| **Linux** x64 — Ubuntu, Debian, Fedora, Mint… | `egatecode-linux-x64.tar.gz` |
| **Linux** x64 old CPU (no AVX2) | `egatecode-linux-x64-baseline.tar.gz` |
| **Linux** ARM64 — Raspberry Pi 4/5 | `egatecode-linux-arm64.tar.gz` |
| **Alpine Linux** (musl) x64 | `egatecode-linux-x64-musl.tar.gz` |
| **Alpine Linux** (musl) ARM64 | `egatecode-linux-arm64-musl.tar.gz` |
| **Alpine Linux** old CPU (no AVX2) | `egatecode-linux-x64-baseline-musl.tar.gz` |

File-name terms: **`arm64`** = Apple Silicon / ARM machines · **`baseline`** = old
CPUs without AVX2 (only if the normal build crashes with `Illegal instruction`) ·
**`musl`** = Alpine Linux only.

- **Windows manual:** extract the zip, then double-click `start_fast.bat` (included)
  — it adds the folder to `PATH` and launches the CLI. Or add the folder to `PATH`
  yourself and run `egatecode` from a new terminal.
- **macOS manual:** unzip to `~/.egatecode/bin`, add it to `PATH`. If macOS blocks
  the app (“developer cannot be verified”):
  `xattr -d com.apple.quarantine ~/.egatecode/bin/egatecode`
- **Linux manual:** `tar -xzf egatecode-linux-x64.tar.gz -C ~/.egatecode/bin`,
  add `~/.egatecode/bin` to `PATH`.

---

## First run — enter YOUR OWN key

1. Run `egatecode`.
2. The **Gateway** dialog appears: choose `Agent.e-Gate.vn`.
3. Paste **your own API key** (get one at <https://agent.e-gate.vn>).
4. The CLI fetches the model list and shows the picker **for you to choose**
   (your choice is remembered).

> The CLI ships with **NO key** — there is no default or demo key in the binary.
> Your key is stored only on your machine (see below) and is never uploaded anywhere.

---

## Where config is stored

| What | macOS / Linux | Windows |
|---|---|---|
| Config (`egatecode.json`) | `~/.config/egatecode/` | `%USERPROFILE%\.config\egatecode\` |
| Data (`model.json`, `auth.json`) | `~/.local/share/egatecode/` | `%USERPROFILE%\.local\share\egatecode\` |
| Cache | `~/.cache/egatecode/` | `%USERPROFILE%\.cache\egatecode\` |
| State | `~/.local/state/egatecode/` | `%USERPROFILE%\.local\state\egatecode\` |

---

## Everyday usage

- **Pick a model** — press `/` and type `model`: group **e-Gate AI Gateway** →
  `Agent.e-Gate.vn` lists models grouped by upstream prefix (`e-Gate · package-2`…),
  with the group of your current model pinned on top — plus **Nhập tên model...**
  (type any model id the router serves).
- **Change your key** — `/connect` → gateway → **`Set Key · Agent.e-Gate.vn`**.
- **List all models** — `egatecode models`.
- **Skip the first-run dialog** — press `Esc`, then use `/model` later.

---

## Troubleshooting

| Problem | Fix |
|---|---|
| `egatecode: command not found` | Folder not in `PATH` — open a **new** terminal after installing |
| macOS “cannot be verified” | `xattr -d com.apple.quarantine ~/.egatecode/bin/egatecode` |
| Windows SmartScreen blocks it | Right-click → Properties → **Unblock**; “More info → Run anyway” |
| `Illegal instruction` on startup | Your CPU lacks AVX2 — use the `-baseline` build |
| Wrong/expired key | `/connect` → gateway → `Set Key` → paste the new key |
| Gateway unreachable | Check <https://agent.e-gate.vn> — may be under maintenance |
| Complete reset | Delete the folders above, run first-run again |

---

## Uninstall

- **Windows**: delete `egatecode.exe` (+ `start_fast.bat`), remove the `PATH` entry.
- **macOS / Linux**: `rm ~/.egatecode/bin/egatecode`, remove the `export PATH` line
  from `~/.zshrc` / `~/.bashrc`.
- Optional: delete the config/data folders above to remove all personal data.

---

## Versions

Binaries are pinned per version under [`dist/`](./dist) (`dist/v<version>/`).
The installers default to the latest documented version (`2.18.30`); pass
`--version` / `-Version` to install another one listed there.
