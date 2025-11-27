@echo off
setlocal EnableDelayedExpansion

:: --- Check if a path argument is provided ---
if "%~1"=="" (
    echo [ERROR] No path detected.
    echo Usage: Please drag and drop a folder onto this script, or run it with a path argument.
    pause
    exit /b
)

:: --- Step 1: Get the raw path (remove surrounding quotes) ---
set "RAW_PATH=%~1"

:: --- Step 2: Replace all backslashes "\" with forward slashes "/" ---
:: This keeps the drive letter (e.g., Z:) intact but makes the path Git-compatible.
set "GIT_PATH=!RAW_PATH:\=/!"

:: --- Display information ---
echo ---------------------------------------------------
echo Original Path  : "%RAW_PATH%"
echo Converted Path : "!GIT_PATH!"
echo ---------------------------------------------------

:: --- Execute Git command ---
echo Executing: git config --global --add safe.directory "!GIT_PATH!"
git config --global --add safe.directory "!GIT_PATH!"

if %ERRORLEVEL% equ 0 (
    echo [SUCCESS] Directory added to safe list.
) else (
    echo [FAILURE] An error occurred. Please check if Git is installed correctly.
)

echo.
echo Verification (Current safe.directory entries matching this path):
git config --global --get-all safe.directory | findstr /i /c:"!GIT_PATH!"

echo.
pause