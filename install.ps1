# CC - CloudCLI + CC Switch portable one-line installer
# Usage: irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex
param(
    [string]$InstallDir = $(if ($env:CC_INSTALL_DIR) { $env:CC_INSTALL_DIR } else { Join-Path $env:USERPROFILE 'CC' }),
    [string]$Repo = 'KATOUIV/CC',
    [string]$Asset = 'CC-portable.zip'
)

$Version = '1.0.0'

function Get-LatestReleaseAssetUrl {
    param([string]$Repository, [string]$FileName)
    $api = "https://api.github.com/repos/$Repository/releases/latest"
    $headers = @{ 'User-Agent' = 'CC-Portable-Installer' }
    $release = Invoke-RestMethod -Uri $api -Headers $headers
    $asset = $release.assets | Where-Object { $_.name -eq $FileName } | Select-Object -First 1
    if (-not $asset) { throw "Release asset not found: $FileName. Upload it to GitHub Releases first." }
    return $asset.browser_download_url
}

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "CC Portable Installer v$Version" -ForegroundColor Cyan
Write-Host "Install dir: $InstallDir"

$zipUrl = Get-LatestReleaseAssetUrl -Repository $Repo -FileName $Asset
$tmpZip = Join-Path $env:TEMP "CC-portable-$([Guid]::NewGuid().ToString('N')).zip"

Write-Host "Downloading..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $zipUrl -OutFile $tmpZip -UseBasicParsing

if (Test-Path $InstallDir) {
    Write-Host "Folder exists, updating in place: $InstallDir" -ForegroundColor Yellow
} else {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}

Write-Host "Extracting..." -ForegroundColor Cyan
Expand-Archive -Path $tmpZip -DestinationPath $InstallDir -Force
Remove-Item $tmpZip -Force

$setup = Join-Path $InstallDir 'SETUP.bat'
if (-not (Test-Path $setup)) { throw "Invalid package: SETUP.bat missing" }

Write-Host "Running first-time setup..." -ForegroundColor Cyan
& (Join-Path $InstallDir 'install.ps1')

Write-Host ""
Write-Host "INSTALL COMPLETE" -ForegroundColor Green
Write-Host "  Location : $InstallDir"
Write-Host "  Token    : use START-CC-Switch.bat -> add/switch account"
Write-Host "  Launch   : $(Join-Path $InstallDir 'START-CloudCLI.bat')"
Write-Host "  URL      : http://127.0.0.1:3001"
Write-Host ""
