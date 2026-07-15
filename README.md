# CC - CloudCLI + CC Switch Portable

**Current version: 1.0.1**

## One-line install (PowerShell)

**Private repo:** run `gh auth login` once, then:

```powershell
irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex
```

Or without `irm` (works when repo is private):

```powershell
gh api repos/KATOUIV/CC/contents/install.ps1 --jq .content | ForEach-Object { [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($_ -replace "`n","")) } | Invoke-Expression
```

Custom install path:

```powershell
$env:CC_INSTALL_DIR='D:\CC'; irm https://raw.githubusercontent.com/KATOUIV/CC/main/install.ps1 | iex
```

## After install

1. Open `%USERPROFILE%\CC\START-CC-Switch.bat` and configure API token
2. Run `%USERPROFILE%\CC\START-CloudCLI.bat`
3. Browser: http://127.0.0.1:3001

## Manual download

Download `CC-portable.zip` from [Releases](https://github.com/KATOUIV/CC/releases), extract, run `SETUP.bat`.

## Files (English only, no encoding issues)

| File | Purpose |
|------|---------|
| SETUP.bat | First-time setup |
| START-CloudCLI.bat | Launch web UI |
| START-CC-Switch.bat | Launch CC Switch |
| README.txt | Full guide inside the package |

## Publish new version (maintainer)

1. Update `VERSION` and `CHANGELOG.md`
2. Rebuild `CC-portable.zip` on Desktop
3. Run `login-github.bat` (first time only)
4. Run `publish.ps1`


- `install.ps1` - remote one-line installer (small, in git)
- `CC-portable.zip` - full portable bundle (GitHub Release, not in git)
