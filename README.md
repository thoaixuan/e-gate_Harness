<div align="center">

# ⚡ e-Gate CLI

**One key. Every AI model. Right in your terminal.**

[![version](https://img.shields.io/badge/version-3.0.33-blue)](./dist/v3.0.33)
[![macOS](https://img.shields.io/badge/macOS-arm64%20%7C%20x64-black)](./dist/v3.0.33)
[![Linux](https://img.shields.io/badge/Linux-x64%20%7C%20arm64-orange)](./dist/v3.0.33)
[![Windows](https://img.shields.io/badge/Windows-x64%20%7C%20arm64-blue)](./dist/v3.0.33)

A fully standalone terminal AI coding assistant — no Node.js, Bun or Python
required. One API key from the [e-Gate AI Gateway](https://ai.e-gate.vn)
unlocks every model the gateway supports.

[Get your API key →](https://ai.e-gate.vn)

</div>

---

## ✨ Why e-Gate CLI

- **One key — every model.** GPT, Claude, DeepSeek, Qwen, Gemini-class and
  more through a single `sk-…` key. Switch models mid-conversation.
- **Zero runtime.** A single self-contained binary for macOS, Linux and
  Windows — including low-power CPU (`baseline`) and Alpine (`musl`) builds.
- **Your key stays yours.** Stored only on your machine, never uploaded.
  The binary ships with no keys at all.
- **Always fresh.** `egatecode upgrade` pulls the newest release from this
  repo — config and keys are kept.

## 🚀 Install — one command

The installer detects your OS, architecture, libc (musl) and CPU (AVX2) and
picks the right build automatically.

**macOS / Linux** (bash, zsh, fish…):

```bash
curl -fsSL https://github.com/thoaixuan/e-gate_Harness/raw/main/install | bash
```

**Windows** (PowerShell):

```powershell
irm https://github.com/thoaixuan/e-gate_Harness/raw/main/install.ps1 | iex
```

Install a specific version:

```bash
curl -fsSL https://github.com/thoaixuan/e-gate_Harness/raw/main/install | bash -s -- --version 3.0.33
```

```powershell
& ([scriptblock]::Create((irm https://github.com/thoaixuan/e-gate_Harness/raw/main/install.ps1))) -Version 3.0.33
```

## 🔑 Activate `egatecode` in your terminal

The CLI installs into `~/.egatecode/bin` (Windows:
`%USERPROFILE%\.egatecode\bin`). The installer writes `PATH` into your shell
profile automatically — but your **current** terminal window does not know it
yet.

**Step 1 — open a NEW terminal**, then verify:

```bash
egatecode --version   # → 3.0.33
```

**Step 2 — still `command not found`?** Add `PATH` by hand for the current
session:

**macOS / Linux:**

```bash
export PATH="$HOME/.egatecode/bin:$PATH"
```

To make it permanent, append that line to your `~/.zshrc` (zsh) or
`~/.bashrc` (bash) and restart the terminal.

**Windows (cmd):**

```bat
setx PATH "%PATH%;%USERPROFILE%\.egatecode\bin"
```

Then close and reopen the terminal. (PowerShell users: the installer already
adds it to your **User PATH** — just open a new window.)

**Step 3 — done.** Jump to [Quick start](#-quick-start).

> Prefer picking the binary by hand? See
> [Manual download](#-manual-download) below.

## 🧭 Quick start

1. Run:

   ```bash
   egatecode
   ```

2. The **Gateway** dialog opens on first run — choose `Agent.e-Gate.vn` and
   paste **your own API key**
   ([create one at ai.e-gate.vn](https://ai.e-gate.vn)).
3. The CLI fetches the model list served by your key and shows the picker —
   choose one and start working. Your choice is remembered.

**Everyday commands**

| Do this | How |
|---|---|
| Switch models | `/` → type `model` — the group of your current model stays pinned on top |
| Change your key | `/connect` → gateway → **Set Key · Agent.e-Gate.vn** |
| Use another provider | `/connect` → **Preset** (Anthropic, OpenAI, Google, DeepSeek…) |
| Custom endpoint | Add it to `~/.config/egatecode/egatecode.json` (any OpenAI-compatible base URL + key) |
| Update | `egatecode upgrade` (or `/update` in the TUI) — config and keys are kept |
| Help | `/help` in the TUI · `egatecode --help` in the shell · `egatecode models` lists models |

> The CLI ships with **NO key** — there is no default or demo key in the
> binary. Your key is stored only on your machine and is never uploaded
> anywhere.

## 📦 Manual download

Pick the **ONE** file that matches your computer from
[`dist/v3.0.33`](./dist/v3.0.33):

| Your computer | File |
|---|---|
| **Windows** 10/11 (Intel/AMD) | `egatecode-windows-x64.zip` |
| **Windows** old CPU (no AVX2) | `egatecode-windows-x64-baseline.zip` |
| **Windows** ARM (Surface Pro X…) | `egatecode-windows-arm64.zip` |
| **macOS** Apple Silicon (M1–M4) | `egatecode-darwin-arm64.zip` |
| **macOS** Intel | `egatecode-darwin-x64.zip` |
| **macOS** Intel old CPU (no AVX2) | `egatecode-darwin-x64-baseline.zip` |
| **Linux** x64 — Ubuntu, Debian, Fedora… | `egatecode-linux-x64.tar.gz` |
| **Linux** x64 old CPU (no AVX2) | `egatecode-linux-x64-baseline.tar.gz` |
| **Linux** ARM64 — Raspberry Pi 4/5 | `egatecode-linux-arm64.tar.gz` |
| **Alpine** (musl) x64 / ARM64 / old CPU | `egatecode-linux-{x64|arm64|x64-baseline}-musl.tar.gz` |

File-name terms: **`arm64`** = Apple Silicon / ARM · **`baseline`** = CPUs
without AVX2 (only if the normal build crashes with `Illegal instruction`) ·
**`musl`** = Alpine Linux only.

- **Windows manual:** extract the zip, then double-click `start_fast.bat`
  (included) — it adds the folder to `PATH` and launches the CLI.
- **macOS manual:** unzip to `~/.egatecode/bin`, then
  `xattr -d com.apple.quarantine ~/.egatecode/bin/egatecode` if macOS blocks
  the binary (“developer cannot be verified”).
- **Linux manual:** `tar -xzf egatecode-linux-x64.tar.gz -C ~/.egatecode/bin`.

## 🗂 Config & data

| What | Where |
|---|---|
| Config | `~/.config/egatecode/egatecode.json` |
| Data | `~/.local/share/egatecode` |

e-Gate CLI is fully isolated from any other `opencode` installation —
separate config, data, port and binary name.

## 🛠 Troubleshooting

- **`egatecode: command not found`** →
  [Activate `egatecode` in your terminal](#-activate-egatecode-in-your-terminal).
- **macOS blocks the binary** →
  `xattr -d com.apple.quarantine ~/.egatecode/bin/egatecode`
- **Crash with `Illegal instruction`** → install the **`baseline`** build for
  your CPU.
- **Behind a proxy** → give the background service its address:
  `egatecode service set env HTTPS_PROXY <url>` (and `NO_PROXY` for hosts to
  reach directly).

## 🧹 Uninstall

Delete the folder and the profile line the installer added:

```bash
rm -rf ~/.egatecode ~/.config/egatecode ~/.local/share/egatecode
```

---

<div align="center">

### 🚀 Ready to work faster?

**[ai.e-gate.vn](https://ai.e-gate.vn)** — create your API key, manage models,
top up your wallet and track usage in one place.

*e-Gate — One key, every AI model.*

</div>
