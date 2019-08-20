@echo off

if "%~1"=="" goto noarg

git checkout %1
git branch -l

exit /b

:noarg
git rev-parse --abbrev-ref HEAD
