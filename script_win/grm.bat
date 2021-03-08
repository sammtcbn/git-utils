@echo off

if "%~1"=="" goto usage

for %%x in (%*) do (
  if exist %1\* (
    @rem is directory
    git rm -rf %%x
  ) else if exist %1 (
    @rem is file
    git rm %%x
  ) else (
    @rem not exist
    echo %%x not found
  )
)

exit /b

:usage
echo "Usage: grm [file1] [file2] ..."
