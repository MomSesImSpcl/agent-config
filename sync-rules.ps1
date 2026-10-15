param([switch]$SyncOnly)
$ErrorActionPreference = 'Stop'
$repoRoot = $PSScriptRoot
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }

function Copy-IfDifferent([string]$source, [string]$target) {
    if (-not (Test-Path -LiteralPath $source)) { return }
    $sourceText = [System.IO.File]::ReadAllText($source)
    $targetText = if (Test-Path -LiteralPath $target) { [System.IO.File]::ReadAllText($target) } else { $null }
    if (-not [string]::Equals($sourceText, $targetText, [System.StringComparison]::Ordinal)) {
        $temp = "$target.tmp"
        Copy-Item -LiteralPath $source -Destination $temp -Force
        Move-Item -LiteralPath $temp -Destination $target -Force
    }
}

function Sync-CodexFiles {
    if (-not (Test-Path -LiteralPath $codexHome)) { New-Item -ItemType Directory -Force -Path $codexHome | Out-Null }
    foreach ($name in @('AGENTS.md', 'SHARED.md')) {
        Copy-IfDifferent (Join-Path $repoRoot $name) (Join-Path $codexHome $name)
    }
    # rules/unity.md is both Claude's path-scoped rule and Codex's on-demand skill.
    $skillDir = Join-Path $codexHome 'skills\unity-csharp'
    New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
    Copy-IfDifferent (Join-Path $repoRoot 'rules\unity.md') (Join-Path $skillDir 'SKILL.md')
}

if ($SyncOnly) { Sync-CodexFiles; exit 0 }

if (-not (Get-Command rtk -ErrorAction SilentlyContinue)) { Write-Output 'rtk is not installed on this machine, but rules/rtk.md expects it. Tell the user to follow ~/.claude/setup/rtk.md.' }
$settingsPath = Join-Path $repoRoot 'settings.json'
$settingsText = if (Test-Path -LiteralPath $settingsPath) { Get-Content -Raw $settingsPath } else { '' }
if ($settingsText -notmatch '"ponytail@ponytail"\s*:\s*true') { Write-Output 'The Ponytail plugin is not installed on this machine. Tell the user to follow ~/.claude/setup/ponytail.md.' }
if ($settingsText -notmatch '"caveman@caveman"\s*:\s*true') { Write-Output 'Caveman is not installed on this machine. Tell the user to follow ~/.claude/setup/caveman.md.' }
if ($settingsText -notmatch '"cache-tax@claude-code-mods"\s*:\s*true') { Write-Output 'The Cache Tax plugin is not installed on this machine. Tell the user to follow ~/.claude/setup/cache-tax.md.' }
if ($settingsText -notmatch 'Effort check: before acting') { Write-Output 'The effort hook is not installed on this machine. Tell the user to follow ~/.claude/setup/effort-hook.md.' }
$excludePath = Join-Path $repoRoot '.git\info\exclude'
if (Test-Path -LiteralPath $excludePath) {
    $excludeLines = @(Get-Content -LiteralPath $excludePath)
    foreach ($line in @('!LICENSE', '!rules/', '!rules/**', '!setup/', '!setup/**', '!AGENTS.md', '!SHARED.md', '!sync-rules.ps1')) {
        if ($excludeLines -cnotcontains $line) { Add-Content -LiteralPath $excludePath -Value $line }
    }
}

$stampPath = Join-Path $repoRoot '.git\last-sync'
$now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
$last = 0L
if (Test-Path -LiteralPath $stampPath) { [long]::TryParse((Get-Content -Raw $stampPath).Trim(), [ref]$last) | Out-Null }
if (($now - $last) -ge 21600) {
    $fetch = Start-Process -FilePath 'git' -ArgumentList ('-C "{0}" fetch -q origin' -f $repoRoot) -WindowStyle Hidden -PassThru
    if ($fetch.WaitForExit(15000)) {
        if ($fetch.ExitCode -eq 0) {
            Set-Content -LiteralPath $stampPath -Value $now -NoNewline
            $head = (& git -C $repoRoot rev-parse HEAD 2>$null | Out-String).Trim()
            $upstream = (& git -C $repoRoot rev-parse '@{u}' 2>$null | Out-String).Trim()
            if ($head -and $upstream -and $head -ne $upstream) {
                $dirty = (& git -C $repoRoot status --porcelain | Out-String).Trim()
                $ahead = (& git -C $repoRoot log '@{u}..HEAD' --oneline 2>$null | Out-String).Trim()
                if ($dirty -or $ahead) {
                    Write-Output 'Global rules differ from GitHub but local changes or unpushed commits exist; not pulling. Resolve in ~/.claude.'
                } else {
                    & git -C $repoRoot merge -q --ff-only '@{u}'
                    if ($LASTEXITCODE -eq 0) { Write-Output 'Global rules updated from GitHub; changes apply from the next session.' }
                }
            }
        }
    } else {
        Stop-Process -Id $fetch.Id -Force -ErrorAction SilentlyContinue
    }
}
Sync-CodexFiles