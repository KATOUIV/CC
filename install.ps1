# CC - CloudCLI + CC Switch portable one-line installer
# Usage: irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex
param(
    [string]$InstallDir = $(if ($env:CC_INSTALL_DIR) { $env:CC_INSTALL_DIR } else { Join-Path $env:USERPROFILE 'CC' }),
    [string]$Repo = 'KATOUIV/CC',
    [string]$AssetName = 'CC-portable.zip'
)

$Version = '1.0.1'

function Get-GhAuthHeaders {
    $headers = @{ 'User-Agent' = 'CC-Portable-Installer' }
    $token = $env:GITHUB_TOKEN
    if ([string]::IsNullOrWhiteSpace($token)) {
        try { $token = (gh auth token 2>$null).Trim() } catch {}
    }
    if (-not [string]::IsNullOrWhiteSpace($token)) {
        $headers['Authorization'] = "Bearer $token"
    }
    return $headers
}

function Get-LatestReleaseAsset {
    param([string]$Repository, [string]$FileName, [hashtable]$Headers)
    $api = "https://api.github.com/repos/$Repository/releases/latest"
    try {
        $release = Invoke-RestMethod -Uri $api -Headers $Headers
    } catch {
        throw "Cannot access GitHub release for $Repository. Check network or set `$env:GITHUB_TOKEN if needed."
    }
    $asset = $release.assets | Where-Object { $_.name -eq $FileName } | Select-Object -First 1
    if (-not $asset) { throw "Release asset not found: $FileName. Upload it to GitHub Releases first." }
    return $asset
}

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "CC Portable Installer v$Version" -ForegroundColor Cyan
Write-Host "Install dir: $InstallDir"

$headers = Get-GhAuthHeaders
$releaseAsset = Get-LatestReleaseAsset -Repository $Repo -FileName $AssetName -Headers $headers
$tmpZip = Join-Path $env:TEMP "CC-portable-$([Guid]::NewGuid().ToString('N')).zip"

Write-Host "Downloading $($releaseAsset.name) ($([math]::Round($releaseAsset.size/1MB,1)) MB)..." -ForegroundColor Cyan
# Prefer browser URL (public); fall back to API asset URL (works with/without token)
$downloadUrl = $releaseAsset.browser_download_url
$downloadHeaders = $headers.Clone()
if ([string]::IsNullOrWhiteSpace($downloadUrl)) {
    $downloadUrl = $releaseAsset.url
    $downloadHeaders['Accept'] = 'application/octet-stream'
}
Invoke-WebRequest -Uri $downloadUrl -Headers $downloadHeaders -OutFile $tmpZip -UseBasicParsing

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
