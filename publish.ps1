# Publish CC to GitHub (requires: gh auth login)
param(
    [string]$Zip = 'C:\Users\katou\Desktop\CC-portable.zip',
    [switch]$Private
)
$ErrorActionPreference = 'Stop'
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')

$RepoRoot = $PSScriptRoot
$Version = (Get-Content (Join-Path $RepoRoot 'VERSION') -Raw).Trim()
$Tag = "v$Version"

if (-not (Test-Path $Zip)) { throw "Missing zip: $Zip" }
Set-Location $RepoRoot

gh auth status | Out-Null

git add -A
$status = git status --porcelain
if ($status) {
    git commit -m "Release $Tag"
}

$visibility = if ($Private) { '--private' } else { '--public' }
$remotes = @(git remote 2>$null)
if ($remotes -notcontains 'origin') {
    gh repo create CC $visibility --source=. --remote=origin --push --description "CloudCLI + CC Switch portable - one-line install"
} else {
    git push -u origin main
    git tag -a $Tag -m "CC Portable $Tag" -f 2>$null
    if ($LASTEXITCODE -ne 0) { git tag -a $Tag -m "CC Portable $Tag" }
    git push origin $Tag -f
}

$notes = @"
CC Portable $Tag

- English-only filenames (no mojibake)
- CloudCLI + CC Switch + 17 skills + UI plugins
- One-line install: ``irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex``
"@

$existing = $null
try { gh release view $Tag 2>$null | Out-Null; if ($LASTEXITCODE -eq 0) { $existing = $true } } catch {}
if ($existing) {
    gh release upload $Tag $Zip --clobber
    gh release edit $Tag --title "CC $Tag" --notes $notes
    Write-Host "Updated existing release $Tag" -ForegroundColor Yellow
} else {
    gh release create $Tag $Zip --title "CC $Tag" --notes $notes
}

Write-Host ""
Write-Host "Published: https://github.com/KATOUIV/CC/releases/tag/$Tag" -ForegroundColor Green
Write-Host "Install:   irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex" -ForegroundColor Green
