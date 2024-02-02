@echo off

if "%~1"=="" goto usage

git remote remove %1

exit /b

:usage
echo "Usage: gremoterm [remote name]"
