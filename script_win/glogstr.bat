@echo off

if "%~1"=="" goto usage

git log --grep "%1"

exit /b

:usage
echo "Usage: glogstr [search_pattern]"
