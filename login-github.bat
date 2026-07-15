@echo off
chcp 65001 >nul
title CC - GitHub Login
echo.
echo  ========================================
echo    CC - GitHub Login (one time)
echo  ========================================
echo.
echo  A browser window will open.
echo  Log in with your KATOUIV GitHub account and authorize.
echo.
pause
gh auth login --hostname github.com --git-protocol https --web
if errorlevel 1 (
    echo.
    echo [ERROR] Login failed.
    pause
    exit /b 1
)
echo.
echo Login OK. Now run:
echo   powershell -ExecutionPolicy Bypass -File "%~dp0publish.ps1"
echo.
pause
