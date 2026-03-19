@echo off

if "%~1"=="" goto usage

git log -i --author="%1"

exit /b

:usage
echo "Usage: glogauthor [author]"
