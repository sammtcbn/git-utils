@echo off

if "%1"=="" (goto usage)
if "%2"=="" (goto usage)

git remote remove %1 %2

exit /b

:usage
echo Usage: gremoteadd [remote name] [remote url]
