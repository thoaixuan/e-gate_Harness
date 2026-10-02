<#Requires -Version 5.1
<#
.SYNOPSIS
  e-Gate CLI installer for Windows (one command, any Windows 10/11 machine).

.EXAMPLE
  irm https://raw.githubusercontent.com/thoaixuan/e-gate_Harness/main/install.ps1 | iex

.EXAMPLE
  # Install a specific version:
  & ([scriptblock]::Create((irm https://raw.githubusercontent.com/thoaixuan/e-gate_Harness/main/install.ps1))) -Version 2.18.30
#>
param(
  [string]$Version = "",
  [string]$Binary = "",
  [switch]$NoModifyPath
)

$ErrorActionPreference = "Stop"
$App = "egatecode"
$Repo = "thoaixuan/e-gate_Harness"
$BaseUrl = "https://raw.githubusercontent.com/$Repo/main/dist"
$DefaultVersion = "2.18.30"
$InstallDir = Join-Path $HOME ".egatecode\bin"

function Write-Info($msg) { Write-Host $msg }

if ($Binary -ne "") {
  if (-not (Test-Path $Binary)) { throw "Binary not found at $Binary" }
  $specificVersion = "local"
  $installFromBinary = $true
} else {
  $installFromBinary = $false
  $arch = if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") { "arm64" } else { "x64" }

  $target = "windows-$arch"
  if ($arch -eq "x64") {
    # AVX2 = processor feature 40; fall back to -baseline build without it.
    $needsBaseline = $true
    try {
      Add-Type -MemberDefinition '[DllImport("kernel32.dll")] public static extern bool IsProcessorFeaturePresent(int ProcessorFeature);' -Name Kernel32Check -Namespace Win32Check -PassThru | Out-Null
      $needsBaseline = -not [Win32Check.Kernel32Check]::IsProcessorFeaturePresent(40)
    } catch {
      $needsBaseline = $true
    }
    if ($needsBaseline) { $target += "-baseline" }
  }

  $filename = "$App-$target.zip"
  $specificVersion = if ($Version -ne "") { $Version.TrimStart("v") } else { $DefaultVersion }
  $url = "$BaseUrl/v$specificVersion/$filename"

  # Verify the file exists before downloading.
  try {
    $resp = Invoke-WebRequest -Uri $url -Method Head -UseBasicParsing -TimeoutSec 30
    if ($resp.StatusCode -eq 404) { throw "not found" }
  } catch {
    throw "File $filename not found for version v$specificVersion. Available versions: https://github.com/$Repo/tree/main/dist"
  }
}

# Skip reinstall when the requested version is already present.
$existing = Get-Command $App -ErrorAction SilentlyContinue
if ($existing -and -not $installFromBinary) {
  try {
    $installed = (& $App --version 2>$null).Trim()
    if ($installed -eq $specificVersion) {
      Write-Info "Version $specificVersion already installed."
      return
    }
    Write-Info "Installed version: $installed."
  } catch { }
}

New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null

if ($installFromBinary) {
  Write-Info "Installing $App from: $Binary"
  Copy-Item $Binary (Join-Path $InstallDir "$App.exe") -Force
} else {
  Write-Info "Installing $App version: $specificVersion"
  $tmp = Join-Path ([System.IO.Path]::GetTempPath()) "egatecode_install_$PID"
  New-Item -ItemType Directory -Force -Path $tmp | Out-Null
  $zip = Join-Path $tmp $filename
  Invoke-WebRequest -Uri $url -OutFile $zip -UseBasicParsing
  Expand-Archive -Path $zip -DestinationPath $tmp -Force
  Copy-Item (Join-Path $tmp "$App.exe") (Join-Path $InstallDir "$App.exe") -Force
  Remove-Item $tmp -Recurse -Force
}

if (-not $NoModifyPath) {
  $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
  if ($userPath -notmatch [regex]::Escape($InstallDir)) {
    $newPath = ($userPath.TrimEnd(";") + ";" + $InstallDir).TrimStart(";")
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Info "Added $InstallDir to User PATH (open a NEW terminal to use it)."
  } else {
    Write-Info "$InstallDir is already in PATH."
  }
}

Write-Host ""
Write-Host "e-Gate CLI $specificVersion installed. Verify: $App --version"
Write-Host "First run: choose Agent.e-Gate.vn and enter YOUR OWN API key."
Write-Host "Docs: https://github.com/$Repo"
