@echo off

if "%~1"=="" goto usage

git diff %1~1 %1

exit /b

:usage
echo "Usage: gdcmi [commit]"
