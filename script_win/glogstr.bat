@echo off

if "%~1"=="" goto usage

git --no-pager diff %1~1 %1
git log --grep "%1"

exit /b

:usage
echo "Usage: glogstr [search_pattern]"
