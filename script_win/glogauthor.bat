@echo off

if "%~1"=="" goto usage

git log --author="%1"

exit /b

:usage
echo "Usage: glogauthor [author]"
