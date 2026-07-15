# CC - GitHub login (use this if login-github.bat fails in Cursor)
$ErrorActionPreference = 'Stop'
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')

Write-Host "CC - GitHub Login" -ForegroundColor Cyan
Write-Host "Browser will open. Log in as KATOUIV and authorize."
Write-Host ""

gh auth login --hostname github.com --git-protocol https --web

Write-Host ""
gh auth status
Write-Host ""
Write-Host "Login OK. Publishing..." -ForegroundColor Green
& (Join-Path $PSScriptRoot 'publish.ps1')
