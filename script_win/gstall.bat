@echo off
set currdir=%cd%
IF "%currdir:~-1%"=="\" SET newpath=%currdir:~0,-1%

for /D %%f in (.\*) do (
  cd %currdir%
  echo %%f
  cd %%f
  if exist .git/config (
      git status --short
  )
)

cd %currdir%
