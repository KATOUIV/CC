# Changelog

## [1.0.1] - 2026-07-15

### Fixed
- `.bat` files use CRLF line endings (SETUP.bat works when double-clicked)
- Console mojibake: English-only script output, UTF-8 encoding in PowerShell scripts
- `better-sqlite3` rebuild uses portable Node on PATH during SETUP
- Self-test: prism via `python -m prism`, HTTP wait up to 60s

## [1.0.0] - 2026-07-15

### Added
- CloudCLI + CC Switch portable bundle (English filenames only)
- One-line PowerShell installer (`install.ps1`)
- Auto skill sync (17+ skills), UI plugins enabled
- SETUP.bat self-test on first run

### Fixed
- Removed Chinese/mojibake duplicate filenames (Windows encoding issue)
