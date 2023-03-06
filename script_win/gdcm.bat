@echo off

if "%~1"=="" goto usage

git --no-pager diff %1~1 %1

exit /b

:usage
echo "Usage: gdcm [commit]"
